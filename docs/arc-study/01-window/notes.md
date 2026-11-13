# 01 — Window and overall look

Parity rows: LK-01…LK-06

Mode: light / dark (circle one) · Window: ____×____ · Arc version: ______

Capture commands: `capture.sh shot 01-window <step> <label>` and `capture.sh rec 01-window <step> <label> <seconds>`.

## Steps

| Step | Owner does in Arc | Capture | Look for | Result (fill in) |
|---|---|---|---|---|
| 01 | Run `capture.sh size`. Study Space selected, one tab on example.com. | `shot 01 normal` | Traffic lights position; sidebar width; content frame inset and corner radius; fonts. | |
| 02 | Hover over the traffic lights. | `shot 02 traffic-hover` | Do they change? Any toolbar appears? | |
| 03 | Drag the sidebar edge to its smallest width, then largest. | `rec 03 sidebar-resize 8` | Min/max width; does content reflow live? | |
| 04 | Switch macOS to dark mode (or light, the other one). | `shot 04 other-mode` | Which colors change; does the Space tint stay? | |
| 05 | Make the window full screen (⌃⌘F), then exit. | `rec 05 fullscreen 6` | Sidebar/traffic lights in full screen; animation. | |

## Findings

- (fill in; each finding names its evidence file and the parity row it updates)
