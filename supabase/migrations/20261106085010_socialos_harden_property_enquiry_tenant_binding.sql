drop policy if exists property_enquiries_insert_workspace on public.property_enquiries;
create policy property_enquiries_insert_workspace on public.property_enquiries
for insert to authenticated
with check (
  private.has_business_permission(property_enquiries.business_id, 'crm')
  and private.business_row_owned_by_business(property_enquiries.business_id, property_enquiries.owner_id)
  and exists (
    select 1 from public.property_listings p
    where p.id = property_enquiries.listing_id
      and p.business_id = property_enquiries.business_id
      and p.owner_id = property_enquiries.owner_id
  )
);