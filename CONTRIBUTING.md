# Contributing to TurboPanel

Thank you for helping improve TurboPanel. This file is the short routing guide; the full contributor setup lives in the docs.

## Which repo owns what

| Change | Repository |
| --- | --- |
| Control plane API, auth, daemon cell, database schema | [turbopanel/turbopanel](https://github.com/turbopanel/turbopanel) |
| Host daemon, Ansible roles, deploy runtime | [turbopanel/turbopaneld](https://github.com/turbopanel/turbopaneld) |
| Signed-in product console (Expo / Tamagui) | [turbopanel/ui](https://github.com/turbopanel/ui) |
| Marketing site and documentation (MDX) | [turbopanel/website](https://github.com/turbopanel/website) |
| Contributor development console | [turbopanel/dev](https://github.com/turbopanel/dev) |

Discuss larger changes in [Discussions](https://github.com/turbopanel/turbopanel/discussions) before opening a large PR.

## Development setup

1. Read [Development prerequisites](https://turbopanel.io/docs/development/prerequisites).
2. Follow [Local development](https://turbopanel.io/docs/getting-started/development) for the co-located stack.

The default branch is **`trunk`**. Open a feature branch and submit a pull request — do not commit directly to `trunk`.

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
