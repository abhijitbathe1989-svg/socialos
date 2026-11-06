# SocialOS Real Estate Marketplace — US + Dubai

## Scope

A two-market property marketplace and broker operating module inside SocialOS. It supports property owners, licensed agents, brokerages, developers and property managers. It is an inventory and lead platform; SocialOS is not itself a real-estate broker, MLS, escrow provider or legal verifier.

### Markets and listing intents

- United States: USD; sale and rent; state, county/city, ZIP, neighborhood and MLS/IDX reference fields.
- Dubai, UAE: AED; sale and rent; Emirate/city, master community, sub-community, building, RERA ORN and DLD advertising-permit references.
- Listing intents: sale, long-term rent, short-term/holiday rent (requires separate local permission), off-plan/new development and commercial leasing.
- Categories: residential, commercial, land, industrial, hospitality and mixed-use.
- Subtypes include apartments/condos, single-family homes, townhouses, villas, multi-family, penthouses, offices, retail, restaurants, warehouses, factories, plots, agricultural land and hotels.

## Listing data captured

Price/currency, rental period, location, bedrooms, bathrooms, built-up and plot area, area unit, parking, year built, floor, total floors, furnishing, availability date, lease term, HOA/service charges, property tax, amenities, photos, description, brokerage, agent licence, public contact, verification state and listing lifecycle. Market-specific compliance references are captured separately. The database enforces USD for US and AED for Dubai and distinguishes sale from rent.

## Pricing recommendation (launch hypothesis, not a claim about competitor list prices)

Use free owner listings to build legitimate supply. Monetize professional agents and brokerages on active inventory, team seats, qualified enquiries and optional visibility. Prices below are initial test prices to validate with interviews and paid pilots; adjust by metro, lead quality, listing volume and conversion.

| Product | United States | Dubai |
|---|---:|---:|
| Verified owner listing | Free | Free |
| Agent Starter | $49/month · up to 10 active listings | AED 199/month · up to 10 active listings |
| Agent Growth | $99/month · up to 40 active listings | AED 399/month · up to 40 active listings |
| Brokerage | $249/month · up to 150 active listings and 5 seats | AED 999/month · up to 150 active listings and 5 seats |
| Featured placement | $19 per listing / 7 days | AED 99 per listing / 7 days |

Do not claim these are the exact market-standard prices. Zillow says Premier Agent pricing varies by market and reports average cost per connection around $139 in non-major metros and $223 in major metros; this is a lead-advertising benchmark, not a listing subscription. Bayut's agent products are package/agency oriented and its public pages do not provide a simple universal per-listing tariff. Start with low-friction pilot pricing and benchmark against direct quotes from local portals before public launch.

No commission on property value is included in the initial SocialOS platform price. Any broker commission remains a separately negotiated client-agent agreement and must follow the applicable local law and brokerage contract. Do not sell or resell enquiries without clear consent.

## Compliance and trust gates

- US: require agent/broker licence details where the state requires licensing; capture seller/landlord authority; respect Fair Housing, state advertising/disclosure rules, TCPA and CAN-SPAM where applicable. MLS/IDX data requires the relevant MLS permissions and feed agreements; never scrape Zillow, Realtor.com or MLS feeds.
- Dubai: require the agent's valid real-estate licence and evidence of authority to advertise; capture RERA ORN and DLD advertising permit references; verify off-plan project approvals before accepting listings. Bayut's terms require licensed agents, authority from the owner, lawful/current listings and one property per listing.
- Owners and agents attest that listing data is accurate, current and lawfully marketable. Expire or withdraw sold/leased inventory promptly.
- Verification must be a separate review step. New records default to draft/pending and cannot appear in public search until both verified and published.
- Public search must use the restricted `published_property_listings` view; never expose internal owner IDs, business IDs, private enquiry data or unverified inventory.
- Public enquiry intake must be server-side with rate limits, bot protection, consent capture, audit events and abuse handling before launch.

## Current implementation

- Supabase tables: `property_listings`, `property_enquiries`, `property_saved_searches`.
- RLS scopes agent inventory and enquiries to the existing SocialOS business workspace and CRM permission.
- A restricted public view exposes only verified, published property attributes.
- The authenticated SocialOS workspace includes a US/Dubai property listing form and inventory manager.
- Listings can be saved as drafts or submitted for review. The UI cannot self-verify or publish listings.
- Public enquiry intake, saved-search alerts, map search, bulk import, photo storage, MLS/IDX integrations, Dubai portal feeds, moderation console and subscription billing are not yet wired end-to-end.
- The current interface stores photo URLs only; production image upload should use a private Supabase Storage bucket with signed upload policies and moderation.

## Delivery sequence

1. Complete backend API validation and automated tests for property listing create/read/update/archive.
2. Add a dedicated public search/browse page with filters, map, property detail pages and consent-based enquiry forms.
3. Build verification/moderation console and expiry workflow.
4. Add media upload, image validation, duplicate detection and property-authority evidence.
5. Add US MLS/IDX partnerships and UAE/Dubai data/portal partnerships only after written permission.
6. Add saved-search alerts, broker analytics and agent/team seats.
7. Activate regional pricing only after paid pilot evidence; live Stripe billing remains disabled until webhook and entitlement checks are complete.

## Market references

- Zillow Premier Agent: https://www.zillow.com/premier-agent/
- Bayut Agent Portal: https://www.bayut.com/agentportal/
- Bayut Terms of Use: https://www.bayut.com/terms.html
