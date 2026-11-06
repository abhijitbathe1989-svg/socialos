# SocialOS — Business Model, Competitive Positioning & Profit Projection

**Prepared:** 6 November 2026  
**Purpose:** Build a cash-generating business with minimal upfront investment.  
**Status:** Strategic model and assumptions, not a forecast or guarantee.

## Executive decision

Build SocialOS as a **real-estate agent operating system first**: CRM + property inventory + enquiry pipeline + follow-ups + viewing requests + offers + team analytics. Use the marketplace as a customer acquisition and distribution layer, not the first source of revenue. Expand into a broader property-services and business-automation platform only after the real-estate product has repeat usage and paying customers.

The first commercial milestone is one real agent paying for a workflow that solves a recurring problem. Do not treat registrations, free users, verbal commitments, listed properties or projected GMV as revenue.

## Market and competitive reference points

Publicly displayed Indian real-estate CRM pricing checked on 6 November 2026 includes:
- Realatic: free tier and Pro from ₹399/user/month: https://realatic.com/pricing/
- Bhumi CRM: Basic ₹499/user/month, Pro ₹999/user/month, Enterprise ₹1,999/user/month: https://www.bhumicrm.com/
- BrokerBox: Individual ₹999/month, Team ₹2,499/month, Agency ₹4,999/month: https://www.brokerbox.in/
- Realzent: Starter ₹1,499/month, Growth ₹4,499/month, Team ₹8,999/month: https://realzent.com/pricing
- WAFI CRM: published annual plans equivalent to approximately ₹833, ₹2,083, ₹4,166 and ₹8,333/month before GST: https://www.wafi.co.in/pricing

These are vendor-published prices and may change. Feature limits, billing terms, GST, user caps, add-ons and annual commitments differ; do not compare headline prices as if they were identical packages.

CREDAI–Liases Foras reported primary-market residential sales value of approximately ₹8.46 lakh crore in 2025 across 50 major cities, up 16% year over year in value terms: https://credai.org/media/view-details/?file_no=103. This indicates a substantial sector, not SocialOS's obtainable market or a guarantee of demand.

## Target customer and initial geography

Initial wedge: independent agents, channel partners and small brokerages in Maharashtra. Start with one local cluster and expand only after the workflow is repeatable. Do not begin by trying to serve 73 countries operationally.

Ideal first customer:
- 1–10 agents;
- manages leads in WhatsApp, spreadsheets or notebooks;
- loses track of follow-ups and site visits;
- has enough active enquiries to feel the pain;
- owner or manager can approve a ₹499–₹2,499 monthly software purchase.

## Positioning

"SocialOS helps real-estate agents manage every property, enquiry, follow-up, viewing and offer in one simple workspace."

Avoid unsupported promises such as guaranteed leads, guaranteed sales, verified listings unless verification has actually happened, or AI replacing the agent.

## Proposed India pricing experiments

Prices are hypotheses to test, not final prices:
- Free: one user, small inventory, basic lead capture and manual workflow.
- Starter: ₹499–₹699/month, one user, core CRM.
- Solo Pro: ₹999/month, one agent, expanded inventory, follow-up workflow and viewing/offer tracking.
- Team: ₹2,499/month, up to five seats, shared pipeline and assignment.
- Brokerage: ₹6,999/month, larger team, role controls and reporting.
- Enterprise: quote only after a real buyer requests integrations, multiple branches or service levels.

Show GST separately where applicable. Do not bundle WhatsApp Business API, paid AI usage, telephony or other metered costs without pricing those costs and margin.

## Revenue streams — sequence matters

### Phase 1: recurring software revenue
1. Agent and team subscriptions.
2. Brokerage plans and additional seats.
3. Paid onboarding or data migration only if it is genuinely delivered and profitable.

### Phase 2: marketplace monetisation
4. Featured property placements.
5. Sponsored agent/provider profiles.
6. Premium listing tools and analytics.

### Phase 3: ecosystem monetisation
7. Property service-provider subscriptions.
8. Paid lead-management and lead distribution tools (only with consent, clear lead provenance and fair terms).
9. Property management tools.
10. API, integrations and enterprise licensing.

Do not start with transaction commissions, escrow, deposits or handling property purchase money. These introduce legal, operational, trust and payment complexity.

