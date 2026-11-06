# SocialOS Global Real Estate Marketplace

## Scope

A global, multi-country property marketplace and broker operating module inside SocialOS. The database now has a country/currency reference model and a curated launch set of 73 countries and 191 major cities. The schema accepts future country and city additions without a redesign. This is not yet a complete 195-country gazetteer or an exhaustive city database; non-seeded localities can still be entered as free-text while the reference catalogue is expanded. It supports property owners, licensed agents, brokerages, developers and property managers. It is an inventory and lead platform; SocialOS is not itself a real-estate broker, MLS, escrow provider or legal verifier.

### Initial country and city coverage

54 country markets are enabled with local currency and default area units: United States, Canada, United Kingdom, Ireland, France, Germany, Netherlands, Belgium, Switzerland, Austria, Spain, Portugal, Italy, Luxembourg, Denmark, Sweden, Norway, Finland, Iceland, Poland, Czechia, Hungary, Romania, Greece, Croatia, Bulgaria, Estonia, Latvia, Lithuania, Cyprus, Malta, United Arab Emirates, Saudi Arabia, Qatar, Kuwait, Bahrain, Oman, India, Singapore, Hong Kong, Japan, South Korea, Australia, New Zealand, Thailand, Malaysia, Indonesia, Philippines, Türkiye, Israel, South Africa, Brazil, Mexico and Chile.

The 154 curated cities include New York, Los Angeles, Miami, San Francisco, Chicago, Houston, Dallas, Austin, Seattle, Boston, Toronto, Vancouver, London, Manchester, Birmingham, Paris, Berlin, Munich, Amsterdam, Zurich, Madrid, Barcelona, Milan, Rome, Dubai, Abu Dhabi, Riyadh, Doha, Singapore, Hong Kong, Tokyo, Seoul, Sydney, Melbourne, Auckland, Mumbai, Pune, Bengaluru, Delhi NCR, Hyderabad, Chennai, Kolkata, Ahmedabad, Surat, Jaipur, Nagpur, Nashik, Thane, Navi Mumbai, Kochi, Indore, Bhopal, Lucknow, Chandigarh and Nanded/Nandura, plus other seeded regional hubs. City names remain editable and additional localities can be added to the catalogue.

- Each country has an ISO country code, currency code/symbol, default area unit and market tier.
- Market region is now the country ISO code; price currency is constrained by a composite country/currency foreign key.
- US: USD; state, county/city, ZIP, neighborhood and MLS/IDX reference fields.
- UAE: AED; Emirate/city, master community, sub-community, building, RERA ORN and DLD advertising-permit references.
- India: INR; state/city, PIN code and state RERA agent/project registration references.
- UK and EU markets use local currencies and capture local regulator, licensing, redress, tax and privacy references as applicable.
- Listing intents: sale, long-term rent, short-term/holiday rent (requires separate local permission), off-plan/new development and commercial leasing.
- Categories: residential, commercial, land, industrial, hospitality and mixed-use.
- Subtypes include apartments/condos, single-family homes, townhouses, villas, multi-family, penthouses, offices, retail, restaurants, warehouses, factories, plots, agricultural land and hotels.

## Listing data captured

Price/currency, rental period, location, bedrooms, bathrooms, built-up and plot area, area unit, parking, year built, floor, total floors, furnishing, availability date, lease term, HOA/service charges, property tax, amenities, photos, description, brokerage, agent licence, public contact, verification state and listing lifecycle. Market-specific compliance references are captured separately. Global fields include property stage (ready, under construction, off-plan, pre-launch), tenure type, condition, service charges, regulatory references, advertising permits and seller/landlord authority type. The database enforces USD for US and AED for Dubai and distinguishes sale from rent.

## Global pricing recommendation (launch hypothesis, not a claim about competitor list prices)

Use free owner listings to build legitimate supply. Monetize professional agents and brokerages on active inventory, team seats, qualified enquiries and optional visibility. Local prices below are test prices for a lean self-serve SaaS product; validate with paid pilots, tax treatment, portal/media costs and willingness-to-pay by metro. Do not label these as competitor tariffs or a universal market standard.

| Product | United States | Dubai |
|---|---:|---:|
| Verified owner listing | Free | Free |
| Agent Starter | $49/month · up to 10 active listings | AED 199/month · up to 10 active listings |
| Agent Growth | $99/month · up to 40 active listings | AED 399/month · up to 40 active listings |
| Brokerage | $249/month · up to 150 active listings and 5 seats | AED 999/month · up to 150 active listings and 5 seats |
| Featured placement | $19 per listing / 7 days | AED 79 per listing / 7 days |

Indicative local price cards for additional launch markets:

| Market | Starter | Growth | Brokerage |
|---|---:|---:|---:|
| India | ₹999/month | ₹2,499/month | ₹6,999/month |
| United Kingdom | £29/month | £69/month | £199/month |
| Eurozone | €29/month | €69/month | €199/month |
| Canada | C$55/month | C$119/month | C$329/month |
| Australia / New Zealand | A$59/month | A$129/month | A$349/month |
| Singapore | S$49/month | S$109/month | S$299/month |
| Saudi Arabia | SAR 149/month | SAR 349/month | SAR 899/month |
| Other supported markets | Tiered local-currency equivalent | Tiered local-currency equivalent | Tiered local-currency equivalent |

