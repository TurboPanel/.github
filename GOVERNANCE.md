# Governance

## Maintainers

TurboPanel is maintained by the [@TurboPanel](https://github.com/TurboPanel) organization. Named maintainers review pull requests, triage issues, and publish releases.

| Area | Maintainer | GitHub |
| --- | --- | --- |
| Product & control plane (`turbopanel`) | muncherelli | [@muncherelli](https://github.com/muncherelli) |
| Daemon & host orchestration (`turbopaneld`) | muncherelli | [@muncherelli](https://github.com/muncherelli) |
| UI & design system (`ui`) | muncherelli | [@muncherelli](https://github.com/muncherelli) |
| Website & documentation (`website`) | muncherelli | [@muncherelli](https://github.com/muncherelli) |
| Contributor tooling (`dev`) | muncherelli | [@muncherelli](https://github.com/muncherelli) |
| Security contact (`security@turbopanel.io`) | muncherelli | [@muncherelli](https://github.com/muncherelli) |

Maintainer memberships are public on GitHub. Repository pin order on the org profile:

1. [turbopanel](https://github.com/TurboPanel/turbopanel) — control plane
2. [turbopaneld](https://github.com/TurboPanel/turbopaneld) — daemon
3. [ui](https://github.com/TurboPanel/ui) — product console
4. [dev](https://github.com/TurboPanel/dev) — contributor environment
5. [website](https://github.com/TurboPanel/website) — marketing and docs
6. [.github](https://github.com/TurboPanel/.github) — community standards

## Decision process

1. **Routine changes** — feature branches and pull requests with maintainer review.
2. **Cross-repo contracts** — daemon ↔ control plane API changes land in coordinated PRs or a short design note in Discord first.
3. **Breaking changes** — announced in release notes with upgrade paths documented on [turbopanel.io/docs/deployment/compatibility](https://turbopanel.io/docs/deployment/compatibility).
4. **Security** — handled per [SECURITY.md](./SECURITY.md); embargo until advisory publication.

## Releases

User-installed artifacts publish through GitHub Releases on `turbopanel` and `turbopaneld`. Channel promotion (`trunk` → `canary` → `rc` → `release`) is operator-driven; see the compatibility matrix in the docs.

## Community

- [Code of Conduct](./CODE_OF_CONDUCT.md)
- [Contributing](./CONTRIBUTING.md)
- [Contributor License Agreement](./CLA.md)
- [Trademarks](./TRADEMARKS.md)
- [Support routing](./SUPPORT.md)
