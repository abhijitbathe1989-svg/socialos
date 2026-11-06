# SocialOS — Global Multimodal Business Operating System

**Product thesis:** SocialOS is a multi-tenant, AI-assisted operating system for people and organisations that provide, buy, manage, or distribute services. It combines business operations, service discovery, customer relationships, workflow automation, commerce, and multimodal AI in one extensible platform.

**Ambition:** A trusted global service and business network spanning countries, cities, industries, languages, and currencies.

**Status rule:** This is the target product blueprint, not a claim that every module, integration, AI capability, or country workflow is live. The current repository already has foundations for business workspaces, CRM, tasks, campaigns, analytics, team/security workflows, and a real-estate marketplace. New modules must pass release gates before being described as production-ready.

## 1. Four connected products

1. **SocialOS Work — Business operating system:** CRM, projects, tasks, finance, sales, marketing, customer support, team collaboration, analytics, and workflow automation.
2. **SocialOS AI — Multimodal intelligence:** text, image, audio, video, documents, structured data, retrieval, specialist agents, and human-approved actions.
3. **SocialOS Market — Global services marketplace:** discover and compare providers, request quotes, book services, manage orders, review verified work, and build trusted provider profiles.
4. **SocialOS Connect — Integration and developer platform:** APIs, webhooks, connectors, partner applications, identity, billing, and enterprise integrations.

A person may act as customer, professional, provider, employee, manager, or organisation administrator, subject to explicit workspace roles.

## 2. Global service verticals

Build configurable vertical packs rather than hard-coding one industry:

- Property and real estate: buying, selling, renting, brokerage, valuation, property management, construction, maintenance, and home services.
- Home and field services: plumbing, electrical, HVAC, cleaning, repairs, painting, landscaping, pest control, moving, and security.
- Professional services: accounting, legal, consulting, design, engineering, architecture, marketing, recruiting, and translation.
- Business services: IT, software development, cloud, cybersecurity, data, AI implementation, outsourcing, and managed services.
- Education: tutoring, training, coaching, courses, assessment, and corporate learning.
- Health and wellness administration: discovery and appointment workflows only where legally permitted; no diagnosis or clinical decision-making without regulated product controls.
- Travel, hospitality, events, and local experiences.
- Automotive, logistics, transport, and equipment services.
- Retail, wholesale, suppliers, and B2B procurement.
- Agriculture and rural services.
- Financial and insurance service discovery only with appropriate licensing, disclosures, and jurisdiction-specific restrictions.

Each vertical pack defines categories, attributes, workflows, quote fields, booking rules, compliance checklists, service expectations, and reporting metrics. Legal requirements must be localised by jurisdiction.

## 3. Multimodal capabilities

Multimodal means users can work with different input and output formats. It does not mean the platform can safely understand every file or execute every action without validation.

### Text
- Conversational workspace assistant and business Q&A.
- Draft proposals, quotes, customer replies, SOPs, reports, and marketing content.
- Translation and localisation with original text retained.
- Extract structured records from text into CRM, tasks, products, orders, and knowledge.

### Images
- Upload property photos, product photos, receipts, invoices, site photos, diagrams, and creative assets.
- Classification, tagging, duplicate detection, quality checks, OCR and visual search.
- Image-to-listing and image-to-service-request drafts.
- Store confidence and allow human correction. Do not infer identity or sensitive traits.

### Audio
- Voice notes converted to transcripts, summaries, tasks, and CRM activity drafts.
- Speech-to-text and text-to-speech where configured providers support them.
- Call summaries only where recording/transcription is lawful and required notice/consent is obtained.

### Video
- Upload site inspections, product demos, property walkthroughs, training clips, and support recordings.
- Create timestamps, chapter summaries, searchable transcripts, and draft action lists.
- Process asynchronously with file-size, access, and retention controls.

### Documents and data
- PDF, DOCX, XLSX, CSV, presentations, and scanned documents.
- Document parsing, table extraction, semantic search, knowledge retrieval, and version tracking.
- Spreadsheet analysis with source references and reproducible calculations.
- Treat retrieved documents as untrusted data, never as instructions to AI agents.

