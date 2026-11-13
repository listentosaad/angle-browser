# 02 — Sidebar sections

Parity rows: LK-07, TM-01, TM-04…TM-07

Mode: light / dark (circle one) · Window: ____×____ · Arc version: ______

Capture commands: `capture.sh shot 02-sidebar <step> <label>` and `capture.sh rec 02-sidebar <step> <label> <seconds>`.

## Steps

| Step | Owner does in Arc | Capture | Look for | Result (fill in) |
|---|---|---|---|---|
| 01 | Show the full sidebar: favorites, pinned, New Tab, Today tabs (open 3 tabs: example.com, wikipedia.org, youtube.com). | `shot 01 full` | Order of sections; spacing; labels; favorites grid size per icon. | |
| 02 | Hover a Today tab row. | `shot 02 hover-tab` | Highlight color; × button; position. | |
| 03 | Create a folder in pinned, put a tab in it, then a folder inside it. | `rec 03 nested-folder 15` | Nesting allowed? indent per level; folder icon. | |
| 04 | Collapse and expand the folder. | `rec 04 folder-toggle 5` | Animation; chevron; is state kept after switching Space? | |
| 05 | Drag a Today tab to pinned, then into the folder, then to favorites. | `rec 05 drag-sections 15` | Drop indicators; what happens to the URL; favorite icon. | |
| 06 | Hover the divider above Today tabs; click Clear. | `rec 06 clear 6` | Which tabs disappear; is there undo? | |
| 07 | Create a second Space on the **same** profile and look at the favorites. | `shot 07 favorites-shared` | Same favorites in both Spaces? (TM-01) | |

## Findings

- (fill in; each finding names its evidence file and the parity row it updates)
