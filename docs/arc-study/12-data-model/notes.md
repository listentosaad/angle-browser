# 12 — Data model dump

Parity rows: docs/arc-data-model.md

Mode: light / dark (circle one) · Window: ____×____ · Arc version: ______

Capture commands: `capture.sh shot 12-data-model <step> <label>` and `capture.sh rec 12-data-model <step> <label> <seconds>`.

## Steps

| Step | Owner does in Arc | Capture | Look for | Result (fill in) |
|---|---|---|---|---|
| 01 | Quit Arc. Run `python3 scripts/arc-study/sidebar_schema.py ~/Library/Application\ Support/Arc/StorableSidebar.json > docs/arc-study/_inbox/sidebar-schema.md`. | `—` | Key paths, types, counts. No values. | |
| 02 | Same for one `StorableArchive.*.json`. | `—` | Archive schema. | |
| 03 | After scenario 04 rename and 05 profile link, dump again and diff. | `—` | Which keys hold custom title, color, profile link. | |

## Findings

- (fill in; each finding names its evidence file and the parity row it updates)
