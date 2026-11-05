# SocialOS Product Architecture

**Product direction:** SocialOS is a multi-tenant AI Business Operating System for small and growing businesses. It connects demand generation, sales execution, customer retention, and business analytics in one controlled workflow.

## Product outcome

Help a business owner understand its market, attract qualified demand, manage leads, convert opportunities, retain customers, and measure collected revenue and profit. AI agents assist with research, drafting, prioritization, analysis, and recommendations. External actions remain approval-gated until the business owner explicitly enables the relevant integration and policy.

## End-to-end operating model

```text
Business Owner / Workspace
          |
          v
CEO Orchestrator + Business Goals + Policy Engine
          |
          +--> Market Intelligence
          |
          +--> AI Marketing Department
          |      Research -> Positioning -> Content/SEO -> Campaign drafts
          |
          +--> Lead Capture + Unified CRM
          |      Source attribution -> Deduplication -> Consent/preferences
          |
          +--> AI Sales Department
          |      Enrichment -> Qualification -> Scoring -> Suggested next action
          |      -> Message drafts -> Human approval -> Follow-up tracking
          |
          +--> Conversion
          |      Proposal/quote -> Checkout -> Order -> Payment status
          |
          +--> Customer Success
          |      Onboarding -> Support -> Renewal -> Referral opportunities
          |
          +--> Analytics & Finance
                 Funnel -> Revenue -> Cash collected -> Costs -> Gross margin
                          |
                          +---- Feedback to Orchestrator, Marketing and Sales
```

## Core agent teams

### 1. CEO Orchestrator
- Reads workspace goals, business settings, and agent outputs.
- Prioritizes work based on owner-defined goals and constraints.
- Assigns bounded tasks to specialist agents.
- Maintains an auditable decision and approval queue.
- Cannot override workspace permissions, budgets, or approval requirements.

### 2. Market Intelligence
- Researches customer segments, competitors, market signals, and positioning.
- Separates verified facts from assumptions and records source links and dates.
- Produces opportunity briefs for owner review.

### 3. AI Marketing Department
- Marketing Strategist: positioning, offers, audience and channel strategy.
- Content Planner: editorial calendar and campaign briefs.
- Content Studio: platform-specific copy, creative briefs, and variants.
- SEO Agent: keyword clusters, page briefs, and on-page recommendations.
- Campaign Analyst: evaluates results and proposes experiments.
- Publishing remains draft-only until platform OAuth, permissions, and approval controls are implemented.

### 4. AI Sales Department
- Sales Director: pipeline priorities, goals, and team coordination.
- Prospect Research: identifies and researches permitted prospects.
- Lead Qualification: applies configurable fit, intent, and readiness criteria.
- Personalization: prepares relevant, truthful outreach drafts.
- SDR Assistant: prepares call plans, discovery questions, and next steps.
- Follow-up Coach: recommends timing and objection responses.
- Deal Desk: drafts quotes and discount recommendations within owner-set rules.
- Forecasting: estimates pipeline outcomes and labels uncertainty.
- Outbound messages and calls require explicit approval and compliant channel integrations.

### 5. Customer Success
- Guides onboarding and tracks customer health.
- Prepares support responses and escalation summaries.
- Identifies renewal, repeat-purchase, and referral opportunities.
- Does not make unsupported service promises or issue refunds autonomously.

### 6. Analytics & Finance
- Tracks lead sources, funnel conversion, orders, revenue, cash collected, refunds, costs, and margin.
- Distinguishes booked revenue from cash collected.
- Shows attribution confidence and missing data.
- Produces weekly business reviews and actionable experiments.

## Shared platform services

- Multi-tenant workspace isolation and row-level security.
- Role-based access control and least-privilege agent permissions.
- Agent task queue with status, retries, idempotency, timeouts, and run logs.
- Approval inbox for external actions and sensitive business decisions.
- Integration registry for OAuth connections, scopes, token status, and revocation.
- Central event/audit log for agent decisions and user actions.
- Usage metering and tenant-level limits before production billing.
- Secrets stored server-side only; never expose service-role keys or provider secrets in browser code.
- Observability: structured logs, error reporting, latency, token/cost usage, and health checks.

## Approval and safety policy

The following actions are approval-required by default:
- Publishing content or sending messages to customers/prospects.
- Launching or modifying paid advertisements.
- Spending money, issuing refunds, or committing to a purchase.
- Changing prices, applying discounts outside pre-approved rules, or signing contracts.
- Deleting customer data or changing security, access, or retention settings.

Every proposed external action should include: actor/agent, target, payload preview, rationale, expected cost or impact, required permission, expiry, and approval status. Store the approval and execution result in the audit log.

## Canonical data domains

Use tenant-scoped records and foreign keys for:
- workspaces, workspace_members, roles, and business_settings
- agent_definitions, agent_runs, agent_tasks, and agent_run_events
- approvals and audit_events
- contacts, leads, lead_sources, consent_records, and activities
- campaigns, content_assets, channel_accounts, and publishing_jobs
- opportunities, pipeline_stages, quotes, orders, and payments
- customers, support_cases, subscriptions, and customer_health_events
- expenses, revenue_events, attribution_events, and metric_snapshots
- integration_connections and encrypted_secret_references

Do not duplicate the same person across marketing and sales: use a unified contact identity with separate consent, lifecycle, and activity records.

## Delivery roadmap

### Phase 1 — Reliable revenue workspace
- Verify tenant isolation, RLS, authentication, and workspace membership.
- Consolidate CRM, lead source, pipeline, tasks, orders, payments, and cash collection.
- Add approval inbox, audit trail, and clear dashboard definitions.
- Keep all external communications and publishing disabled by default.

### Phase 2 — Agent-assisted Marketing and Sales
- Add structured agent task contracts and run history.
- Add market research, campaign planning, lead scoring, sales recommendations, and draft generation.
- Add evaluation datasets and quality checks for generated outputs.
- Require owner approval for outbound actions.

### Phase 3 — Integrations and controlled execution
- Add provider OAuth one platform at a time.
- Validate scopes, token encryption, disconnect/revocation, rate limits, webhook signatures, and provider policy compliance.
- Enable publishing and messaging only after preview, approval, idempotency, and audit logging work end to end.

### Phase 4 — Retention, analytics, and scale
- Add customer success workflows, cohorts, retention, attribution, and profitability reporting.
- Add tenant usage limits, metering, billing readiness, backups, incident response, and operational dashboards.
- Run security review and restore drills before production launch.

## Release gates

A feature is not production-ready merely because its UI exists. Each release must pass:
1. Authentication and authorization tests, including cross-tenant access attempts.
2. RLS and API negative tests.
3. Input validation, rate limiting, and abuse controls.
4. Secret handling and dependency/security checks.
5. Audit-log verification for sensitive actions.
6. Agent output evaluation and human approval tests.
7. Backup/restore and operational monitoring checks appropriate to the change.

## Current implementation boundary

This document defines the recommended target architecture; it does not claim every component is already implemented. The current application has a static frontend, Supabase-backed workspace/CRM functionality, campaign drafts, and test-mode checkout. Social publishing, live billing, autonomous outbound messaging, and a fully operational agent runtime require additional implementation, provider credentials, permissions, and verification.
