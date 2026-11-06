# SocialOS

SocialOS is evolving into a multi-tenant AI Business Operating System that unifies AI Marketing, AI Sales, customer success, and revenue analytics. The target architecture and phased delivery plan are documented in [docs/PRODUCT_ARCHITECTURE.md](docs/PRODUCT_ARCHITECTURE.md).

The current application remains an organic-first revenue workspace for local service businesses; the broader agentic capabilities are a staged roadmap, not all live features.

## Features
- Supabase email authentication
- Business workspace setup
- Lead capture and CRM
- Internal follow-up tasks
- Campaign planning (drafts only; no publishing)
- Services and pricing
- Revenue and cash-collection dashboard
- Analytics workspace: sales funnel, booked revenue, cash collection, outstanding balance, contribution margin, campaign spend and attributed marketing ROI
- Campaign metric entry and campaign profitability reporting
- Automation rule drafts, AI agent run history and approval decision records
- Secure team invitations with single-use, seven-day tokens, invitation acceptance, revocation and role-based row-level access
- Durable agent task queue foundation with tenant-scoped jobs, idempotency keys, retry limits, expiring worker leases and atomic service-role-only claiming
- Security workspace with audit-event review and integration inventory
- Global real-estate marketplace foundation with country/city metadata, local currencies, sale/rent inventory, market-specific compliance references, provider directory, verification workflow and property pipeline
- Enterprise Command Centre for global operations, finance, sales, marketing, tasks, AI run history, approvals, team and geographic catalogue
- Global service taxonomy spanning finance, banking, lending, insurance, accounting, investment, real estate, property management, construction, healthcare, education, commerce, technology, logistics, travel, food, agriculture, energy and professional services

## Revenue-first / zero-additional-investment policy
- No paid provider integrations, AI API commitments, advertising, contractors, or new infrastructure subscriptions before customer revenue. Reuse the current stack and free tiers where available; free tiers have limits and can change.
- Pricing displayed in the prototype is indicative and unvalidated. Only test-mode checkout links exist; no live billing is enabled and SocialOS is not currently accepting payments.
- Reinvest only from cash actually collected, not bookings, invoices, forecasts, or test transactions. Keep essential operating costs and a cash reserve ahead of discretionary growth spend.
- Add a paid tool or provider only when a documented customer need exists, the cost is covered by collected revenue, and the expected payback is clear.
- Payroll integrations are deferred. Manual records / CSV workflows may be considered before any paid API partnership.
- See [docs/REVENUE_FIRST_POLICY.md](docs/REVENUE_FIRST_POLICY.md) for staged spending gates.

## Revenue-first operating policy
- No new paid tools, AI APIs, payroll integrations, ads, contractors, or infrastructure subscriptions before collected customer revenue.
- Current plan prices are unvalidated planning assumptions. Checkout is disabled; SocialOS is not accepting payments.
- Reinvest only cleared customer cash, after direct costs, taxes, refunds and a reserve.
- Defer payroll provider integrations until customers request them and revenue can fund the work.
- Do not add a recurring cost until there are three consecutive months of positive operating cash flow, documented customer demand, and a clear payback case.

## Deployment
The static frontend lives in `web/`. GitHub Actions deploys it to GitHub Pages on pushes to `main`.

Expected site URL after a successful deployment:
`https://abhijitbathe1989-svg.github.io/socialos/`

In repository Settings → Pages, set Build and deployment Source to **GitHub Actions** if it is not already selected.

## Backend
The frontend uses the existing Supabase project and its `socialos-api` Edge Function. The browser contains only the Supabase publishable key; never put a service-role key in the frontend.

## Current limitations
- Automation rules are configurable but the event scheduler / execution runtime is not enabled; enabling a rule does not run it.
- The durable agent task queue schema and secure claim function are deployed, but no worker is consuming jobs yet; queued tasks do not run until a worker and execution policies are implemented.
- Approval decisions are recorded for audit; they do not execute external actions.
- Team invitation links are created by the owner and must be sent manually; transactional email delivery is not configured.
- Team RBAC is active for CRM, tasks, campaigns, services, analytics and finance tables. Security settings and automation administration remain owner/admin-only.
- Default role map: Admin (all workspace permissions); Manager (CRM, tasks, campaigns, services, analytics, finance); Sales (CRM, tasks); Marketing (campaigns, analytics); Finance (analytics, finance); Support (CRM, tasks); Viewer (analytics). Owners/admins can customize supported business permissions.
- Payroll sync and external provider OAuth are not connected.
- Integration inventory is visible, but provider OAuth connections, encrypted credential storage and token revocation are not configured.
- Campaign ROI depends on metrics manually recorded or synced; it is not a guaranteed attribution measure.
- Supabase manages database backups according to project settings; a SocialOS restore drill has not been verified.
- Stripe checkout links are test mode only; live billing is not enabled.
- Campaigns are saved as drafts; no social network or ad platform publishing is enabled.
- Real-estate listings support 73 seeded countries, 191 curated cities, country-specific currencies and area units, sale/rent, off-plan stages and local compliance references. Public search reads only verified and published records.
- The marketplace includes 25 property-service categories and a verified service-provider directory with country/city filters and provider onboarding. Public enquiry intake, MLS/IDX and UAE portal feed integrations are not yet enabled.
- Real-estate agent subscription and featured-listing prices are launch hypotheses documented in `docs/REAL_ESTATE_MARKETPLACE.md`, not verified competitor tariffs; live billing remains disabled.
- Email sign-up depends on Supabase email confirmation and configured email delivery.
- No leads are contacted automatically.


