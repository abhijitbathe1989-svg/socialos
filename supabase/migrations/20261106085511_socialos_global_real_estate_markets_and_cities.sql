-- Global reference catalogue; seeded launch set is intentionally curated and extensible.
create table if not exists public.global_countries (
 country_code char(2) primary key,country_name text not null,currency_code char(3) not null,currency_symbol text not null,
 default_area_unit text not null check(default_area_unit in ('sqft','sqm')),market_tier text not null default 'tier2' check(market_tier in ('tier1','tier2','tier3')),enabled boolean not null default true,created_at timestamptz not null default now(),unique(country_code,currency_code));
-- Country rows are seeded by the deployment's global-market seed operation; add countries through this reference table.
create table if not exists public.global_cities (
 id uuid primary key default gen_random_uuid(),country_code char(2) not null references public.global_countries(country_code),
 city_name text not null,admin_area text,featured boolean not null default true,enabled boolean not null default true,
 unique(country_code,city_name),unique(id,country_code));
alter table public.global_countries enable row level security;
alter table public.global_cities enable row level security;
drop policy if exists global_countries_public_read on public.global_countries;
create policy global_countries_public_read on public.global_countries for select to anon,authenticated using(enabled);
drop policy if exists global_cities_public_read on public.global_cities;
create policy global_cities_public_read on public.global_cities for select to anon,authenticated using(enabled);
grant select on public.global_countries,public.global_cities to anon,authenticated;
alter table public.property_listings drop constraint if exists property_listings_country_code_check;
alter table public.property_listings drop constraint if exists property_listings_currency_check;
alter table public.property_listings drop constraint if exists property_listings_market_region_check;
alter table public.property_listings drop constraint if exists property_market_currency_check;
update public.property_listings set market_region=country_code::text where market_region='DUBAI';
alter table public.property_listings add constraint property_listings_country_code_fkey foreign key(country_code) references public.global_countries(country_code);
alter table public.property_listings add constraint property_listings_country_currency_fk foreign key(country_code,currency) references public.global_countries(country_code,currency_code);
alter table public.property_listings add column if not exists city_id uuid;
alter table public.property_listings add constraint property_listings_city_country_fk foreign key(city_id,country_code) references public.global_cities(id,country_code);
alter table public.property_listings add constraint property_listings_market_region_country_check check(market_region=country_code::text);
create index if not exists global_cities_country_name_idx on public.global_cities(country_code,city_name);
create index if not exists property_listings_country_city_idx on public.property_listings(country_code,city,listing_intent,price);