### Cross-modal workflows
- Voice note + site photo -> service request draft.
- Property photos + listing fields -> property listing draft.
- Invoice PDF + purchase record -> expense draft for approval.
- Meeting audio + notes -> action list and CRM updates.
- Product demo video -> support knowledge article draft.
- Customer text + uploaded files -> support case summary and suggested response.

Record provenance, source file, model/provider, timestamp, confidence, reviewer status, and correction history where practical.

## 4. Core application modules

### Identity and global account
Authentication, user profile, language, locale, timezone, accessibility, country settings, currencies, units, organisation membership, consent, export, recovery, and privacy controls.

### Organisation and workspace
Multiple organisations and workspaces, business profiles, locations, brands, departments, branches, teams, configurable roles, invitations, onboarding, offboarding, audit trails, and industry templates.

### Customer and relationship management
Unified contact and organisation records, lead sources, consent, preferences, deduplication, lifecycle stages, pipelines, opportunities, activities, follow-ups, notes, attachments, and customer history.

### Service and product catalogue
Services, products, packages, variants, add-ons, pricing models, service regions, availability, taxes, deposits, cancellation rules, provider credentials, verification, and local regulatory metadata.

### Marketplace and discovery
Search by category, location, language, price, availability, rating, and verification; provider profiles and portfolios; quote requests; shortlist; booking requests; order tracking; reviews; moderation; disputes; fraud reports; and appeals. Public views must never expose private workspace/customer data.

### Sales and commerce
Lead -> qualification -> opportunity -> quote -> order -> payment status -> fulfilment -> review. Include pricing permissions, invoice/receipt records, local tax integration only after validation, refunds, disputes, cancellations, and reconciliation. Do not hold customer funds or provide escrow without the required regulated structure and licensed partners.

### Marketing and growth
Brand profile, campaign calendar, content studio, SEO briefs, landing-page drafts, text and visual creative briefs, image assets, video scripts, localisation, lead-source tracking, and attribution confidence. Publishing requires OAuth, platform policy review, preview, explicit approval, rate limits, and audit logs.

### Project and work management
Tasks, projects, milestones, dependencies, checklists, documents, comments, service delivery jobs, field visits, schedules, assignments, SLA timers, escalation, resource planning, and workload views.

### Customer support and success
Support inbox, cases, priorities, SLA, knowledge base, AI response suggestions with approved-source citations, onboarding, customer health, renewals, feedback, and referrals. Refunds, account closure, legal complaints, and sensitive decisions require authorised human handling.

### Finance and business intelligence
Booked revenue, invoices, cash collected, refunds, direct costs, operating expenses, gross/contribution margin, cash runway, currency-aware reporting, cohorts, funnel conversion, retention, churn, LTV assumptions, CAC, and payback. Distinguish actuals, estimates, forecasts, and targets.

### Automation and AI agents
Trigger-condition-action workflows; specialist agents for research, marketing, sales assistance, operations, support, and analytics; bounded task queues, timeouts, retries, idempotency, token/cost budgets, run logs, and approval inbox. Agent permissions inherit workspace roles and cannot escalate themselves. Fall back to draft-only when confidence is low or sources conflict.

### Knowledge and search
Workspace knowledge bases with file-level access, hybrid keyword/semantic search, citations, versioning, freshness, tenant/role filters, prompt-injection defence, correction, expiry, export, and deletion controls.

### Integrations and developer platform
Connector directory, scopes, data-flow explanation, disconnect controls, workspace-scoped API keys, signed/replay-protected webhooks, encrypted OAuth tokens, rotation, revocation, rate limits, sandbox/production separation, partner docs, app review, versioning, and deprecation.

### Admin, trust, safety and compliance
Country/city taxonomy, provider verification queues, evidence review, fraud/spam/impersonation controls, privacy requests, retention schedules, audit, incident response, backups, and jurisdiction-specific legal review for privacy, consumer protection, payments, marketplace liability, advertising, data residency, employment, and licensing.

## 5. Target technical architecture

Start with a modular monolith and clear domain boundaries. Split services only when scale, reliability, isolation, or team ownership justifies the operational cost.

