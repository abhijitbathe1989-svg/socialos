-- SocialOS global live search engine.
-- Public search uses invoker-security RPCs and existing RLS policies.
-- The published property view is an intentional security-barrier projection:
-- it exposes only public listing fields and only published + verified rows.
create or replace function public.socialos_search_vector(variadic p_fields text[])
returns tsvector language sql immutable parallel safe set search_path = ''
as $function$
 select to_tsvector('simple',coalesce(array_to_string(p_fields,' '),''));
$function$;
revoke all on function public.socialos_search_vector(text[]) from public;
grant execute on function public.socialos_search_vector(text[]) to anon,authenticated;

create index if not exists global_services_search_fts_idx
 on public.global_services using gin (public.socialos_search_vector(name,description,slug));
create index if not exists global_service_categories_search_fts_idx
 on public.global_service_categories using gin (public.socialos_search_vector(name,description,sector,slug));
create index if not exists marketplace_providers_search_fts_idx
 on public.marketplace_providers using gin (public.socialos_search_vector(provider_name,description,city_name,provider_type));
create index if not exists marketplace_provider_services_search_fts_idx
 on public.marketplace_provider_services using gin (public.socialos_search_vector(headline,details,service_slug));
create index if not exists property_listings_public_search_fts_idx
 on public.property_listings using gin (public.socialos_search_vector(title,description,city,state_region,postal_code,neighborhood,community,building_name))
 where status='published' and verification_status='verified';

alter view public.published_property_listings set (security_invoker = false, security_barrier = true);
comment on view public.published_property_listings is
 'Intentional public security-barrier projection. Exposes only approved public fields for listings with status=published and verification_status=verified. Direct base-table access remains revoked.';
drop policy if exists property_listings_public_verified_read_authenticated on public.property_listings;
create policy property_listings_public_verified_read_authenticated on public.property_listings
 for select to authenticated using (status='published' and verification_status='verified');
revoke select (id, market_region, country_code, listing_intent, property_category, property_subtype,
 title, description, city, state_region, postal_code, neighborhood, community, building_name,
 latitude, longitude, price, currency, rental_period, bedrooms, bathrooms, area, area_unit,
 lot_area, parking_spaces, year_built, floor_number, total_floors, furnished_status,
 availability_date, lease_term_months, amenities, photo_urls, listing_source, brokerage_name,
 agent_license_authority, public_contact_name, public_contact_phone, public_contact_email,
 property_stage, tenure_type, property_condition, service_charge, service_charge_period,
 verification_status, created_at, updated_at) on public.property_listings from anon,authenticated;
revoke select on public.property_listings from anon,authenticated;
grant select on public.published_property_listings to anon,authenticated;

create or replace function public.search_published_property_listings(
 p_country_code text default null,p_listing_intent text default null,p_property_category text default null,p_city text default null,
 p_max_price numeric default null,p_min_bedrooms integer default null,p_property_stage text default null,p_limit integer default 60
)
returns setof public.published_property_listings language sql stable security invoker set search_path = ''
as $function$
 select v.* from public.published_property_listings v
 where (nullif(trim(p_country_code),'') is null or v.country_code=upper(trim(p_country_code)))
 and (nullif(trim(p_listing_intent),'') is null or v.listing_intent=lower(trim(p_listing_intent)))
 and (nullif(trim(p_property_category),'') is null or v.property_category=lower(trim(p_property_category)))
 and (nullif(trim(p_city),'') is null or v.city ilike '%'||trim(p_city)||'%')
 and (p_max_price is null or (p_max_price>=0 and v.price<=p_max_price))
 and (p_min_bedrooms is null or (p_min_bedrooms>=0 and v.bedrooms>=p_min_bedrooms))
 and (nullif(trim(p_property_stage),'') is null or v.property_stage=lower(trim(p_property_stage)))
 order by v.created_at desc limit least(greatest(coalesce(p_limit,60),1),100);
$function$;
revoke all on function public.search_published_property_listings(text,text,text,text,numeric,integer,text,integer) from public;
grant execute on function public.search_published_property_listings(text,text,text,text,numeric,integer,text,integer) to anon,authenticated;

create or replace function public.search_global_services(p_query text default null,p_category_slug text default null,p_limit integer default 30,p_offset integer default 0)
returns table(service_slug text,category_slug text,service_name text,category_name text,sector text,description text,regulated boolean,relevance real,total_count bigint)
language sql stable security invoker set search_path = ''
as $function$
 with q as (select nullif(left(trim(coalesce(p_query,'')),120),'') term),
 matched as (
  select s.slug,s.category_slug,s.name,c.name cat_name,c.sector,s.description,s.regulated,
   case when q.term is null then 0::real else ts_rank_cd(public.socialos_search_vector(s.name,s.description,s.slug,c.name,c.sector),websearch_to_tsquery('simple',q.term)) end score
  from public.global_services s join public.global_service_categories c on c.slug=s.category_slug and c.enabled cross join q
  where s.enabled and (nullif(trim(coalesce(p_category_slug,'')),'') is null or s.category_slug=p_category_slug)
   and (q.term is null or public.socialos_search_vector(s.name,s.description,s.slug,c.name,c.sector) @@ websearch_to_tsquery('simple',q.term)
    or concat_ws(' ',s.name,s.description,s.slug,c.name,c.sector) ilike '%'||q.term||'%')
 )
 select m.slug,m.category_slug,m.name,m.cat_name,m.sector,m.description,m.regulated,m.score,count(*) over()
 from matched m order by m.score desc,m.cat_name,m.name
 limit least(greatest(coalesce(p_limit,30),1),100) offset least(greatest(coalesce(p_offset,0),0),10000);
