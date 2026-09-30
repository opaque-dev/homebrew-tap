# Homebrew tap for Opaque

[Opaque](https://opaque.info) is a local, approval-gated secrets broker for AI
coding tools: the model gets *operations*, never plaintext values.

```sh
brew install opaque-dev/tap/opaque
```

That installs five binaries: `opaqued` (the daemon), `opaque` (the CLI),
`opaque-mcp` (the MCP server for Claude Code), `opaque-approve-helper` (the
Linux polkit helper), and `opaque-web` (the local dashboard).

Then:

```sh
opaque init --preset github-secrets
opaqued
```

The [15-minute tutorial](https://opaque.info/tutorial/) takes it from there.

## About this repository

`Formula/opaque.rb` is generated from a published release by
[`scripts/update-tap.sh`](https://github.com/opaque-dev/opaque/blob/main/scripts/update-tap.sh)
in the main repository, which verifies every checksum against the one published
beside the asset. Do not edit it by hand — the change would be overwritten by
the next release.