## Go-to-market plan

### First 30 days
- Interview 20 agents and small brokerages.
- Demonstrate a working workflow, not a slide deck.
- Onboard 5 pilot agents manually.
- Help each import a small set of real listings and leads with consent.
- Observe whether they use it at least weekly.
- Ask for a paid pilot, not merely positive feedback.
- Target: 3 explicit paid commitments; this is a goal, not an expected result.

### Days 31–60
- Convert at least 3 pilots to paying users if product value is demonstrated.
- Track weekly active agents, enquiries managed, follow-ups completed, viewing requests, time-to-first-response and renewal intent.
- Fix the top three reasons for non-use.
- Publish customer proof only with permission and evidence.

### Days 61–90
- Repeat the sales process with the same segment.
- Aim for 10 paying accounts as an initial validation target.
- Test referral acquisition.
- Add features only when multiple customers request them or usage data proves the need.

### Weekly sales activity targets (not forecasts)
- Identify 50 qualified prospects.
- Send 10–15 relevant, personalised first contacts per working day.
- Conduct 5 discovery conversations per week.
- Run 3 product demonstrations per week.
- Attempt 2–3 onboardings per week.
- Review paid conversions, active usage and churn every week.
Never scrape private contact data or spam. Respect opt-outs and applicable privacy/marketing rules.

## Product priorities

P0 — required before broad selling:
1. Reliable agent sign-up and onboarding.
2. Agent workspace and clear tenant/workspace boundaries.
3. Property CRUD and CSV/manual import.
4. Lead/enquiry capture with consent and secure routing.
5. Follow-up tasks and reminders.
6. Viewing request and offer workflows.
7. Basic activity dashboard.
8. Data export, account deletion and support contact.
9. Admin moderation and listing/provider verification.
10. Error logging, backups and security checks.

P1 — after pilot usage:
- team assignment and roles;
- saved searches and alerts;
- WhatsApp deep links/templates before any paid API integration;
- property matching;
- conversion analytics and exports.

P2 — only after demand:
- AI lead scoring or drafting;
- telephony;
- paid integrations and marketplace feeds;
- multi-country compliance and currencies at operational depth.

## Current product truth and launch gate

The repository has a global marketplace foundation (73 enabled countries, 191 cities and 25 service categories) and database support for viewings and offers. However, previous project checks found no published listings or public verified providers; viewing/offer customer forms and dashboard workflows were not yet fully integrated; Stripe subscription links were in test mode. Re-check these states before claiming they are still current.

Do not launch paid plans until:
- a real agent can sign up and complete onboarding;
- a real enquiry can be created and followed through securely;
- published/private data access is tested;
- workspace isolation and RLS are tested;
- cancellation, refunds, GST invoicing and support terms are clear;
- live payment collection is deliberately enabled and tested with explicit owner approval.

## Financial model — assumptions

All values below are **illustrative scenarios**, not predictions, guarantees or market averages. Currency is INR. MRR is recurring subscription revenue before GST. GST collected is not revenue. Excludes founder salary, income tax, financing, one-time setup revenue and transaction/advertising revenue. Operating costs are modelled assumptions for hosting, software, support, payment processing, customer acquisition and basic operations; actual costs must be measured.

### Three operating scenarios

| Scenario | Month 12 paying accounts | Month 36 | Month 60 | Month 60 blended ARPA |
|---|---:|---:|---:|---:|
| Conservative | 20 | 75 | 150 | ₹1,200 |
| Base execution | 50 | 250 | 600 | ₹1,500 |
| Strong execution | 100 | 500 | 1,500 | ₹1,800 |

### Month 12 / 36 / 60 revenue and operating result

**Conservative**
- Month 12: 20 × ₹900 = ₹18,000 MRR; assumed monthly operating cash cost ₹8,000; indicative operating surplus ₹10,000.
- Month 36: 75 × ₹1,000 = ₹75,000 MRR; assumed cost ₹30,000; indicative operating surplus ₹45,000.
- Month 60: 150 × ₹1,200 = ₹1,80,000 MRR; assumed cost ₹70,000; indicative operating surplus ₹1,10,000.

