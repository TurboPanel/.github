# Contributing to TurboPanel

Thank you for helping improve TurboPanel. This file is the short routing guide; the full contributor setup lives in the docs.

## Which repo owns what

| Change | Repository |
| --- | --- |
| Control plane API, auth, daemon cell, database schema | [TurboPanel/turbopanel](https://github.com/TurboPanel/turbopanel) |
| Host daemon, Ansible roles, deploy runtime | [TurboPanel/turbopaneld](https://github.com/TurboPanel/turbopaneld) |
| Signed-in product console (Expo / Tamagui) | [TurboPanel/ui](https://github.com/TurboPanel/ui) |
| Marketing site and documentation (MDX) | [TurboPanel/website](https://github.com/TurboPanel/website) |
| Contributor development console | [TurboPanel/dev](https://github.com/TurboPanel/dev) |

Discuss larger changes in [Discord](https://turbopanel.io/discord) before opening a large PR.

## Development setup

1. Read [Development prerequisites](https://turbopanel.io/docs/development/prerequisites) (Intel Core i7-4790K or equivalent, 16 GB RAM minimum / 24 GB+ recommended / 32 GB ideal, Vagrant + provider). Extra Vagrant providers for macOS and Linux are welcome — open a PR against [TurboPanel/dev](https://github.com/TurboPanel/dev).
2. Follow [Local development](https://turbopanel.io/docs/getting-started/development) — clone the six sibling repos, `vagrant up`, `vagrant ssh`, then `dev/console`.

The default branch is **`trunk`**. Open a feature branch and submit a pull request — do not commit directly to `trunk`.

## License and contributor agreement

By opening a pull request, you agree to the [Contributor License Agreement](./CLA.md). The CLA grants the project rights beyond the public repository license, including specified copyright and patent rights and the ability to license contributions under alternative commercial or proprietary terms.

| Repository | License |
| --- | --- |
| `turbopanel`, `turbopaneld`, `dev` | [AGPL-3.0-only](https://github.com/TurboPanel/turbopanel/blob/trunk/LICENSE) |
| `ui` | AGPL-3.0-only with the [Apple App Store additional permission](https://github.com/TurboPanel/ui/blob/trunk/LICENSES/TurboPanel-Apple-App-Store-Additional-Permission.txt) |
| `website` | [Apache-2.0](https://github.com/TurboPanel/website/blob/trunk/LICENSE) (code); [CC BY 4.0](https://github.com/TurboPanel/website/blob/trunk/LICENSES/CC-BY-4.0.txt) (`docs/`) |
| `.github` | Path-based map in [LICENSES/README.md](./LICENSES/README.md) |

Third-party components shipped in artifacts keep their own licenses (see each product repo's `THIRD_PARTY_NOTICES.md`). Third-party marks are never covered by TurboPanel licenses or the UI App Store additional permission. The published model is [Licensing](https://turbopanel.io/docs/getting-started/licensing).

The TurboPanel name and logos are trademarks. See [TRADEMARKS.md](./TRADEMARKS.md) and [turbopanel.io/open-source](https://turbopanel.io/open-source).

## Pre-commit gates

Each repo runs local checks before commit:

| Repo | Gate |
| --- | --- |
| `dev`, `ui`, `website` | `scan-secrets.sh` → typecheck → tests |
| `turbopaneld` | `scan-secrets.sh` → `fmt:check` → `lint` → tests |
| `turbopanel` | `scan-secrets.sh` → typecheck/tests (Deno) |

Set `TURBOPANEL_SKIP_HOOK_TESTS=1` only when the toolchain is absent locally.

## Vocabulary

The TurboPanel daemon (`turbopaneld`) is a **daemon** / **host daemon** — it stopped being described
with pre-rename "agent" phrasing once the daemon build-identity contract was renamed to
`daemonBuild`. Each product repo runs a vocabulary check (`check:vocabulary`, wired into CI alongside
the other gates above) that rejects that retired phrasing (see each checker's `FORBIDDEN_PHRASES`
list) in human-authored source and docs. `AGENTS.md` coding-agent policy sections, `.agents/skills`,
HTTP `User-Agent`, generated type files, migrations, lockfiles, and dependency names (e.g.
`agent-base`) are allowlisted. This repo's own community-health docs are covered by
`scripts/check-vocabulary.sh` (run `sh scripts/check-vocabulary.sh`); the daemon, instance, and
website repos each carry an equivalent Deno/Node checker — keep the forbidden-phrase lists in sync
as the vocabulary evolves.

## Code of conduct

This project follows the [Contributor Covenant](./CODE_OF_CONDUCT.md). By participating, you agree to uphold it.

## Security

Report vulnerabilities privately — see [SECURITY.md](./SECURITY.md) and [turbopanel.io/security](https://turbopanel.io/security).
