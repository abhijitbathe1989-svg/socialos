create table if not exists public.property_listings (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users(id) on delete cascade,
  business_id uuid not null references public.business_profiles(id) on delete cascade,
  market_region text not null check (market_region in ('US','DUBAI')),
  country_code char(2) not null check (country_code in ('US','AE')),
  listing_intent text not null check (listing_intent in ('sale','rent')),
  property_category text not null check (property_category in ('residential','commercial','land','industrial','hospitality','mixed_use')),
  property_subtype text not null default 'other' check (char_length(property_subtype) <= 80),
  title text not null check (char_length(trim(title)) between 8 and 180),
  description text not null default '' check (char_length(description) <= 12000),
  address_line1 text, city text not null, state_region text, postal_code text,
  neighborhood text, community text, building_name text,
  latitude double precision check (latitude is null or latitude between -90 and 90),
  longitude double precision check (longitude is null or longitude between -180 and 180),
  price numeric(16,2) not null check (price >= 0),
  currency char(3) not null check (currency in ('USD','AED')),
  rental_period text check (rental_period is null or rental_period in ('daily','weekly','monthly','yearly')),
  security_deposit numeric(16,2) check (security_deposit is null or security_deposit >= 0),
  bedrooms integer check (bedrooms is null or bedrooms between 0 and 100),
  bathrooms numeric(5,2) check (bathrooms is null or bathrooms between 0 and 100),
  area numeric(14,2) check (area is null or area > 0),
  area_unit text not null default 'sqft' check (area_unit in ('sqft','sqm','acre')),
  lot_area numeric(14,2) check (lot_area is null or lot_area > 0),
  parking_spaces integer check (parking_spaces is null or parking_spaces >= 0),
  year_built integer check (year_built is null or year_built between 1600 and 2200),
  floor_number integer, total_floors integer check (total_floors is null or total_floors >= 0),
  furnished_status text check (furnished_status is null or furnished_status in ('furnished','semi_furnished','unfurnished','not_applicable')),
  availability_date date, lease_term_months integer check (lease_term_months is null or lease_term_months between 1 and 600),
  hoa_fee numeric(14,2) check (hoa_fee is null or hoa_fee >= 0),
  property_tax_annual numeric(14,2) check (property_tax_annual is null or property_tax_annual >= 0),
  amenities jsonb not null default '[]'::jsonb check (jsonb_typeof(amenities) = 'array'),
  photo_urls text[] not null default '{}',
  listing_source text not null default 'agent' check (listing_source in ('owner','agent','developer','property_manager')),
  brokerage_name text, agent_license_number text, agent_license_authority text,
  rera_orn text, dld_permit_number text,
  verification_status text not null default 'pending' check (verification_status in ('pending','verified','rejected','expired')),
  status text not null default 'draft' check (status in ('draft','pending_review','published','under_offer','leased','sold','withdrawn','expired')),
  public_contact_name text, public_contact_phone text, public_contact_email text,
  source_listing_url text, expires_at timestamptz,
  created_at timestamptz not null default now(), updated_at timestamptz not null default now(),
  constraint property_market_currency_check check (
    (market_region = 'US' and country_code = 'US' and currency = 'USD') or
    (market_region = 'DUBAI' and country_code = 'AE' and currency = 'AED')
  ),
  constraint property_rental_period_check check (
    (listing_intent = 'sale' and rental_period is null) or
    (listing_intent = 'rent' and rental_period is not null)
  )
);
create index if not exists property_listings_workspace_idx on public.property_listings (business_id, status, created_at desc);
create index if not exists property_listings_market_search_idx on public.property_listings (market_region, listing_intent, property_category, city, price);
create index if not exists property_listings_bedrooms_idx on public.property_listings (bedrooms) where bedrooms is not null;
create index if not exists property_listings_verified_public_idx on public.property_listings (market_region, city, listing_intent, price) where status = 'published' and verification_status = 'verified';
alter table public.property_listings enable row level security;
create policy property_listings_select_workspace on public.property_listings for select to authenticated using (private.has_business_permission(business_id, 'crm') and private.business_row_owned_by_business(business_id, owner_id));
create policy property_listings_insert_workspace on public.property_listings for insert to authenticated with check (private.has_business_permission(business_id, 'crm') and private.business_row_owned_by_business(business_id, owner_id));
create policy property_listings_update_workspace on public.property_listings for update to authenticated using (private.has_business_permission(business_id, 'crm') and private.business_row_owned_by_business(business_id, owner_id)) with check (private.has_business_permission(business_id, 'crm') and private.business_row_owned_by_business(business_id, owner_id));
create policy property_listings_delete_workspace on public.property_listings for delete to authenticated using (private.has_business_permission(business_id, 'crm') and private.business_row_owned_by_business(business_id, owner_id));
create table if not exists public.property_enquiries (
  id uuid primary key default gen_random_uuid(),
  listing_id uuid not null references public.property_listings(id) on delete cascade,
  owner_id uuid not null references auth.users(id) on delete cascade,
  business_id uuid not null references public.business_profiles(id) on delete cascade,
  enquirer_user_id uuid references auth.users(id) on delete set null,
  full_name text not null check (char_length(trim(full_name)) between 2 and 160),
  email text, phone text,
  enquiry_type text not null check (enquiry_type in ('buy','rent','viewing','valuation','other')),
  message text not null default '' check (char_length(message) <= 4000),
  preferred_contact_method text not null default 'email' check (preferred_contact_method in ('email','phone','whatsapp')),
  consent_status text not null default 'unknown' check (consent_status in ('unknown','granted','withdrawn')),
  status text not null default 'new' check (status in ('new','contacted','qualified','viewing_scheduled','offer_made','won','lost','spam')),
  created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);
create index if not exists property_enquiries_workspace_idx on public.property_enquiries (business_id, status, created_at desc);
create index if not exists property_enquiries_listing_idx on public.property_enquiries (listing_id, created_at desc);
alter table public.property_enquiries enable row level security;
create policy property_enquiries_select_workspace on public.property_enquiries for select to authenticated using (private.has_business_permission(business_id, 'crm') and private.business_row_owned_by_business(business_id, owner_id));
create policy property_enquiries_insert_workspace on public.property_enquiries for insert to authenticated with check (private.has_business_permission(business_id, 'crm') and private.business_row_owned_by_business(business_id, owner_id) and exists (select 1 from public.property_listings p where p.id = listing_id and p.business_id = property_enquiries.business_id and p.owner_id = property_enquiries.owner_id));
create policy property_enquiries_update_workspace on public.property_enquiries for update to authenticated using (private.has_business_permission(business_id, 'crm') and private.business_row_owned_by_business(business_id, owner_id)) with check (private.has_business_permission(business_id, 'crm') and private.business_row_owned_by_business(business_id, owner_id));
create table if not exists public.property_saved_searches (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  business_id uuid not null references public.business_profiles(id) on delete cascade,
  name text not null check (char_length(trim(name)) between 2 and 120),
  market_region text not null check (market_region in ('US','DUBAI')),
  filters jsonb not null default '{}'::jsonb check (jsonb_typeof(filters) = 'object'),
  alert_enabled boolean not null default false,
  created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);
create index if not exists property_saved_searches_user_idx on public.property_saved_searches (user_id, business_id);
alter table public.property_saved_searches enable row level security;
create policy property_saved_searches_access on public.property_saved_searches for all to authenticated using (user_id = (select auth.uid()) and private.has_business_permission(business_id, 'crm')) with check (user_id = (select auth.uid()) and private.has_business_permission(business_id, 'crm'));
