-- SocialOS buyer/renter transaction workflow
-- property_enquiries already exists in the core schema; this migration adds viewing and offer workflows.
create table if not exists public.property_viewings (
 id uuid primary key default gen_random_uuid(),
 listing_id uuid not null references public.property_listings(id) on delete cascade,
 enquiry_id uuid references public.property_enquiries(id) on delete set null,
 requester_id uuid not null references auth.users(id) on delete cascade,
 requested_start timestamptz not null,
 requested_end timestamptz,
 timezone text not null default 'UTC',
 message text,
 status text not null default 'requested' check(status in ('requested','confirmed','rescheduled','completed','cancelled','declined')),
 owner_response text,
 created_at timestamptz not null default now(),
 updated_at timestamptz not null default now(),
 check(requested_end is null or requested_end > requested_start)
);
create index if not exists property_viewings_listing_start_idx on public.property_viewings(listing_id,requested_start);
create index if not exists property_viewings_requester_idx on public.property_viewings(requester_id,created_at desc);
create index if not exists property_viewings_enquiry_id_idx on public.property_viewings(enquiry_id);
alter table public.property_viewings enable row level security;
grant select,insert,update on public.property_viewings to authenticated;
create policy "Viewing participants can read requests" on public.property_viewings for select to authenticated using (
 requester_id=(select auth.uid()) or exists(select 1 from public.property_listings l where l.id=listing_id and l.owner_id=(select auth.uid()))
);
create policy "Signed in users can request a viewing" on public.property_viewings for insert to authenticated with check (
 requester_id=(select auth.uid()) and exists(select 1 from public.property_listings l where l.id=listing_id and l.status='published' and l.verification_status='verified')
);
create policy "Viewing participants can update requests" on public.property_viewings for update to authenticated using (
 requester_id=(select auth.uid()) or exists(select 1 from public.property_listings l where l.id=listing_id and l.owner_id=(select auth.uid()))
) with check (
 requester_id=(select auth.uid()) or exists(select 1 from public.property_listings l where l.id=listing_id and l.owner_id=(select auth.uid()))
);
create table if not exists public.property_offers (
 id uuid primary key default gen_random_uuid(),
 listing_id uuid not null references public.property_listings(id) on delete cascade,
 enquiry_id uuid references public.property_enquiries(id) on delete set null,
 buyer_id uuid not null references auth.users(id) on delete cascade,
 offer_amount numeric(18,2) not null check(offer_amount>0),
 currency char(3) not null,
 proposed_terms text,
 expires_at timestamptz,
 status text not null default 'submitted' check(status in ('submitted','under_review','countered','accepted','rejected','withdrawn','expired')),
 seller_response text,
 created_at timestamptz not null default now(),
 updated_at timestamptz not null default now()
);
create index if not exists property_offers_listing_created_idx on public.property_offers(listing_id,created_at desc);
create index if not exists property_offers_buyer_idx on public.property_offers(buyer_id,created_at desc);
create index if not exists property_offers_enquiry_id_idx on public.property_offers(enquiry_id);
alter table public.property_offers enable row level security;
grant select,insert,update on public.property_offers to authenticated;
create policy "Buyers and listing owners can read offers" on public.property_offers for select to authenticated using (
 buyer_id=(select auth.uid()) or exists(select 1 from public.property_listings l where l.id=listing_id and l.owner_id=(select auth.uid()))
);
create policy "Signed in buyers can submit offers" on public.property_offers for insert to authenticated with check (
 buyer_id=(select auth.uid()) and exists(select 1 from public.property_listings l where l.id=listing_id and l.status='published' and l.verification_status='verified' and l.listing_intent='sale' and l.currency=property_offers.currency)
);
create policy "Buyers may withdraw and owners may respond to offers" on public.property_offers for update to authenticated using (
 buyer_id=(select auth.uid()) or exists(select 1 from public.property_listings l where l.id=listing_id and l.owner_id=(select auth.uid()))
) with check (
 buyer_id=(select auth.uid()) or exists(select 1 from public.property_listings l where l.id=listing_id and l.owner_id=(select auth.uid()))
);
