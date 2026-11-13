# Arc study (phase 0)

Goal: record how Arc looks and behaves, step by step, so every row in
`docs/parity.md` has evidence.

## Who does what

The agent can only **look** at Arc (screenshots). It cannot click or type in
Arc. So the owner drives Arc by following the steps in each scenario's
`notes.md`, and after each step the agent (or the owner) captures:

- a still: `scripts/arc-study/capture.sh shot <scenario> <step> <label>`
- a recording for motion: `scripts/arc-study/capture.sh rec <scenario> <step> <label> <seconds>`

Captures go to `docs/arc-study/_inbox/` (git-ignored). After review they are
moved into `docs/arc-study/<scenario>/`.

## Setup (once)

1. In Arc, create a new Space named `Study`, default profile. Do the study only
   there. Use public sites: `example.com`, `wikipedia.org`, `youtube.com`.
2. Give Terminal "Screen Recording" permission (System Settings → Privacy &
   Security). For `dump_menus.sh`, also "Accessibility".
3. Fix the window size: `scripts/arc-study/capture.sh size`.
   Default is **1280×800** points. Reason: the M1 MacBook Air screen is
   1440×900 points by default, and the menu bar takes ~25–37 pt, so a 1440×900
   window cannot fit. To use 1440×900, set a "More Space" display mode first and
   run `ANGLE_STUDY_W=1440 ANGLE_STUDY_H=900 capture.sh size`. Use the **same**
   size for all Arc shots and later for Angle (`compare.sh`).
4. Pick light or dark mode and note it in every `notes.md`. Shots are Retina
   (2× pixels): a 1280×800 window gives 2560×1600 PNGs.

## Privacy rules

- Nothing from other Spaces, history, logins, notifications or other apps may be
  committed. Check every file in `_inbox/` before moving it.
- `sidebar_schema.py` prints key names and types only, never values.
- `dump_menus.sh` output can include Space and profile names: edit them out.

## File names

`docs/arc-study/<NN-scenario>/<step>-<label>.png|.mov`, e.g.
`05-spaces/03-switch-click-after.png`. `notes.md` refers to these names, and
`parity.md` refers to them in the Evidence column.

## Scenarios

| # | Folder | Covers parity rows |
|---|---|---|
| 01 | `01-window` | LK-01…LK-06 |
| 02 | `02-sidebar` | LK-07, TM-01, TM-04…TM-07 |
| 03 | `03-command-bar` | CB-01…CB-03, SC-01, SC-02 |
| 04 | `04-pinned-tabs` | TM-02, TM-03, TM-09, SC-04 |
| 05 | `05-spaces` | LK-03, SP-01…SP-05, SC-05 |
| 06 | `06-archive` | TM-08 |
| 07 | `07-split-view` | TM-10 |
| 08 | `08-little-arc-peek` | OT-01, OT-02 |
| 09 | `09-hide-sidebar` | OT-03, SC-03 |
| 10 | `10-persistence` | PS-01…PS-04 |
| 11 | `11-shortcuts` | SC-* (full list) |
| 12 | `12-data-model` | `docs/arc-data-model.md` open questions |
