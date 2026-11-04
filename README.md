# SocialOS

SocialOS is an organic-first revenue workspace for local service businesses.

## Features
- Supabase email authentication
- Business workspace setup
- Lead capture and CRM
- Internal follow-up tasks
- Campaign planning (drafts only; no publishing)
- Services and pricing
- Revenue and cash-collection dashboard

## Deployment
The static frontend lives in `web/`. GitHub Actions deploys it to GitHub Pages on pushes to `main`.

Expected site URL after a successful deployment:
`https://abhijitbathe1989-svg.github.io/socialos/`

In repository Settings → Pages, set Build and deployment Source to **GitHub Actions** if it is not already selected.

## Backend
The frontend uses the existing Supabase project and its `socialos-api` Edge Function. The browser contains only the Supabase publishable key; never put a service-role key in the frontend.

## Current limitations
- Stripe checkout links are test mode only; live billing is not enabled.
- Campaigns are saved as drafts; no social network or ad platform publishing is enabled.
- Email sign-up depends on Supabase email confirmation and configured email delivery.
- No leads are contacted automatically.