### Current foundation
- Static frontend in web/.
- Supabase authentication, Postgres, RLS and Edge Functions.
- Business workspace, CRM, tasks, campaigns, services, analytics, team/security workflows.
- Global real-estate country/city and provider foundations.
- Stripe links are test-mode only; no live subscription collection.
- Do not assume OAuth, social publishing, scheduler runtime, or autonomous agent execution is live.

### Logical layers
1. Experience: responsive web app, installable PWA, accessibility, localisation.
2. Identity: auth, workspace membership, roles, permissions, consent.
3. Domain APIs: CRM, marketplace, catalogue, orders, projects, support, finance.
4. Workflow: event outbox, job queue, scheduler, retries, idempotency, approvals.
5. AI orchestration: model gateway, prompt/version registry, retrieval, tool registry, evaluation, budgets.
6. Media pipeline: signed upload, malware scanning, MIME validation, metadata extraction, OCR/transcription, asynchronous processing, retention.
7. Integration gateway: OAuth, webhooks, provider adapters, secret vault references.
8. Data and analytics: transactional Postgres, object storage, search/vector index, reporting snapshots.
9. Trust and operations: audit, observability, rate limits, abuse detection, backups, incident response.

### Data principles
- Every business-owned record carries a workspace/tenant identifier and is protected by RLS.
- Use unified contact identity; avoid duplicate people records per module.
- Separate public marketplace projections from private workspace records.
- Keep media metadata and object storage permissions separate; use signed short-lived URLs.
- Store currency, amount, locale, timezone and unit explicitly.
- Record provenance, actor, timestamps and idempotency keys for consequential operations.
- Use append-only audit events for security- and money-sensitive actions.
- Add indexes and retention based on measured query patterns.

## 6. AI governance and quality

SocialOS should be AI-assisted and human-governed, not an uncontrolled autonomous system.

Required controls:
- Model/provider abstraction so models can change without rewriting business logic.
- Per-workspace AI budgets, quotas, rate limits, and usage transparency.
- Prompt/tool versioning, test datasets, regression evaluation, and rollback.
- Grounded answers with citations for knowledge and research.
- Confidence/uncertainty labels; no fabricated facts, licences, credentials, or promises.
- PII minimisation and provider data-use review.
- Human approval for external communication, publishing, payments, refunds, discounts, contracts, and sensitive account actions.
- Safety filters and escalation for regulated/high-impact decisions.
- Visible distinction between AI-generated and human-edited content.

Quality metrics: task success, correction rate, factuality, citation coverage, extraction precision/recall, tool-call success, timeout/retry/duplicate rates, latency, cost per workflow, satisfaction, complaints, safety incidents, and resolution time.

Do not market a feature as autonomous until it has permission boundaries, failure handling, monitoring, audit, rollback, and independent evaluation.

## 7. Globalisation strategy

Global-ready does not mean launching everywhere simultaneously.

- Store country, region, city, language, currency, timezone, measurement system, and legal-market configuration independently.
- Translate interface strings separately from user-generated content.
- Support right-to-left layouts where needed.
- Use locale-aware dates, numbers, addresses, phone validation, and tax displays.
- Keep market-specific compliance and provider-verification rules versioned.
- Launch country by country after payment, support, privacy, moderation, and legal readiness.
- Use local partners for regulated or relationship-driven services.
- A city catalogue is a discovery aid, not proof of service availability.

Suggested rollout: India pilot -> selected English-speaking and Gulf markets -> additional regions after local validation. Prioritise by demand, acquisition cost, provider density, regulation, support capacity, and unit economics—not population alone.

## 8. Monetisation

Combine recurring SaaS with carefully governed marketplace revenue:
1. Free tier with usage limits and upgrade paths.
2. Professional subscription for solo providers.
3. Team subscription priced per workspace or seat.
4. Business/enterprise subscription for multi-location operations, controls, and integrations.
5. Clearly labelled featured marketplace placement.
6. Qualified lead fees only where consent, quality, and local law permit.
7. Verification/onboarding fees only when a real review service is delivered.
8. API and partner plans with usage metering.
9. Industry-specific modules and implementation services.

Do not depend on advertising or transaction take rates before trust and marketplace liquidity exist. Do not charge for fake verification, undisclosed ranking, or unqualified leads.

