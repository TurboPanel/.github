# Security Policy

## Supported versions

TurboPanel is in **private alpha**. Neither TurboPanel High Availability nor self-hosted is publicly available yet — we provide security fixes for the current release channel artifacts published on GitHub Releases:

| Channel | Support |
| --- | --- |
| `release` (stable) | Security fixes |
| `rc` | Security fixes during RC window |
| `canary` | Best-effort; upgrade to `release` for production |
| `trunk` | Development only — not for production |

See [Version compatibility](https://turbopanel.io/docs/deployment/compatibility) for control plane / daemon pairing.

## Reporting a vulnerability

**Do not open a public GitHub issue for security vulnerabilities.**

1. Use [GitHub private vulnerability reporting](https://github.com/turbopanel/turbopanel/security/advisories/new) on the affected repository (`turbopanel`, `turbopaneld`, `ui`, `website`, or `dev`).
2. Or email **security@turbopanel.io** with encrypted details if private reporting is unavailable.

Full policy and disclosure timeline: [turbopanel.io/security](https://turbopanel.io/security) and [docs/security/reporting](https://turbopanel.io/docs/security/reporting).

## What to include

- Affected component (control plane, daemon, UI, website, dev tooling)
- Deployment type (TurboPanel High Availability or self-hosted)
- Version or commit, OS, and architecture
- Steps to reproduce and impact assessment
- Proof-of-concept if available (keep it minimal)

## Response timeline

| Stage | Target |
| --- | --- |
| Acknowledgement | 3 business days |
| Initial assessment | 10 business days |
| Fix or mitigation plan | Depends on severity; we will keep you updated |

We credit reporters in advisories unless you request anonymity.

## Advisories

Published advisories appear on [GitHub Security Advisories](https://github.com/turbopanel/turbopanel/security/advisories) and the [security page](https://turbopanel.io/security).
