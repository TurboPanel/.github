<!-- Title format: type(scope): summary, e.g. fix(auth): refuse expired invites -->

## Summary

<!-- What changed and why (1–3 sentences). -->

## Component

- [ ] Control plane (`turbopanel`)
- [ ] Daemon (`turbopaneld`)
- [ ] UI (`ui`)
- [ ] Website / docs (`website`)
- [ ] Dev tooling (`dev`)

## Testing

- [ ] Tests added or updated where it makes sense (CI runs the suites)
- [ ] Manual verification steps listed below

## Release notes

<!-- One line a user would read in the release notes, or "None" for internal changes. -->

## Breaking changes / migrations

<!-- Anything that needs an upgrade step, a schema migration, or a matching change in another repo. "None" if not applicable. -->

## Tooling

<!-- Anything unusual about how this change was produced or verified that a reviewer should know. Optional. -->

## Twin pull request

<!-- If this change needs a matching pull request in the other repo (control plane and daemon), link it here and use the same branch name in both. The control plane pull request merges first. "None" otherwise. -->

## Checklist

- [ ] I agree to the [Contributor License Agreement](https://github.com/TurboPanel/.github/blob/trunk/CLA.md) (opening this pull request means I accept it; ticking shows it)
- [ ] The title follows `type(scope): summary`
- [ ] This PR targets `trunk` from a feature branch (on a fork is fine)
- [ ] "Allow edits from maintainers" is on
- [ ] Changed source files are formatted where the tools are: inside the Vagrant guest or on the direct machine, with the vendored Node and Deno on your `PATH` (`pnpm exec prettier --write`, or `deno fmt` for the daemon; see the contributing guide)
- [ ] No secrets or environment-specific credentials committed
- [ ] Docs updated when behavior or public API changed
