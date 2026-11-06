# SocialOS Global Launch & Business Operations Plan

**Status date:** 6 November 2026  
**Operating principle:** prove demand and collect customer cash before adding recurring costs. This document is a launch plan, not a claim that the listed channels, countries, agents, payments or departments are already live.

## 1. Launch truth: what is and is not live

### Implemented foundations
- Static web application hosted through GitHub Pages workflow.
- Supabase authentication, tenant-aware business workspace, CRM, tasks, campaign drafts and revenue reporting.
- Global directory reference data: 73 enabled countries, 191 enabled city records, 32 service categories and 373 service records. These are not complete worldwide coverage.
- Provider onboarding with pending review, verified-provider public discovery, customer enquiry intake with explicit consent.
- Global admin review and manual revenue ledger.
- Test-mode Stripe subscription checkout and webhook infrastructure.
- Provider dashboard at `/provider-dashboard.html`: private provider profiles, verification status, enquiry inbox and lead-status updates.

### Not live / not to be advertised as live
- Live card collection, marketplace split payments, provider payouts, refunds, chargebacks, tax calculation or regulated escrow.
- Paid advertising, social-network publishing, outbound email/SMS/WhatsApp, call centre or automatic prospect scraping.
- Fully autonomous AI agents or background job workers. Existing agents/workflows are planning, queue or human-review foundations until a worker is deployed, monitored and tested.
- Complete global country/city coverage, verified provider supply, universal local licensing checks or country-wide service availability.
- Automated identity, company, licence, sanctions, insurance or professional credential verification.

## 2. First commercial wedge: one market, one vertical, one city cluster

Do not launch every country and every service simultaneously. The initial commercial wedge should be a narrow, repeatable service with:
- Clear customer pain and measurable job value.
- Low regulatory exposure.
- Short sales cycle and repeat demand.
- Providers who can demonstrate registration, insurance and service quality.
- Search demand that can be reached through free local content, partnerships and referrals.

Candidate pilot verticals: home maintenance, cleaning, repair, property maintenance or B2B digital services. Do not begin with lending, insurance, investment, medical or legal lead brokering until local licensing, advertising and referral rules are reviewed.

Run one pilot city cluster and one provider cohort first. Expand to a second city only after the first cohort generates verified enquiries, provider responses, completed jobs and repeat use.

## 3. Revenue model and collection gates

### Revenue streams, in priority order
1. **Business SaaS:** monthly/annual CRM and workflow subscription after live billing and entitlement enforcement are production-ready.
2. **Qualified lead fee:** only after clear provider terms, customer consent, duplicate/spam controls, refund rules and lead quality measurement.
3. **Featured listings:** clearly labelled sponsored placement; never imply paid placement equals verification.
4. **Real-estate referral/transaction revenue:** only with local brokerage permissions, disclosures, written agreements and jurisdiction-specific tax treatment.
5. **Enterprise licences and workflow services:** after security review, support processes and service-level commitments exist.

### Money handling rules
- Record a transaction as revenue only after the processor confirms settlement and the cash is reconciled.
- Keep gross transaction value, SocialOS fee, taxes, processor fees, refunds, chargebacks, provider payable and net cash separate.
- Maintain a refund/chargeback reserve before discretionary spending.
- Never hold customer or provider funds in an ordinary SocialOS operating account as informal escrow.
- Do not activate live billing by merely replacing a test key. Require live merchant approval, live webhook secrets, end-to-end test transactions, refund/dispute handling, tax review, subscription entitlement enforcement and reconciliation.
- Marketplace payments and provider payouts require a marketplace-capable payment architecture and provider KYC/onboarding; the existing Stripe subscription checkout is not that system.

## 4. Department operating model

| Department | Accountable work | Automation boundary |
|---|---|---|
| Product & Engineering | Roadmap, uptime, releases, incident response, access controls, backups and restore drills | CI tests and monitoring may automate; production changes require review |
| Provider Acquisition | Recruit providers, verify documents, publish quality listings, maintain city supply | Research and draft outreach may be assisted; contact and approval require human authorization |
| Customer Growth | Local SEO, useful content, referral partnerships, community education and campaign measurement | Drafts and schedules may be prepared; ad spend and publishing require account authorization |
| Sales | Qualify inbound demand, demos, proposals, close and onboarding | Lead scoring and draft proposals; human approves pricing and commitments |
| Customer Success | Onboarding, response-time monitoring, complaints, retention and renewals | Reminders and health summaries; refunds/escalations need approval |
| Trust & Compliance | Identity/business checks, licence verification, moderation, complaints and suspensions | Evidence checklists; no AI-only verification for regulated services |
| Finance & Risk | Reconciliation, tax review, fees, refunds, payouts, fraud and cash reserve | Ledger matching can be assisted; payments/refunds require authorized approval |
| Data & Analytics | Funnel, CAC, activation, conversion, retention, gross margin and cohort reports | Dashboards and anomaly alerts |
| AI Operations | Agent task queue, policy tests, evaluation, logging and human approvals | Agents cannot send external messages, publish ads, spend money or alter payouts without explicit approval |

One person can initially own multiple departments. Do not invent employees or imply departments are staffed.

## 5. Free-first customer acquisition

### Organic demand engine
- Create a useful landing page for each real city/service combination only when supply and local relevance exist.
- Publish practical guides, checklists, price factors, maintenance calendars and provider selection advice.
- Ask verified providers to share their profile and invite their existing customers to request quotes; do not buy or scrape contact lists.
- Build referral partnerships with property managers, housing associations, local trade groups and small-business communities.
- Publish case studies only with customer consent and verifiable outcomes.
- Add enquiry forms with clear purpose, privacy notice, provider identity and opt-in consent.
- Track source, campaign, qualified enquiry, provider response, quote, completed service and cash collected.