## Global directory expansion (November 2026)
- Supabase schema now supports city population, coordinates, administrative classification, GeoNames ID and timezone metadata.
- Added public-read / RLS-protected global service taxonomy tables: `global_service_categories` and `global_services`.
- Deployed the JWT-protected `socialos-global-catalog-import` Edge Function. It imports country/currency metadata from REST Countries and populated cities from GeoNames `cities15000`, retaining cities with population >= 50,000 and national / administrative capitals. It seeds the cross-industry service taxonomy in the same operation.
- Current verified catalogue baseline (6 November 2026): 73 enabled countries, 191 enabled city records, 32 enabled service categories and 373 enabled services across 19 sectors. The country/city records are reference coverage, not a claim that every city worldwide is included. The importer remains available for future refreshes; its completion log should be checked before treating an external refresh as successful.
- Data sources: [REST Countries](https://restcountries.com/) and [GeoNames](https://www.geonames.org/). GeoNames data is provided under CC BY 4.0; attribution is required.
- Country and city reference records are not customers, active business locations, property listings or verified service providers.


## Global launch operations\n- See `docs/GLOBAL_LAUNCH_OPERATING_PLAN.md` for the staged global go-to-market plan, department operating model, trust/compliance controls, free-first acquisition, revenue gates and production launch checklist. The plan distinguishes implemented foundations from capabilities requiring external accounts, legal approval, real providers and operational staff.\n- See `docs/ORGANIC_LAUNCH_KIT.md` for provider recruitment copy, customer launch messaging, ten organic content ideas, referral loops, channel rules and weekly pilot operations.\n\n## Global provider marketplace (November 2026)
- Added `marketplace_providers`, `marketplace_provider_services`, and `marketplace_enquiries` with RLS enabled.
- Providers can register while signed in; new profiles are private and have `pending` verification status. Only active, verified providers and their active services are publicly discoverable.
- Customers can submit enquiries with explicit consent. Provider owners can read and update their own enquiry records.
- Provider registration is free in this phase. No paid lead routing, commission collection, provider verification automation, payment processing or dispute resolution is enabled.
- Public marketplace page: `/marketplace.html`. It requires the global country/service catalogue import to have completed for filters to populate.
- Verification must validate applicable identity, company registration, professional qualifications, licences, insurance and local regulatory permissions, particularly for financial, insurance, legal, healthcare and real-estate services.


## Global Admin & Revenue Centre (November 2026)
- Restricted admin UI: `/admin.html`. Admin role checks use database functions and private role storage; ordinary authenticated users cannot assign themselves roles.
- First owner bootstrap is a one-time manual SQL Editor action. The admin page generates the SQL for the currently signed-in email. Only the project owner should run it.
- Provider dashboard at `/provider-dashboard.html` for owner-scoped provider profiles, verification status, customer enquiry inbox and lead-status updates; it does not send messages or perform external actions.\n- Provider review actions are recorded in a private audit table. Public marketplace exposure remains limited to active, verified providers and services.
- Enquiry operations allow authorized admin/reviewer roles to update workflow status.
- Revenue ledger records gross transaction value, SocialOS platform revenue, currency, type and accounting status. Entries are manual records; no payment processor, charge, settlement, refund or automated commission collection is connected.
- Revenue ledger is limited to owner/admin/finance roles; provider review to owner/admin/reviewer.
- Dashboard counts include global catalogue coverage and marketplace operations. Provider verification requires independent checks for applicable identity, registration, licences, qualifications and insurance.


## SocialOS Billing Engine (test mode)

- Public billing page: `web/billing.html`.
- Test-only Stripe products and recurring INR prices are configured for Starter (₹999/month; ₹9,990/year), Growth (₹2,999/month; ₹29,990/year), and Pro (₹7,999/month; ₹79,990/year). These are provisional price hypotheses, not validated market prices.
- Plan catalog is stored in `public.socialos_plan_catalog`; customer checkout audit records are in `public.socialos_checkout_sessions`; webhook idempotency/audit records are in `public.socialos_stripe_events`.
- Existing `public.billing_subscriptions` stores tenant subscription state.
- `socialos-create-checkout` is JWT-protected, validates the signed-in user owns the selected business, and creates Stripe-hosted subscription Checkout Sessions.
- `socialos-stripe-webhook` validates Stripe signatures, deduplicates event IDs, and processes checkout and subscription lifecycle events. It also retains refund, dispute and early-fraud events for review.
- Stripe webhook endpoint (test mode): `we_1UYjrSCXleGnunRTDxXL6inN`; endpoint URL: `https://mbubkkhpmfkripcycxbw.supabase.co/functions/v1/socialos-stripe-webhook`.
- Before testing, configure Edge Function secrets `STRIPE_SECRET_KEY` (test-mode restricted key with Checkout Session write access) and `STRIPE_WEBHOOK_SECRET` (signing secret for the test webhook endpoint) in Supabase. Never place secrets in frontend code or Git.
- Test mode only. No live payment processing, marketplace payouts, refunds, tax calculation, or entitlement enforcement is enabled. Before production: configure live credentials and webhook separately, validate GST/VAT/tax obligations and merchant eligibility, build customer self-service portal, complete dispute/refund workflows, and enforce feature entitlements from verified subscription state.
