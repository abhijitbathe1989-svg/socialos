-- Append-only tenant audit trail for sensitive user and agent activity.
create table if not exists public.audit_events (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users(id) on delete cascade,
  business_id uuid not null references public.business_profiles(id) on delete cascade,
  actor_type text not null default 'user' check (actor_type in ('user','agent','system')),
  actor_key text,
  event_type text not null check (char_length(event_type) between 2 and 120),
  entity_type text,
  entity_id uuid,
  summary text not null check (char_length(summary) between 1 and 1000),
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);

create index if not exists audit_events_business_created_idx
  on public.audit_events (business_id, created_at desc);
create index if not exists audit_events_entity_idx
  on public.audit_events (business_id, entity_type, entity_id)
  where entity_id is not null;
create index if not exists audit_events_owner_id_idx
  on public.audit_events (owner_id);

alter table public.audit_events enable row level security;
revoke all on public.audit_events from anon;
revoke all on public.audit_events from authenticated;
grant select, insert on public.audit_events to authenticated;

drop policy if exists audit_events_select_own_business on public.audit_events;
create policy audit_events_select_own_business
  on public.audit_events for select to authenticated
  using (
    owner_id = (select auth.uid())
    and exists (
      select 1 from public.business_profiles b
      where b.id = business_id and b.owner_id = (select auth.uid())
    )
  );

drop policy if exists audit_events_insert_own_business on public.audit_events;
create policy audit_events_insert_own_business
  on public.audit_events for insert to authenticated
  with check (
    owner_id = (select auth.uid())
    and exists (
      select 1 from public.business_profiles b
      where b.id = business_id and b.owner_id = (select auth.uid())
    )
  );