### Paid advertising gate
No paid campaigns before:
1. Organic pilot shows a positive contribution margin.
2. Landing page conversion and lead quality are measured.
3. Provider response capacity is adequate.
4. Attribution, consent and opt-out handling work.
5. A written test budget and maximum cost-per-acquisition are approved.

When funded, start with a small, geo-targeted experiment on one channel; set a daily cap, conversion event, stop-loss and holdout where practical. Do not advertise unverified or unavailable services.

## 6. Marketplace trust and compliance controls

Before a provider is marked verified, record evidence and expiry dates appropriate to the jurisdiction:
- Legal identity and business registration.
- Professional licence / regulator registration where applicable.
- Insurance where required.
- Service address and operating territory.
- Ownership/authority to represent the business.
- Complaint history and moderation decision.
- Reviewer, timestamp, evidence source and next review date.

For financial services, insurance, investment, healthcare, legal and real estate, require specialist jurisdictional review before allowing public listing or lead routing. Disclose referral fees and sponsored placement. Verification is a scoped check, not a guarantee of quality or a substitute for customer due diligence.

## 7. Operating KPIs

Measure weekly by city, vertical and acquisition source:
- Active verified providers and service coverage.
- Provider response rate and median response time.
- Enquiry-to-qualified, qualified-to-quote and quote-to-completed-job rates.
- Customer complaint, cancellation, refund and spam rates.
- Provider retention and repeat customer rate.
- SaaS trial-to-paid conversion and monthly recurring revenue (only settled subscriptions).
- Gross transaction value separately from SocialOS net revenue.
- Contribution margin = collected platform revenue minus payment fees, refunds, variable support and directly attributable acquisition cost.
- Cash runway and reserve coverage.

Do not use impressions, registered accounts, catalogue rows or unqualified enquiries as revenue.

## 8. Production launch gates

### Gate A — Safe public beta
- Security advisor findings reviewed; leaked-password protection enabled in Supabase Auth.
- RLS tests cover anonymous, owner, other tenant, provider, reviewer and admin roles.
- Rate limits, abuse/spam controls, privacy notice, terms, cookie policy and data deletion/export process reviewed.
- Restore drill completed and incident contact/process documented.
- Provider verification and moderation workflow staffed.

### Gate B — SaaS live billing
- Merchant account live-mode approval and business/KYC completed.
- Live prices, webhook signing secret, idempotency, retries and event ordering tested.
- Subscription entitlements enforced server-side.
- Tax invoice/GST/VAT treatment reviewed by a qualified adviser.
- Refund, cancellation, dispute and customer support flows tested.
- Reconciliation report matches processor settlements to ledger.

### Gate C — Marketplace money movement
- Marketplace payment provider and country availability confirmed.
- Provider onboarding/KYC and payout eligibility implemented.
- Terms define who contracts with customer, refund responsibility, chargeback allocation, taxes and commission.
- Split settlement/payouts, reserves, disputes, refunds and reconciliation tested.
- Local legal advice obtained for each launch jurisdiction.
- Never describe the service as escrow unless legally structured and authorized.

### Gate D — Advertising and external automation
- Each channel's OAuth/app review, permissions, brand assets and account owner approved.
- Explicit approval of campaign creative, audience, budget, dates and spend cap.
- Opt-in and opt-out rules validated for email, SMS, WhatsApp and calling by jurisdiction.
- Human approval remains required for outbound communications, public posting, ad spend, provider verification and financial actions.

## 9. 30-day execution sequence

**Days 1–7: trust and conversion**
- Verify production deploy and all critical user journeys.
- Enable breached-password protection; run RLS and dependency review.
- Complete provider onboarding and enquiry inbox tests with test accounts.
- Recruit the first 10–20 real providers in one selected city/vertical; verify each manually.
- Publish transparent terms, privacy and provider standards.

**Days 8–14: customer demand**
- Publish 10 genuinely useful local service pages and 5 expert guides.
- Run provider-led referrals and local partnerships.
- Respond to every genuine enquiry within a published service window.
- Measure qualified enquiry and provider response, not vanity traffic.

**Days 15–21: first transactions**
- Track quotes and completed services with both customer and provider confirmation.
- Record fees only under signed commercial terms and after collection.
- Interview customers and providers; fix the largest conversion failure.

**Days 22–30: decide whether to expand**
- Calculate contribution margin, retention, complaints and refund rate.
- Keep the pilot, change the vertical, or stop if unit economics fail.
- Only then choose a second city or a paid acquisition test.

## 10. What must be supplied by the business owner

SocialOS can prepare product code, landing pages, workflows, analytics, campaign drafts and operating checklists. It cannot independently create real-world provider supply, certify licences, guarantee customer demand, open regulated merchant accounts, approve legal terms, fund ad accounts or act as a staffed sales/support department.

Before any external launch, the owner must supply or approve:
- Legal business identity and contracting entity.
- Launch country, first city and first service vertical.
- Business bank and live payment-processor onboarding.
- Customer support contact and response hours.
- Provider agreements, privacy notice, terms and jurisdiction-specific compliance advice.
- Authorized social/ad accounts, budgets and final creative approval.

**Success condition:** a small, compliant pilot with real verified providers, genuine customer enquiries, completed services, reconciled cash and positive contribution margin. Global expansion follows proof, not precedes it.
