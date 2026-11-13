# ADR 000 — Repository layout: overlay + patches

Status: accepted (2026-11-13)

## Context

`listentosaad/angle-browser` was first created as a full copy of Chromium
`main` (version 160.0.8161.0, ~5.7 GB checkout). The plan asked for a small
repository that holds only our code.

Two options:

| | Full fork (Chromium in git) | Overlay (our code + patches) |
|---|---|---|
| Repo size | ~GBs, every clone is slow | Small |
| Chromium upgrade | Big rebase of our commits on new `main` | Change `CHROMIUM_VERSION`, re-apply patches, fix conflicts in few files |
| Base version | `main` = dev channel, can be unstable | A Mac **stable** tag |
| Seeing our changes | Mixed into Chromium history | Everything we own is in `angle/`, `patches/`, `branding/` |
| Build | Still needs `gclient sync` for `DEPS` | `bootstrap.sh` does fetch + sync |

## Decision

Overlay. The work branch starts as an orphan branch (no Chromium history).
`main` still holds the Chromium copy until the owner decides to replace it.

- `CHROMIUM_VERSION` = `158.0.8127.37` (Mac stable on 2026-11-13, from
  chromiumdash). Phase 1 may move it to the newest stable before the first build.
- Chromium lives in `chromium/src` (git-ignored). `angle/` is linked as
  `src/angle`.
- `patches/` holds only small hooks into Chromium files. Logic goes in `angle/`.

## Assets policy

We study Arc's look and motion, and we match **behavior, layout, sizes and
timing**. We do **not** copy Arc's own assets into this repository or into the
app: logo, app icon, icon set, sounds, Lottie/animation files, or custom fonts.
Angle gets original assets that fill the same role. Screenshots and recordings
of Arc in `docs/arc-study/` are reference material for this private repo only.

## Consequences

- `main` and the work branches have unrelated histories. A PR from an overlay
  branch into the current `main` would not make sense; the owner should first
  replace `main` with the overlay tree (or create a new default branch).
- Phase 1 must write `scripts/bootstrap.sh`, `apply_patches.sh`,
  `update_patches.sh`, `build.sh`, `package.sh`, `compare.sh` and
  `build/args.gn`.
