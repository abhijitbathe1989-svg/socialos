create index if not exists property_listings_city_country_fk_idx on public.property_listings(city_id,country_code);
create index if not exists property_listings_country_currency_fk_idx on public.property_listings(country_code,currency);
create index if not exists property_service_providers_country_currency_fk_idx on public.property_service_providers(country_code,currency);
create index if not exists property_service_providers_business_fk_idx on public.property_service_providers(business_id);
create index if not exists property_service_providers_category_fk_idx on public.property_service_providers(category_slug);
create index if not exists property_service_providers_owner_fk_idx on public.property_service_providers(owner_id);
