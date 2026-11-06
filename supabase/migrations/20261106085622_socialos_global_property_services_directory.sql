create table if not exists public.property_service_categories(slug text primary key,name text not null,description text not null,enabled boolean not null default true);
create table if not exists public.property_service_providers(
 id uuid primary key default gen_random_uuid(),owner_id uuid not null references auth.users(id) on delete cascade,
 business_id uuid not null references public.business_profiles(id) on delete cascade,
 category_slug text not null references public.property_service_categories(slug),
 country_code char(2) not null references public.global_countries(country_code),city text not null,
 service_areas text[] not null default '{}',provider_name text not null check(char_length(trim(provider_name)) between 2 and 180),
 description text not null default '' check(char_length(description)<=6000),website_url text,public_contact_name text,public_contact_phone text,public_contact_email text,
 currency char(3),starting_price numeric(14,2) check(starting_price is null or starting_price>=0),
 pricing_model text check(pricing_model is null or pricing_model in ('fixed','hourly','percentage','monthly','quote')),
 license_authority text,license_number text,regulatory_reference text,
 verification_status text not null default 'pending' check(verification_status in ('pending','verified','rejected','expired')),
 status text not null default 'draft' check(status in ('draft','pending_review','published','suspended','expired')),
 created_at timestamptz not null default now(),updated_at timestamptz not null default now(),
 constraint property_service_provider_currency_fk foreign key(country_code,currency) references public.global_countries(country_code,currency_code));
alter table public.property_service_categories enable row level security;
alter table public.property_service_providers enable row level security;
create policy property_service_categories_public_read on public.property_service_categories for select to anon,authenticated using(enabled);
create policy property_service_providers_select_workspace on public.property_service_providers for select to authenticated using(private.has_business_permission(business_id,'crm') and private.business_row_owned_by_business(business_id,owner_id));
create policy property_service_providers_insert_workspace on public.property_service_providers for insert to authenticated with check(private.has_business_permission(business_id,'crm') and private.business_row_owned_by_business(business_id,owner_id));
create policy property_service_providers_update_workspace on public.property_service_providers for update to authenticated using(private.has_business_permission(business_id,'crm') and private.business_row_owned_by_business(business_id,owner_id)) with check(private.has_business_permission(business_id,'crm') and private.business_row_owned_by_business(business_id,owner_id));
create policy property_service_providers_delete_workspace on public.property_service_providers for delete to authenticated using(private.has_business_permission(business_id,'crm') and private.business_row_owned_by_business(business_id,owner_id));
create policy property_service_providers_public_verified_read on public.property_service_providers for select to anon using(status='published' and verification_status='verified');
grant select on public.property_service_categories to anon,authenticated;
create view public.published_property_service_providers with (security_invoker=true) as
select id,category_slug,country_code,city,service_areas,provider_name,description,website_url,public_contact_name,public_contact_phone,public_contact_email,currency,starting_price,pricing_model,license_authority,verification_status,created_at
from public.property_service_providers where status='published' and verification_status='verified';
grant select (id,category_slug,country_code,city,service_areas,provider_name,description,website_url,public_contact_name,public_contact_phone,public_contact_email,currency,starting_price,pricing_model,license_authority,verification_status,created_at) on public.property_service_providers to anon;\ngrant select on public.published_property_service_providers to anon,authenticated;
