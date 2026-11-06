drop view if exists public.published_property_listings;
create policy property_listings_public_verified_read on public.property_listings for select to anon using (status = 'published' and verification_status = 'verified');
create or replace view public.published_property_listings with (security_invoker = true) as
select id, market_region, country_code, listing_intent, property_category, property_subtype,
title, description, city, state_region, postal_code, neighborhood, community, building_name,
latitude, longitude, price, currency, rental_period, bedrooms, bathrooms, area, area_unit,
lot_area, parking_spaces, year_built, floor_number, total_floors, furnished_status,
availability_date, lease_term_months, amenities, photo_urls, listing_source, brokerage_name,
agent_license_authority, verification_status, created_at, updated_at
from public.property_listings where status = 'published' and verification_status = 'verified';
grant select (id, market_region, country_code, listing_intent, property_category, property_subtype,
title, description, city, state_region, postal_code, neighborhood, community, building_name,
latitude, longitude, price, currency, rental_period, bedrooms, bathrooms, area, area_unit,
lot_area, parking_spaces, year_built, floor_number, total_floors, furnished_status,
availability_date, lease_term_months, amenities, photo_urls, listing_source, brokerage_name,
agent_license_authority, verification_status, created_at, updated_at) on public.property_listings to anon;
grant select on public.published_property_listings to anon, authenticated;
create index if not exists property_listings_owner_id_idx on public.property_listings(owner_id);
create index if not exists property_enquiries_owner_id_idx on public.property_enquiries(owner_id);
create index if not exists property_enquiries_enquirer_user_id_idx on public.property_enquiries(enquirer_user_id);
create index if not exists property_saved_searches_business_id_idx on public.property_saved_searches(business_id);
