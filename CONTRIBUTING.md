# Contributing to TurboPanel

Thank you for helping improve TurboPanel. This file is the short routing guide; the full contributor setup lives in the docs.

## Which Repo Owns What

| Change | Repository |
| --- | --- |
| Control plane API, auth, daemon cell, database schema | [TurboPanel/turbopanel](https://github.com/TurboPanel/turbopanel) |
| Host daemon, Ansible roles, deploy runtime | [TurboPanel/turbopaneld](https://github.com/TurboPanel/turbopaneld) |
| Signed-in product console (Expo / Tamagui) | [TurboPanel/ui](https://github.com/TurboPanel/ui) |
| Marketing site and documentation (MDX) | [TurboPanel/website](https://github.com/TurboPanel/website) |
| Contributor development console | [TurboPanel/dev](https://github.com/TurboPanel/dev) |

Ask first for anything beyond a small fix: open an issue or start a thread in [Discord](https://turbopanel.io/discord) before writing code. A small fix is a typo or wording change, a documentation correction, or a bug fix of about 50 changed lines or fewer in one repository that adds no feature, no database migration and no change to the messages between the control plane and the daemon.

## Review Expectations

Opening a pull request proposes a change — it does not obligate a maintainer to merge it as written. Review can land anywhere on this range, and none of it means the contribution was unwelcome:

- Solid idea, needs work: a maintainer asks for changes before merge.
- Close but not quite: inline suggestions, then you push updates.
- Needs real restructuring: a maintainer may ask for a substantial rewrite to fit the project's existing architecture and style, not just its coding conventions.
- Right idea, faster to finish it directly: with "Allow edits from maintainers" enabled on your PR, a maintainer may push commits onto your branch rather than round-trip every change through comments.
- Not a fit: a maintainer can close a PR without merging it.

This is why larger changes should start as a Discord thread or a GitHub issue before any code is written — a maintainer weighing in on direction first is a lot cheaper than reworking (or unwinding) a large PR built against the wrong architecture.

## Development Setup

You do not need write access. Fork, branch, open a pull request into `trunk`: [Contribute Without Access](https://turbopanel.io/docs/development/contribute-without-access) has the exact commands. The one-command setup is `./dev/scripts/setup.sh` (from inside the `turbopanel` folder, after cloning `dev`), with `doctor` and `status` subcommands; all six repos live inside one folder named `turbopanel`, wherever you choose to put it (control plane = `turbopanel/turbopanel`). The repos must sit in a folder named `turbopanel` (any folder with that name works; both direct mode and the Vagrant guest use `~/turbopanel/<repo>`). A full run from `~/turbopanel` in direct mode, and the guest mounts, are not yet proven end to end. The script never forks `.github` (outside contributors only need to fork it if they change it), and it enables the local secret scan (`git config core.hooksPath .githooks` does the same by hand). Maintainers work from the project repos by default; `--as-contributor` makes the script work from your own forks even with push access, to try the contributor path.

1. Read [Development prerequisites](https://turbopanel.io/docs/development/prerequisites) (Intel Core i7-4790K or equivalent, 16 GB RAM minimum / 24 GB+ recommended / 32 GB ideal, Vagrant + provider). Extra Vagrant providers for macOS and Linux are welcome — open a PR against [TurboPanel/dev](https://github.com/TurboPanel/dev).
2. Pick Vagrant or a Debian 13 machine used directly: [Choosing Direct or Vagrant](https://turbopanel.io/docs/development/choosing-direct-or-vagrant).
3. Follow [Local development](https://turbopanel.io/docs/getting-started/development) — clone the sibling repos (`dev`, `turbopanel`, `turbopaneld`, `ui`, `website` are required to boot the stack; `.github` is optional), then `vagrant up`, `vagrant ssh` and `turbopanel/dev/console` (Vagrant), or `~/turbopanel/dev/console` (direct). Clones go over HTTPS through `gh` by default; SSH works if you already use it.

Pull request titles use `type(scope): summary`, for example `fix(auth): refuse expired invites`. The types are `feat`, `fix`, `chore`, `ci`, `docs`, `refactor`, `test`, `perf`, `build`, `revert` and `style`. The `pr-title` check is advisory but keeps the history readable. Format every changed file before you commit.

The default branch is **`trunk`**. Open a feature branch (on your fork if you cannot push to the project) and submit a pull request — do not commit directly to `trunk`.

### What Happens to a Pull Request From a Fork

- Every workflow run on a fork pull request waits for a maintainer to click **Approve workflows to run**, on every push. Expect a wait; nudge on the pull request or in Discord after a day or two.
- The hosted code scanner needs a secret token and does not run on pull requests from forks. Its steps are skipped on purpose, and `ci-ok` can still go green.
- Required checks: `ci-ok` in every code repository, plus a hosted secret-scan check in `turbopanel`, `turbopaneld`, `ui` and `website`.
- Signed commits are not required from contributors. It is expected that GitHub signs the squash commit when a maintainer merges, but that has not yet been confirmed on an outside pull request (the first one is the trial); the fallback is that a maintainer pushes the branch to the project repo. Maintainers sign their own commits. See [Signing and the CLA](https://turbopanel.io/docs/development/signing-and-the-cla).

### Twin Pull Requests

When one feature changes both the control plane (`turbopanel`) and the daemon (`turbopaneld`), open a pull request in each with the **same branch name**, link them in both bodies, and merge the **control plane pull request first**. This is separate from release order, where the daemon ships first (see below). Details, including what to expect from a fork: [Twin Pull Requests](https://turbopanel.io/docs/development/twin-pull-requests).

## How Changes Ship

Every repo follows the same flow; nothing is released by hand-tagging.

1. Your pull request merges into `trunk` (squash). Each green `trunk` build publishes a canary, `x.y.z-canary.N`.
2. A bot keeps one **Release Candidate** pull request open from `trunk` to `staging`. Merging it (merge commit, once `ci-ok` is green) cuts the next `x.y.z-rc.N`. The rc number stays until that version ships; a bad rc is fixed on `trunk` and the next merge cuts `rc.N+1`.
3. A second bot pull request, `staging` to `live`, releases the newest rc as `x.y.z`. Merge it with a merge commit once `ci-ok` is green, then approve the `release` environment on the run page. The release is the same signed bytes that soaked as the rc, re-stamped, never rebuilt.

Git tags work out what each repo's next version is, and the version numbers committed in the repo must say the same: a canary build is refused while they disagree. Never change them as part of another change. Right after each release, a bot opens a **chore: start x.y.z** pull request that moves them to the next patch, and it merges itself once its checks pass. Starting a new minor or major is the one deliberate button: the **Start Next Version** workflow in `turbopaneld`, which opens the same kind of pull request for `x.y.0` in each repo, and those merge themselves too.

Repos release independently, and no release waits on a matching release in another repo. When a change spans the daemon and the control plane, ship the **daemon first** in a release. (Getting the two twin pull requests onto `trunk` is the other way round: control plane pull request first.)

**Hotfixes go upstream first:** fix it on `trunk` through a normal pull request, then let it flow through the candidate and release pull requests. Do not patch `staging` or `live` directly; direct pushes to them are refused.

## License and Contributor Agreement

By opening a pull request, you agree to the [Contributor License Agreement](./CLA.md). There is no bot and nothing to sign; the pull request template carries a checkbox that links to it so the agreement is visible. Details: [Signing and the CLA](https://turbopanel.io/docs/development/signing-and-the-cla). The CLA grants the project rights beyond the public repository license, including specified copyright and patent rights and the ability to license contributions under alternative commercial or proprietary terms.

| Repository | License |
| --- | --- |
| `turbopanel`, `turbopaneld`, `dev` | [AGPL-3.0-only](https://github.com/TurboPanel/turbopanel/blob/trunk/LICENSE) |
| `ui` | AGPL-3.0-only with the [Apple App Store additional permission](https://github.com/TurboPanel/ui/blob/trunk/LICENSES/TurboPanel-Apple-App-Store-Additional-Permission.txt) |
| `website` | [Apache-2.0](https://github.com/TurboPanel/website/blob/trunk/LICENSE) (code); [CC BY 4.0](https://github.com/TurboPanel/website/blob/trunk/LICENSES/CC-BY-4.0.txt) (`docs/`) |
| `.github` | Path-based map in [LICENSES/README.md](./LICENSES/README.md) |

Third-party components shipped in artifacts keep their own licenses (see each product repo's `THIRD_PARTY_NOTICES.md`). Third-party marks are never covered by TurboPanel licenses or the UI App Store additional permission. The published model is [Licensing](https://turbopanel.io/docs/getting-started/licensing).

The TurboPanel name and logos are trademarks. See [TRADEMARKS.md](./TRADEMARKS.md) and [turbopanel.io/open-source](https://turbopanel.io/open-source).

## Pre-Commit Gates

Each repo runs local checks before commit. The secret scan always runs and cannot be skipped. Typechecks and tests are never run by the hooks; CI runs them.

| Repo | What the hook runs |
| --- | --- |
| `dev`, `ui`, `website` | `scan-secrets.sh` only |
| `turbopanel` | `scan-secrets.sh`, then Prettier on staged `.ts`, `.tsx` and `.mjs` files under `src/` and `scripts/` (skipped when Prettier is not installed locally; `TURBOPANEL_SKIP_HOOK_FORMAT=1` skips it for one commit) |
| `turbopaneld` | `scan-secrets.sh`, then `deno fmt` (which rewrites and re-stages files), `deno lint`, `deno task check:layout` and `deno task check:vocabulary` (`TURBOPANEL_SKIP_HOOK_TESTS=1` skips these when the toolchain is absent) |

In Vagrant mode you commit on the host, where there is no Node or Deno tree, so only the secret scan is guaranteed to run. Format your changed source files inside the guest first (`vagrant ssh`, then `export PATH="/opt/turbopanel/vendor/node/current/bin:/opt/turbopanel/vendor/deno/current:$PATH"`, then `cd ~/turbopanel/<repo>`, then `pnpm exec prettier --write <files>`, or `deno fmt <files>` for the daemon); under direct mode run them in `~/turbopanel/<repo>` on the machine with the same `PATH` line, once `dev/console` has installed the runtimes. CI fails an unformatted changed file.

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

## Code of Conduct

This project follows the [Contributor Covenant](./CODE_OF_CONDUCT.md). By participating, you agree to uphold it.

## Security

Report vulnerabilities privately — see [SECURITY.md](./SECURITY.md) and [turbopanel.io/security](https://turbopanel.io/security).
