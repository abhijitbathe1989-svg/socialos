create policy "agent_tasks_deny_client_access"
on public.agent_tasks
for all
to authenticated
using (false)
with check (false);
