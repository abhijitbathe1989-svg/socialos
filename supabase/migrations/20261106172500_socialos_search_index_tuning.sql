-- Additional FTS indexes and index-aware ranking for city, provider and service search.
create index if not exists global_cities_search_fts_idx on public.global_cities using gin (public.socialos_search_vector(city_name,admin_area));
create index if not exists property_service_providers_search_fts_idx on public.property_service_providers using gin (public.socialos_search_vector(provider_name,description,city,category_slug)) where status='published' and verification_status='verified';

-- These definitions intentionally align with the GIN expressions from the first search migration.
create or replace function public.search_global_services(p_query text default null,p_category_slug text default null,p_limit integer default 30,p_offset integer default 0)
returns table(service_slug text,category_slug text,service_name text,category_name text,sector text,description text,regulated boolean,relevance real,total_count bigint)
language sql stable security invoker set search_path = ''
as $function$
 with q as (select nullif(left(trim(coalesce(p_query,'')),120),'') term),
 matched as (
  select s.slug,s.category_slug,s.name,c.name cat_name,c.sector,s.description,s.regulated,
   case when q.term is null then 0::real else greatest(
    ts_rank_cd(public.socialos_search_vector(s.name,s.description,s.slug),websearch_to_tsquery('simple',q.term)),
    ts_rank_cd(public.socialos_search_vector(c.name,c.description,c.sector,c.slug),websearch_to_tsquery('simple',q.term))
   ) end score
  from public.global_services s join public.global_service_categories c on c.slug=s.category_slug and c.enabled cross join q
  where s.enabled and (nullif(trim(coalesce(p_category_slug,'')),'') is null or s.category_slug=p_category_slug)
   and (q.term is null or public.socialos_search_vector(s.name,s.description,s.slug) @@ websearch_to_tsquery('simple',q.term)
    or public.socialos_search_vector(c.name,c.description,c.sector,c.slug) @@ websearch_to_tsquery('simple',q.term)
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
    coalesce((select max(ts_rank_cd(public.socialos_search_vector(s.headline,s.details,s.service_slug),websearch_to_tsquery('simple',q.term)))
     from public.marketplace_provider_services s where s.provider_id=p.id and s.is_active),0::real),
    coalesce((select max(ts_rank_cd(public.socialos_search_vector(gs.name,gs.description,gs.slug),websearch_to_tsquery('simple',q.term)))
     from public.marketplace_provider_services s join public.global_services gs on gs.slug=s.service_slug where s.provider_id=p.id and s.is_active),0::real)
   ) end score
  from public.marketplace_providers p cross join q
  where p.verification_status='verified' and p.is_active
   and (nullif(trim(coalesce(p_country_code,'')),'') is null or p.country_code=upper(trim(p_country_code)))
   and (nullif(trim(coalesce(p_city,'')),'') is null or p.city_name ilike '%'||trim(p_city)||'%')
   and exists(select 1 from public.marketplace_provider_services s left join public.global_services gs on gs.slug=s.service_slug
    where s.provider_id=p.id and s.is_active
    and (nullif(trim(coalesce(p_category_slug,'')),'') is null or gs.category_slug=p_category_slug)
    and (nullif(trim(coalesce(p_service_slug,'')),'') is null or s.service_slug=p_service_slug)
    and (q.term is null or public.socialos_search_vector(p.provider_name,p.description,p.city_name,p.provider_type) @@ websearch_to_tsquery('simple',q.term)
     or public.socialos_search_vector(s.headline,s.details,s.service_slug) @@ websearch_to_tsquery('simple',q.term)
     or public.socialos_search_vector(coalesce(gs.name,''),coalesce(gs.description,''),coalesce(gs.slug,'')) @@ websearch_to_tsquery('simple',q.term)
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
   and (q.term is null or public.socialos_search_vector(c.city_name,coalesce(c.admin_area,'')) @@ websearch_to_tsquery('simple',q.term)
    or c.city_name ilike '%'||q.term||'%' or coalesce(c.admin_area,'') ilike '%'||q.term||'%'))
 select m.id,m.country_code,m.city_name,m.admin_area,m.population,m.featured,count(*) over()
 from matched m order by m.featured desc,m.population desc nulls last,m.city_name
 limit least(greatest(coalesce(p_limit,20),1),100) offset least(greatest(coalesce(p_offset,0),0),10000);
$function$;