$function$;

create or replace function public.search_marketplace_providers(p_query text default null,p_country_code text default null,p_city text default null,p_category_slug text default null,p_service_slug text default null,p_limit integer default 20,p_offset integer default 0)
returns table(provider_id uuid,provider_name text,provider_type text,description text,country_code character(2),city_name text,website_url text,contact_email text,contact_phone text,services jsonb,relevance real,total_count bigint)
language sql stable security invoker set search_path = ''
as $function$
 with q as (select nullif(left(trim(coalesce(p_query,'')),120),'') term),
 matched as (
  select p.id,p.provider_name,p.provider_type,p.description,p.country_code,p.city_name,p.website_url,p.contact_email,p.contact_phone,
   case when q.term is null then 0::real else greatest(
    ts_rank_cd(public.socialos_search_vector(p.provider_name,p.description,p.city_name,p.provider_type),websearch_to_tsquery('simple',q.term)),
    coalesce((select max(ts_rank_cd(public.socialos_search_vector(s.headline,s.details,s.service_slug,gs.name),websearch_to_tsquery('simple',q.term)))
     from public.marketplace_provider_services s left join public.global_services gs on gs.slug=s.service_slug where s.provider_id=p.id and s.is_active),0::real)
   ) end score
  from public.marketplace_providers p cross join q
  where p.verification_status='verified' and p.is_active
   and (nullif(trim(coalesce(p_country_code,'')),'') is null or p.country_code=upper(trim(p_country_code)))
   and (nullif(trim(coalesce(p_city,'')),'') is null or p.city_name ilike '%'||trim(p_city)||'%')
   and exists(select 1 from public.marketplace_provider_services s left join public.global_services gs on gs.slug=s.service_slug
    where s.provider_id=p.id and s.is_active
    and (nullif(trim(coalesce(p_category_slug,'')),'') is null or gs.category_slug=p_category_slug)
    and (nullif(trim(coalesce(p_service_slug,'')),'') is null or s.service_slug=p_service_slug)
    and (q.term is null or public.socialos_search_vector(p.provider_name,p.description,p.city_name,p.provider_type,s.headline,s.details,s.service_slug,gs.name,gs.description) @@ websearch_to_tsquery('simple',q.term)
     or concat_ws(' ',p.provider_name,p.description,p.city_name,p.provider_type,s.headline,s.details,s.service_slug,gs.name,gs.description) ilike '%'||q.term||'%'))
 )
 select m.id,m.provider_name,m.provider_type,m.description,m.country_code,m.city_name,m.website_url,m.contact_email,m.contact_phone,
  coalesce((select jsonb_agg(jsonb_build_object('id',s.id,'service_slug',s.service_slug,'headline',s.headline,'details',s.details,'price_from',s.price_from,'price_currency',s.price_currency,'is_active',s.is_active,'global_services',jsonb_build_object('name',gs.name,'category_slug',gs.category_slug)) order by gs.name)
   from public.marketplace_provider_services s left join public.global_services gs on gs.slug=s.service_slug
   where s.provider_id=m.id and s.is_active
    and (nullif(trim(coalesce(p_category_slug,'')),'') is null or gs.category_slug=p_category_slug)
    and (nullif(trim(coalesce(p_service_slug,'')),'') is null or s.service_slug=p_service_slug)),'[]'::jsonb),
  m.score,count(*) over()
 from matched m order by m.score desc,m.provider_name,m.id
 limit least(greatest(coalesce(p_limit,20),1),50) offset least(greatest(coalesce(p_offset,0),0),10000);
$function$;

