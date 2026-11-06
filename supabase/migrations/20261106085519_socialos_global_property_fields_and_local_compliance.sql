alter table public.property_listings
 add column if not exists property_stage text not null default 'ready' check(property_stage in ('ready','under_construction','off_plan','pre_launch')),
 add column if not exists tenure_type text check(tenure_type is null or tenure_type in ('freehold','leasehold','condominium','cooperative','strata','commonhold','other')),
 add column if not exists property_condition text check(property_condition is null or property_condition in ('new','excellent','good','fair','needs_renovation','under_construction')),
 add column if not exists energy_rating text,
 add column if not exists regulatory_reference text,
 add column if not exists advertising_permit_number text,
 add column if not exists seller_authority_type text check(seller_authority_type is null or seller_authority_type in ('owner','power_of_attorney','exclusive_mandate','agency_agreement','developer_authorization','other')),
 add column if not exists owner_authority_verified boolean not null default false,
 add column if not exists tax_included boolean,
 add column if not exists service_charge_period text check(service_charge_period is null or service_charge_period in ('monthly','quarterly','yearly')),
 add column if not exists service_charge numeric(14,2) check(service_charge is null or service_charge>=0);