## 9. Product packaging

- **Free:** basic profile, limited CRM, tasks, and marketplace presence.
- **Pro:** CRM, pipeline, service catalogue, follow-up, and basic analytics.
- **Team:** collaboration, roles, projects, automations, and team reporting.
- **Business:** multi-location, advanced workflows, finance analytics, and integrations.
- **Enterprise:** SSO options, advanced audit, custom retention, API controls, support, and negotiated limits.
- **Marketplace:** customer discovery and booking, with clearly labelled paid promotion where offered.

Prices must be tested by country and segment. Do not call displayed prices validated until interviews and paid pilots support them.

## 10. Phased build plan

### Phase 0 — Product truth and reliability
Inventory UI, Edge Functions, database tables, RLS, secrets, and provider connections. Create a live/partial/prototype/planned/blocked feature matrix. Add smoke tests and deployment checklist. Fix critical security and isolation gaps before public exposure.

### Phase 1 — Unified service-business OS
Complete onboarding and multi-workspace navigation; CRM -> quote -> order -> payment-status -> fulfilment; service catalogue and provider profile; dashboard for tasks, pipeline, cash collected, and exceptions; support cases; approval inbox. Keep unverified external actions draft-only.

### Phase 2 — Marketplace and trust
Public provider directory, service request intake, quote comparison, booking requests, order status, verification evidence, moderation, reviews, abuse reporting, public/private separation, and anti-spam controls.

### Phase 3 — Multimodal workspace
Secure upload and media metadata; document extraction and searchable knowledge; image OCR/tagging; voice-note transcription; asynchronous video transcript and summary; human correction and provenance.

### Phase 4 — Governed AI agent teams
Model gateway, budgets, research/sales/marketing/operations/support/analytics agents, tool registry, per-role permissions, approval and audit end to end, evaluation harness, and monitored rollout.

### Phase 5 — Commerce and integrations
Live payments only after merchant verification, legal review, webhooks, reconciliation, refunds, tax treatment, and subscription entitlements. Add OAuth connectors one at a time. Add API and partner ecosystem.

### Phase 6 — Global expansion
Localisation, country configuration, local provider verification, support, disputes, legal review, and expansion only after market-level retention and positive unit economics.

## 11. Release gates

No module is production-ready merely because a screen exists. Each release requires relevant checks:
- Authentication and cross-tenant access denial.
- RLS and API negative tests for sensitive tables.
- Input validation, file size/type checks, and malware scanning where uploads exist.
- Rate limiting, spam, and abuse controls.
- Secret handling and dependency/security checks.
- Audit records for sensitive actions.
- Approval, idempotency, and rollback tests for external actions.
- Backup/restore and incident response verification.
- Accessibility, responsive layout, localisation, and performance.
- AI grounding, quality, cost, and safety evaluations where AI is used.

## 12. Revenue-first execution policy

- Keep the current free/low-cost stack until paying demand justifies change.
- Do not enable paid AI APIs, paid ads, paid integrations, contractors, live billing, or new infrastructure without explicit owner approval.
- Use manual workflows to validate demand before automating them.
- Count only cleared cash as revenue available to spend.
- Reserve for refunds, taxes, support, security, and essential operations before reinvestment.
- Introduce recurring costs only with documented customer demand and a payback calculation.
- Never imply a test payment is a real customer payment.

## 13. Initial validation metrics

First 90-day targets (not forecasts):
- 20 structured interviews with service providers.
- 5 active pilot businesses completing real workflows.
- 3 paying customers or documented paid commitments.
- 60% of pilot businesses active weekly by the end of the pilot.
- Track time-to-first-value, lead response time, follow-up completion, conversion, cash collected, and churn reasons.
- Prove one narrow vertical with repeat usage before adding more vertical complexity.

## 14. Product north star

**Help every legitimate service business become easier to discover, easier to operate, more responsive to customers, and more profitable—with trusted, human-controlled AI.**

The defensible advantage is not the number of modules or countries in a dropdown. It is reliable workflows, verified supply, customer trust, high-quality localisation, integrations, measurable business outcomes, and disciplined execution.
