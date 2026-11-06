create or replace function public.search_published_property_listings(
 p_country_code text default null,
 p_listing_intent text default null,
 p_property_category text default null,
 p_city text default null,
 p_max_price numeric default null,
 p_min_bedrooms integer default null,
 p_property_stage text default null,
 p_limit integer default 60
)
returns setof public.published_property_listings
language sql
stable
security definer
set search_path = ''
as $function$
 select v.*
 from public.published_property_listings v
 where (nullif(trim(p_country_code), '') is null or v.country_code = upper(trim(p_country_code)))
   and (nullif(trim(p_listing_intent), '') is null or v.listing_intent = lower(trim(p_listing_intent)))
   and (nullif(trim(p_property_category), '') is null or v.property_category = lower(trim(p_property_category)))
   and (nullif(trim(p_city), '') is null or v.city ilike '%' || trim(p_city) || '%')
   and (p_max_price is null or (p_max_price >= 0 and v.price <= p_max_price))
   and (p_min_bedrooms is null or (p_min_bedrooms >= 0 and v.bedrooms >= p_min_bedrooms))
   and (nullif(trim(p_property_stage), '') is null or v.property_stage = lower(trim(p_property_stage)))
 order by v.created_at desc
 limit least(greatest(coalesce(p_limit, 60), 1), 100);
$function$;
comment on function public.search_published_property_listings(text,text,text,text,numeric,integer,text,integer) is
'Intentional public SECURITY DEFINER search RPC. It exposes only the fixed published_property_listings projection, whose view filters status=published and verification_status=verified. The underlying property_listings table and view are not directly granted to anon; search parameters are values only and result count is capped at 100.';