**Base execution**
- Month 12: 50 × ₹1,100 = ₹55,000 MRR; assumed monthly operating cash cost ₹20,000; indicative operating surplus ₹35,000.
- Month 36: 250 × ₹1,350 = ₹3,37,500 MRR; assumed cost ₹1,00,000; indicative operating surplus ₹2,37,500.
- Month 60: 600 × ₹1,500 = ₹9,00,000 MRR; assumed cost ₹3,00,000; indicative operating surplus ₹6,00,000.

**Strong execution**
- Month 12: 100 × ₹1,200 = ₹1,20,000 MRR; assumed monthly operating cash cost ₹35,000; indicative operating surplus ₹85,000.
- Month 36: 500 × ₹1,600 = ₹8,00,000 MRR; assumed cost ₹2,50,000; indicative operating surplus ₹5,50,000.
- Month 60: 1,500 × ₹1,800 = ₹27,00,000 MRR; assumed cost ₹9,00,000; indicative operating surplus ₹18,00,000.

Indicative operating surplus is not net profit. It is before founder compensation, income tax, depreciation, exceptional costs and any unmodelled liabilities. Strong execution assumes substantial distribution, product reliability and support capacity; it is an upside case, not a base expectation.

### Base case annualised run-rate checkpoints

| Point | Accounts | ARPA | MRR | Annualised recurring run rate |
|---|---:|---:|---:|---:|
| Month 12 | 50 | ₹1,100 | ₹55,000 | ₹6.6 lakh |
| Month 36 | 250 | ₹1,350 | ₹3.375 lakh | ₹40.5 lakh |
| Month 60 | 600 | ₹1,500 | ₹9 lakh | ₹1.08 crore |

Annualised run rate is a snapshot multiplied by 12, not cash already earned in that year.

## Unit economics and break-even

Track:
- ARPA = subscription revenue / paying accounts.
- Gross margin = (revenue − direct service costs) / revenue.
- CAC = acquisition spend / new paying accounts.
- Monthly logo churn = accounts lost / accounts at start of month.
- Payback months = CAC / monthly gross profit per new account.
- Contribution profit = collected revenue excluding GST − payment fees − direct hosting/API/support costs − variable acquisition costs.

Example only: at ₹1,200 ARPA and 80% gross margin, monthly gross profit per account is ₹960. If monthly fixed cash costs are ₹30,000, break-even is about 32 paying accounts (₹30,000 / ₹960, rounded up), before founder salary and tax. Validate the actual gross margin and costs rather than adopting the assumption.

## Major risks and controls

1. **Competition:** free and low-cost CRMs exist. Differentiate on simplicity, onboarding, workflow and service; do not compete only on price.
2. **Marketplace cold start:** do not rely on property listings to generate traffic before supply and demand exist. Sell CRM first.
3. **Churn:** measure weekly use and renewal intent; customers leave if the product does not save time or win business.
4. **Lead quality:** never sell unconsented or misleading leads; clearly state source and exclusivity.
5. **Data security:** enforce tenant isolation, least privilege, RLS, audit trails, backups and deletion.
6. **Regulatory burden:** validate RERA and applicable privacy/consumer/advertising rules in each operating jurisdiction before enabling listings or leads.
7. **AI costs:** use deterministic/free workflows first; meter and cap paid model usage.
8. **Founder capacity:** automate only after the manual process works; do not promise support beyond available capacity.
9. **Payment readiness:** test mode is not live revenue. Enable live payment only after explicit approval and operational checks.

## Weekly dashboard

Record actual values, not guesses:
- qualified prospects identified;
- first contacts sent;
- replies;
- discovery calls;
- demos;
- pilot accounts;
- weekly active accounts;
- paying accounts;
- MRR and cash collected;
- refunds and failed payments;
- churn and reasons;
- operating cash expenses;
- contribution profit;
- product defects blocking sales.

## Decision rules

- If fewer than 5 of 20 interviewed agents report the same costly workflow problem, revisit the target segment.
- If pilots do not use the product weekly, fix onboarding and workflow before adding features.
- If demos happen but paid conversion is weak, test packaging, price and value proof.
- Do not scale paid acquisition until retention and unit economics are positive.
- Do not expand internationally until one Indian segment is repeatable and jurisdiction-specific compliance has been reviewed.

## Immediate next action

Secure five pilot agents and observe actual usage. The first commercial proof is not a large projection: it is a customer paying, using the product repeatedly and renewing.
