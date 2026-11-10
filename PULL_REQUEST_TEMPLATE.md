<!-- Title format: type(scope): summary, e.g. fix(auth): refuse expired invites -->

## Summary

<!-- What changed and why (1–3 sentences). -->

## Component

<!-- Which part this touches: control plane (`turbopanel`), daemon (`turbopaneld`), UI (`ui`), website / docs (`website`) or dev tooling (`dev`). -->

## Testing

<!-- Tests added or updated where it makes sense (CI runs the suites), and any manual verification steps. -->

## Release notes

<!-- One line a user would read in the release notes, or "None" for internal changes. -->

## Breaking changes / migrations

<!-- Anything that needs an upgrade step, a schema migration, or a matching change in another repo. "None" if not applicable. -->

## Tooling

<!-- Anything unusual about how this change was produced or verified that a reviewer should know. Optional. -->

## Twin pull request

<!-- If this change needs a matching pull request in the other repo (control plane and daemon), link it here and use the same branch name in both. The daemon pull request merges first, then the control plane one. "None" otherwise. -->

## Before you open this

<!--
These are reminders, not boxes to tick:

- Opening this pull request means you accept the Contributor License Agreement: https://github.com/TurboPanel/.github/blob/trunk/CLA.md
- The title follows `type(scope): summary`.
- The pull request targets `trunk` from a feature branch (a fork is fine), with "Allow edits from maintainers" on.
- Changed source files are formatted where the tools are: inside the Vagrant guest or on the direct machine (in `~/turbopanel/<repo>`), with the vendored Node and Deno on your `PATH` (`pnpm exec prettier --write`, or `deno fmt` for the daemon; see the contributing guide).
- No secrets or environment-specific credentials are committed.
- Docs are updated when behavior or public API changed.
-->
