# Angle

Angle is a macOS browser built as a Chromium fork. Its goal is to match the
*experience* of Arc: the sidebar, the tab model, Spaces, shortcuts and
persistence. The identity is our own: the name Angle, `Angle.app`, bundle id
`local.angle.browser`, and original icons, sounds and animations.

This repository does **not** contain Chromium. It holds our code, small patches
and scripts. Chromium is fetched at the version in `CHROMIUM_VERSION` and our
code is applied on top (see `docs/decisions/000-repo-layout.md`).

## Layout

```
CHROMIUM_VERSION        Chromium tag we build on (Mac stable)
docs/arc-study/         Phase 0: how Arc behaves, with screenshots and recordings
docs/arc-data-model.md  Arc's sidebar data model (from file structure, keys only)
docs/parity.md          One row per testable behavior: Arc vs. Angle
docs/decisions/         Architecture decision records (ADRs)
scripts/arc-study/      Helpers for the Arc study (run on the Mac that has Arc)
angle/                  Our Chromium code, linked as src/angle   (phase 1+)
patches/                Small hooks into Chromium files           (phase 1+)
branding/               Angle name, bundle id, original icons     (phase 1+)
build/args.gn           GN build arguments                        (phase 1)
```

## Phases

| Phase | Branch | Where | Done when |
|---|---|---|---|
| 0 | `arc-study` | Current Mac (M1, 8 GB) | Every scenario has evidence; `parity.md` rows have evidence; owner review |
| 1 | `baseline` | Build Mac (≥150 GB free, ≥16 GB RAM) | `Angle.app` opens, `chrome://version` shows Angle, video plays, `build.yml` green on self-hosted runner |
| 2 | `spike-spaces` | Build Mac | `docs/decisions/001-space-model.md` + working prototype |
| 3 | `vertical-slice` | Build Mac | Visual compare + unit/browser/interactive tests green + manual replay |
| 4 | one PR per parity group | Build Mac | Same as phase 3 |

Creating files or passing lint is **not** "done". Done means: it builds, it
runs, it matches Arc in a visual comparison, behavior tests pass, and every
difference is written in `docs/parity.md`.

## Naming rule

Chromium already has `third_party/angle` (the ANGLE graphics library). So:
classes use the `Angle`/`kAngle` prefix, GN paths are always the full
`//angle/...`, and no GN arg may start with `angle_` or `use_angle`.