create or replace function public.search_published_property_listings_v2(
 p_country_code text default null,p_listing_intent text default null,p_property_category text default null,p_city text default null,
 p_max_price numeric default null,p_min_bedrooms integer default null,p_property_stage text default null,p_query text default null,p_limit integer default 60,p_offset integer default 0
)
returns setof public.published_property_listings language sql stable security invoker set search_path = ''
as $function$
 with q as (select nullif(left(trim(coalesce(p_query,'')),120),'') term)
 select v.* from public.published_property_listings v cross join q
 where (nullif(trim(coalesce(p_country_code,'')),'') is null or v.country_code=upper(trim(p_country_code)))
 and (nullif(trim(coalesce(p_listing_intent,'')),'') is null or v.listing_intent=lower(trim(p_listing_intent)))
 and (nullif(trim(coalesce(p_property_category,'')),'') is null or v.property_category=lower(trim(p_property_category)))
 and (nullif(trim(coalesce(p_city,'')),'') is null or v.city ilike '%'||trim(p_city)||'%')
 and (p_max_price is null or (p_max_price>=0 and v.price<=p_max_price))
 and (p_min_bedrooms is null or (p_min_bedrooms>=0 and v.bedrooms>=p_min_bedrooms))
 and (nullif(trim(coalesce(p_property_stage,'')),'') is null or v.property_stage=lower(trim(p_property_stage)))
 and (q.term is null or public.socialos_search_vector(v.title,v.description,v.city,v.state_region,v.postal_code,v.neighborhood,v.community,v.building_name) @@ websearch_to_tsquery('simple',q.term)
  or concat_ws(' ',v.title,v.description,v.city,v.state_region,v.postal_code,v.neighborhood,v.community,v.building_name) ilike '%'||q.term||'%')
 order by case when q.term is null then 0::real else ts_rank_cd(public.socialos_search_vector(v.title,v.description,v.city,v.state_region,v.postal_code,v.neighborhood,v.community,v.building_name),websearch_to_tsquery('simple',q.term)) end desc,v.created_at desc
 limit least(greatest(coalesce(p_limit,60),1),100) offset least(greatest(coalesce(p_offset,0),0),10000);
$function$;

create or replace function public.search_published_property_service_providers(p_country_code text default null,p_category_slug text default null,p_city text default null,p_query text default null,p_limit integer default 30,p_offset integer default 0)
returns setof public.published_property_service_providers language sql stable security invoker set search_path = ''
as $function$
 with q as (select nullif(left(trim(coalesce(p_query,'')),120),'') term)
 select v.* from public.published_property_service_providers v cross join q
 where (nullif(trim(coalesce(p_country_code,'')),'') is null or v.country_code=upper(trim(p_country_code)))
 and (nullif(trim(coalesce(p_category_slug,'')),'') is null or v.category_slug=p_category_slug)
 and (nullif(trim(coalesce(p_city,'')),'') is null or v.city ilike '%'||trim(p_city)||'%')
 and (q.term is null or public.socialos_search_vector(v.provider_name,v.description,v.city,v.category_slug) @@ websearch_to_tsquery('simple',q.term)
  or concat_ws(' ',v.provider_name,v.description,v.city,v.category_slug) ilike '%'||q.term||'%')
 order by case when q.term is null then 0::real else ts_rank_cd(public.socialos_search_vector(v.provider_name,v.description,v.city,v.category_slug),websearch_to_tsquery('simple',q.term)) end desc,v.created_at desc
 limit least(greatest(coalesce(p_limit,30),1),100) offset least(greatest(coalesce(p_offset,0),0),10000);
$function$;

create or replace function public.search_global_cities(p_query text default null,p_country_code text default null,p_limit integer default 20,p_offset integer default 0)
returns table(city_id uuid,country_code character(2),city_name text,admin_area text,population bigint,featured boolean,total_count bigint)
language sql stable security invoker set search_path = ''
as $function$
 with q as (select nullif(left(trim(coalesce(p_query,'')),100),'') term),
 matched as (select c.id,c.country_code,c.city_name,c.admin_area,c.population,c.featured from public.global_cities c cross join q
  where c.enabled and (nullif(trim(coalesce(p_country_code,'')),'') is null or c.country_code=upper(trim(p_country_code)))
   and (q.term is null or c.city_name ilike '%'||q.term||'%' or coalesce(c.admin_area,'') ilike '%'||q.term||'%'))
 select m.id,m.country_code,m.city_name,m.admin_area,m.population,m.featured,count(*) over()
 from matched m order by m.featured desc,m.population desc nulls last,m.city_name
 limit least(greatest(coalesce(p_limit,20),1),100) offset least(greatest(coalesce(p_offset,0),0),10000);
$function$;

revoke all on function public.search_global_services(text,text,integer,integer) from public;
revoke all on function public.search_marketplace_providers(text,text,text,text,text,integer,integer) from public;
revoke all on function public.search_published_property_listings_v2(text,text,text,text,numeric,integer,text,text,integer,integer) from public;
revoke all on function public.search_published_property_service_providers(text,text,text,text,integer,integer) from public;
revoke all on function public.search_global_cities(text,text,integer,integer) from public;
grant execute on function public.search_global_services(text,text,integer,integer) to anon,authenticated;
grant execute on function public.search_marketplace_providers(text,text,text,text,text,integer,integer) to anon,authenticated;
grant execute on function public.search_published_property_listings_v2(text,text,text,text,numeric,integer,text,text,integer,integer) to anon,authenticated;
grant execute on function public.search_published_property_service_providers(text,text,text,text,integer,integer) to anon,authenticated;
grant execute on function public.search_global_cities(text,text,integer,integer) to anon,authenticated;
