create table public.agent_tasks (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users(id) on delete cascade,
  business_id uuid not null references public.business_profiles(id) on delete cascade,
  created_by uuid references auth.users(id) on delete set null,
  task_type text not null check (task_type ~ '^[a-z][a-z0-9_.-]{1,79}$'),
  payload jsonb not null default '{}'::jsonb check (jsonb_typeof(payload) = 'object'),
  status text not null default 'queued' check (status in ('queued','running','succeeded','failed','cancelled')),
  priority smallint not null default 0 check (priority between -100 and 100),
  attempt_count integer not null default 0 check (attempt_count >= 0),
  max_attempts integer not null default 3 check (max_attempts between 1 and 10),
  idempotency_key text check (idempotency_key is null or char_length(idempotency_key) between 8 and 200),
  available_at timestamptz not null default now(),
  locked_by text,
  lease_expires_at timestamptz,
  started_at timestamptz,
  completed_at timestamptz,
  result_json jsonb not null default '{}'::jsonb check (jsonb_typeof(result_json) = 'object'),
  last_error text check (last_error is null or char_length(last_error) <= 4000),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint agent_tasks_lease_consistency check (
    (status = 'running' and locked_by is not null and lease_expires_at is not null)
    or
    (status <> 'running' and locked_by is null and lease_expires_at is null)
  )
);

create unique index agent_tasks_business_idempotency_uidx
  on public.agent_tasks (business_id, idempotency_key)
  where idempotency_key is not null;

create index agent_tasks_claim_idx
  on public.agent_tasks (status, available_at, priority desc, created_at)
  where status in ('queued','running');

create index agent_tasks_business_created_idx
  on public.agent_tasks (business_id, created_at desc);

alter table public.agent_tasks enable row level security;
revoke all on table public.agent_tasks from public, anon, authenticated;
grant all on table public.agent_tasks to service_role;

create or replace function public.claim_agent_tasks(
  p_worker_id text,
  p_batch_size integer default 5,
  p_lease_seconds integer default 120
)
returns setof public.agent_tasks
language plpgsql
security definer
set search_path = pg_catalog, public, auth
as $$
declare
  v_batch_size integer := least(greatest(coalesce(p_batch_size, 5), 1), 20);
  v_lease_seconds integer := least(greatest(coalesce(p_lease_seconds, 120), 30), 900);
begin
  if coalesce(auth.jwt() ->> 'role', '') <> 'service_role' then
    raise exception 'service role required' using errcode = '42501';
  end if;
  if p_worker_id is null or char_length(btrim(p_worker_id)) < 3 or char_length(p_worker_id) > 120 then
    raise exception 'valid worker id required' using errcode = '22023';
  end if;

  update public.agent_tasks
     set status = 'failed',
         locked_by = null,
         lease_expires_at = null,
         completed_at = now(),
         updated_at = now(),
         last_error = coalesce(last_error, 'Worker lease expired; retry limit exhausted')
   where status = 'running'
     and lease_expires_at <= now()
     and attempt_count >= max_attempts;

  return query
  with picked as (
    select id
      from public.agent_tasks
     where (status = 'queued' and available_at <= now())
        or (status = 'running' and lease_expires_at <= now() and attempt_count < max_attempts)
     order by priority desc, available_at asc, created_at asc
     for update skip locked
     limit v_batch_size
  )
  update public.agent_tasks as task
     set status = 'running',
         attempt_count = task.attempt_count + 1,
         locked_by = p_worker_id,
         lease_expires_at = now() + make_interval(secs => v_lease_seconds),
         started_at = coalesce(task.started_at, now()),
         updated_at = now()
    from picked
   where task.id = picked.id
  returning task.*;
end;
$$;

revoke all on function public.claim_agent_tasks(text, integer, integer) from public, anon, authenticated;
grant execute on function public.claim_agent_tasks(text, integer, integer) to service_role;

comment on table public.agent_tasks is 'Durable, tenant-scoped task queue for SocialOS agent and workflow execution. Worker-only access; no client-side queue access.';
comment on function public.claim_agent_tasks(text, integer, integer) is 'Atomically claims queued or expired-lease tasks with SKIP LOCKED. Service-role only.';
