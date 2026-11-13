# 04 — Pinned tab behavior

Parity rows: TM-02, TM-03, TM-09, SC-04

Mode: light / dark (circle one) · Window: ____×____ · Arc version: ______

Capture commands: `capture.sh shot 04-pinned-tabs <step> <label>` and `capture.sh rec 04-pinned-tabs <step> <label> <seconds>`.

## Steps

| Step | Owner does in Arc | Capture | Look for | Result (fill in) |
|---|---|---|---|---|
| 01 | Pin wikipedia.org main page. Click a link inside it to go to another article. | `shot 01 navigated` | Does the row show a 'back to pinned URL' hint? | |
| 02 | Click the hint (or the row favicon) to go back. | `rec 02 back-to-saved 5` | Returns to savedURL? keeps history? | |
| 03 | With the pinned tab selected, press ⌘W. | `rec 03 close-pinned 5` | Row stays? Looks unloaded (dimmed)? Which tab is selected next? | |
| 04 | Click the unloaded pinned row. | `rec 04 reload 5` | Loads savedURL or last URL? | |
| 05 | Right-click the pinned tab: rename it, then change its icon. | `rec 05 rename-icon 15` | Menu items; edit field; icon picker. | |

## Findings

- (fill in; each finding names its evidence file and the parity row it updates)
