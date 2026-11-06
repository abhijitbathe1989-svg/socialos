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
- Team member draft records with role presets and permission metadata
- Security workspace with audit-event review and integration inventory

## Deployment
The static frontend lives in `web/`. GitHub Actions deploys it to GitHub Pages on pushes to `main`.

Expected site URL after a successful deployment:
`https://abhijitbathe1989-svg.github.io/socialos/`

In repository Settings → Pages, set Build and deployment Source to **GitHub Actions** if it is not already selected.

## Backend
The frontend uses the existing Supabase project and its `socialos-api` Edge Function. The browser contains only the Supabase publishable key; never put a service-role key in the frontend.

## Current limitations
- Automation rules are configurable but the event scheduler / execution runtime is not enabled; enabling a rule does not run it.
- Approval decisions are recorded for audit; they do not execute external actions.
- Team records are owner-only drafts. Invitation delivery, member authentication, role enforcement and payroll sync are not enabled.
- Integration inventory is visible, but provider OAuth connections and credential vaulting are not configured.
- Campaign ROI depends on metrics manually recorded or synced; it is not a guaranteed attribution measure.
- Supabase manages database backups according to project settings; a SocialOS restore drill has not been verified.
- Stripe checkout links are test mode only; live billing is not enabled.
- Campaigns are saved as drafts; no social network or ad platform publishing is enabled.
- Email sign-up depends on Supabase email confirmation and configured email delivery.
- No leads are contacted automatically.
