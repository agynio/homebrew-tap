# Agyn Homebrew Tap

Homebrew tap for Agyn CLI tools.

| Formula | Description | Source |
| --- | --- | --- |
| `agyn` | CLI for the Agyn platform | [agynio/agyn-cli](https://github.com/agynio/agyn-cli) |
| `outline-cli` | CLI for Outline (self-hosted-focused) | [agynio/outline-cli](https://github.com/agynio/outline-cli) |

Bottles are not built; the formulas install prebuilt release binaries for
macOS and Linux, on both arm64 and amd64.

## Install

```bash
brew tap agynio/tap
brew install agyn
brew install outline-cli
```

## Upgrade

```bash
brew update
brew upgrade agyn outline-cli
```

## agyn

Talks to an Agyn gateway: `agyn auth login`, then `agyn profile`,
`agyn environments`, `agyn agents`, `agyn apps`, `agyn sandbox`,
`agyn network`, `agyn expose` and friends.

`agyn local` runs the platform in a local VM and needs extra tooling that the
formula does not depend on — it is a large install, and using `agyn` against a
remote cluster needs none of it:

```bash
brew install lima xz
agyn local doctor
```

`agyn local doctor` reports what is missing and how to get it.

## outline

The `outline-cli` formula installs a binary named `outline`. It reads and writes
an Outline workspace: `outline auth login --base-url <url> --api-key <key>`,
then `outline documents`, `outline collections`, `outline comments` and
`outline shares`.

## Updating a formula

Formulas are pinned to a release tag with per-platform SHA256 sums. To move one
to a new version, update `version`, both `url` pairs and their `sha256` values
in `Formula/<name>.rb`:

```bash
gh release download vX.Y.Z -R agynio/agyn-cli -p '*.tar.gz' -D /tmp/agyn-rel
shasum -a 256 /tmp/agyn-rel/*.tar.gz
```