Do not claim these are the exact market-standard prices. Zillow says Premier Agent pricing varies by market and reports average cost per connection around $139 in non-major metros and $223 in major metros; this is a lead-advertising benchmark, not a listing subscription. Bayut's agent products are package/agency oriented and its public pages do not provide a simple universal per-listing tariff. Start with low-friction pilot pricing and benchmark against direct quotes from local portals before public launch.

No commission on property value is included in the initial SocialOS platform price. Any broker commission remains a separately negotiated client-agent agreement and must follow the applicable local law and brokerage contract. Do not sell or resell enquiries without clear consent.

## Global property services directory

The platform now has a verified provider directory taxonomy with 25 categories: residential brokerage, rentals/leasing, commercial brokerage, land brokerage, property management, holiday-home management, developer/off-plan sales, valuation/appraisal, mortgage/finance referrals, legal/conveyancing, title due diligence, inspections/surveying, architecture/planning, interior design, construction/renovation, maintenance/repairs, cleaning/facilities, moving/relocation, photography/virtual tours, home staging, insurance, tax/accounting, investment advisory, facility management and tenant screening. Provider profiles are country/city-specific, use local currency, and require review before public visibility.

## Compliance and trust gates

- US: require agent/broker licence details where the state requires licensing; capture seller/landlord authority; respect Fair Housing, state advertising/disclosure rules, TCPA and CAN-SPAM where applicable. MLS/IDX data requires the relevant MLS permissions and feed agreements; never scrape Zillow, Realtor.com or MLS feeds.
- UK: distinguish an advertising portal from an estate agency performing introductions, negotiations, viewings or advice. Where SocialOS or a partner performs regulated estate-agency activity, apply the Estate Agents Act/HMRC AML registration requirements and residential redress scheme requirements; rules differ across UK nations and letting regimes.
- EU/EEA: GDPR obligations apply to entities established in the EU and certain non-EU entities offering services to or monitoring people in the EU. Build consent, lawful-basis, data-subject request, retention, access and cross-border transfer controls; local property-agent licensing and advertising rules must be configured country by country.
- India: support the central RERA Act plus state/UT authority differences. Require agent registration and project registration details where applicable; Maharashtra agents need MahaRERA-specific checks. Apply the DPDP Act and notified Rules to personal data processing.
- Dubai: require the agent's valid real-estate licence and evidence of authority to advertise; capture RERA ORN and DLD advertising permit references; verify off-plan project approvals before accepting listings. DLD's Real Estate Ad Permit service requires supporting documentation and marketing-contract evidence for specified broker advertising. Bayut's terms require licensed agents, authority from the owner, lawful/current listings and one property per listing.
- Owners and agents attest that listing data is accurate, current and lawfully marketable. Expire or withdraw sold/leased inventory promptly.
- Verification must be a separate review step. New records default to draft/pending and cannot appear in public search until both verified and published.
- Public search must use the restricted `published_property_listings` view; never expose internal owner IDs, business IDs, private enquiry data or unverified inventory.
- Public enquiry intake must be server-side with rate limits, bot protection, consent capture, audit events and abuse handling before launch.

## Current implementation

- Supabase tables: `property_listings`, `property_enquiries`, `property_saved_searches`.
- RLS scopes agent inventory and enquiries to the existing SocialOS business workspace and CRM permission.
- A restricted, security-invoker public view exposes only verified, published property attributes and explicitly opted-in public agent contact fields.
- Global country and city reference tables contain 54 country/currency entries and 154 curated city entries; additional countries/cities can be seeded without schema changes.
- A 25-category property services taxonomy and verified provider directory have been added with country/city filters and tenant-scoped RLS.
- The authenticated SocialOS workspace includes a global country/currency property listing form, inventory manager, and service-provider onboarding form.
- A public `web/properties.html` marketplace filters verified inventory by country, sale/rent, category, city/area, local currency price and bedroom count; it also includes a verified property-services directory.
- Listings can be saved as drafts or submitted for review. The UI cannot self-verify or publish listings.
- Public enquiry intake, saved-search alerts, map search, bulk import, photo storage, MLS/IDX integrations, country-specific portal feeds, full moderation console and subscription billing are not yet wired end-to-end.
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

## Regulatory reference links

- UK estate-agent redress scheme: https://www.gov.uk/redress-scheme-estate-agencies
- UK HMRC estate-agency AML registration: https://www.gov.uk/guidance/registration-guide-for-estate-agency-businesses
- European Commission GDPR territorial scope: https://commission.europa.eu/law/law-topic/data-protection/information-business-and-organisations/application-gdpr_en
- India RERA Act: https://www.indiacode.nic.in/handle/123456789/2158
- India DPDP Act: https://www.indiacode.nic.in/indiacode/handle/123456789/22037?view_type=browse
- Dubai Land Department Real Estate Ad Permit: https://dubailand.gov.ae/en/eservices/real-estate-ad-permit
