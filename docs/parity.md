# Parity list — Arc vs. Angle

One row = one testable behavior. A row is **not** final until its Arc behavior
has evidence (a still or recording number from `docs/arc-study/`).

Columns:
- **ID** — stable id; tests and PRs refer to it.
- **Area** — Look · Interaction · Shortcut · Tab model · Spaces · Persistence.
- **Arc behavior** — what Arc does. Text in *italics* is a hypothesis from the
  plan or from memory and must be confirmed in phase 0.
- **Evidence** — `<scenario>/<file>` or `pending`.
- **Angle status** — `match` / `differs: <why>` / `deferred: phase N` /
  `won't do: <why>` / `not started (phase N)`.
- **Acceptance test** — how we prove Angle matches (test target or compare shot).

## Look

| ID | Area | Arc behavior | Evidence | Angle status | Acceptance test |
|---|---|---|---|---|---|
| LK-01 | Look | *Window has no classic toolbar; traffic lights sit at the top of the sidebar* | pending | not started (3) | compare: sidebar normal |
| LK-02 | Look | *Sidebar width (px) and min/max when dragging the edge* | pending | not started (3) | compare + interactive_ui_tests drag |
| LK-03 | Look | *Each Space has a color/gradient that tints the sidebar and the window frame* | pending | not started (3) | compare: Space 2 |
| LK-04 | Look | *Web content sits in a frame with rounded corners and an inset from the window edge* | pending | not started (3) | compare: corner radius ±1px |
| LK-05 | Look | *Fonts and sizes of tab rows, section labels* | pending | not started (3) | compare |
| LK-06 | Look | *Dark mode changes sidebar colors per Space* | pending | not started (3) | compare dark |
| LK-07 | Look | *Hover on a tab row shows a highlight and a close (×) button* | pending | not started (3) | compare: hover |

## Sidebar and tab model

| ID | Area | Arc behavior | Evidence | Angle status | Acceptance test |
|---|---|---|---|---|---|
| TM-01 | Tab model | *Favorites (topApps) at the top are shared by all Spaces that use the same profile* | pending | not started (3) | browser_tests |
| TM-02 | Tab model | *Pinned tab: clicking it after navigating away can go back to its `savedURL`* | pending | not started (3) | browser_tests |
| TM-03 | Tab model | *Closing a pinned tab keeps the row in the sidebar, unloaded* | pending | not started (3) | browser_tests |
| TM-04 | Tab model | *Folders in the pinned section can be nested; open/close state is kept* | pending | not started (3) | angle_unittests + compare: folder open |
| TM-05 | Tab model | *"New Tab" row above Today tabs* | pending | not started (3) | compare |
| TM-06 | Tab model | *"Clear" divider removes all unpinned Today tabs* | pending | not started (3) | browser_tests |
| TM-07 | Interaction | *Drag a tab between Today, pinned, folders and favorites* | pending | not started (3) | interactive_ui_tests |
| TM-08 | Tab model | *Today tabs are archived after a set time (believed default 12h; options in Settings)* | pending | deferred: 4 | angle_unittests (clock) |
| TM-09 | Tab model | *Rename a pinned tab and change its icon* | pending | deferred: 4 | browser_tests |
| TM-10 | Tab model | *Split View: 2+ tabs in one view, resizable, saved as one item* | pending | deferred: 4 | browser_tests |

## Spaces

| ID | Area | Arc behavior | Evidence | Angle status | Acceptance test |
|---|---|---|---|---|---|
| SP-01 | Spaces | *Create a Space; pick name, color, icon or emoji* | pending | not started (3) | browser_tests |
| SP-02 | Spaces | *A Space can be linked to its own profile (separate cookies/logins)* | pending | not started (2 spike, 3/4) | browser_tests |
| SP-03 | Interaction | *Switch Space by clicking the switcher at the bottom of the sidebar* | pending | not started (3) | interactive_ui_tests |
| SP-04 | Interaction | *Switch Space with a two-finger horizontal swipe on the sidebar; content slides* | pending | not started (3) | manual recording compare |
| SP-05 | Look | *Switch animation: duration and easing (measure from recording)* | pending | deferred: 4 | recording compare |

## Command bar and URL

| ID | Area | Arc behavior | Evidence | Angle status | Acceptance test |
|---|---|---|---|---|---|
| CB-01 | Interaction | *⌘T opens the Command Bar in the middle of the window* | pending | not started (3: basic; 4: full) | interactive_ui_tests |
| CB-02 | Interaction | *⌘L opens the URL field for the current tab* | pending | not started (3) | interactive_ui_tests |
| CB-03 | Interaction | *Suggestions while typing: open tabs, history, search* | pending | deferred: 4 | browser_tests |

## Other features

| ID | Area | Arc behavior | Evidence | Angle status | Acceptance test |
|---|---|---|---|---|---|
| OT-01 | Interaction | *Little Arc: small window for links opened from other apps* | pending | deferred: 4 | browser_tests |
| OT-02 | Interaction | *Peek: links from pinned/favorite tabs to other sites open in a preview overlay* | pending | deferred: 4 | browser_tests |
| OT-03 | Interaction | *⌘S hides/shows the sidebar; hover on the left edge shows it* | pending | not started (3) | interactive_ui_tests |

## Persistence

| ID | Area | Arc behavior | Evidence | Angle status | Acceptance test |
|---|---|---|---|---|---|
| PS-01 | Persistence | *Quit and reopen: pinned tabs, folders, favorites and Spaces come back* | pending | not started (3) | browser_tests (PRE_ test) |
| PS-02 | Persistence | *After restart, which tabs are loaded vs. unloaded?* | pending | not started (3) | browser_tests |
| PS-03 | Persistence | *Today tabs survive restart (until archived)* | pending | not started (3) | browser_tests |
| PS-04 | Persistence | *Active Space and selected tab come back* | pending | not started (3) | browser_tests |

## Shortcuts

Full list comes from `scripts/arc-study/dump_menus.sh` (scenario 12). Rows below
are the ones the plan names.

| ID | Area | Arc behavior | Evidence | Angle status | Acceptance test |
|---|---|---|---|---|---|
| SC-01 | Shortcut | *⌘T — Command Bar / new tab* | pending | not started (3) | interactive_ui_tests |
| SC-02 | Shortcut | *⌘L — URL field* | pending | not started (3) | interactive_ui_tests |
| SC-03 | Shortcut | *⌘S — toggle sidebar* | pending | not started (3) | interactive_ui_tests |
| SC-04 | Shortcut | *⌘W — close tab (pinned: unload, keep row)* | pending | not started (3) | interactive_ui_tests |
| SC-05 | Shortcut | *⌃1–9 — switch Space* | pending | not started (3) | interactive_ui_tests |
| SC-06 | Shortcut | *⌘1–9 — select tab N (which sections count?)* | pending | not started (3) | interactive_ui_tests |
| SC-07 | Shortcut | *⌘⇧C — copy current URL* | pending | not started (3) | interactive_ui_tests |

## Assets

| ID | Area | Arc behavior | Evidence | Angle status | Acceptance test |
|---|---|---|---|---|---|
| AS-01 | Look | Arc logo, icons, sounds, Lottie animations | — | won't do: copyrighted assets; Angle uses original assets with the same role, size and timing (ADR 000) | review of `branding/` |
