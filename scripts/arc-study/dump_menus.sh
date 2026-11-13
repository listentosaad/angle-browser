#!/usr/bin/env bash
# Print every menu item of a running app that has a keyboard shortcut, as a
# Markdown table. macOS only; needs Accessibility permission for the terminal.
#
#   dump_menus.sh [App]  > docs/arc-study/_inbox/menus.md
#
# Review the output before committing: menus can contain Space, profile or
# window names.
set -euo pipefail
APP="${1:-Arc}"
[[ "$(uname -s)" == "Darwin" ]] || { echo "macOS only" >&2; exit 1; }

read -r -d '' JXA <<'EOF' || true
function run(argv) {
  const se = Application('System Events');
  const proc = se.processes.byName(argv[0]);
  const out = [];
  function attr(item, name) {
    try { return item.attributes.byName(name).value(); } catch (e) { return null; }
  }
  function walk(menu, path) {
    let items = [];
    try { items = menu.menuItems(); } catch (e) { return; }
    for (const it of items) {
      let name = null;
      try { name = it.name(); } catch (e) {}
      if (!name) continue;  // separators have no name
      out.push({
        path: path.concat([name]),
        ch: attr(it, 'AXMenuItemCmdChar'),
        mods: attr(it, 'AXMenuItemCmdModifiers'),
        vk: attr(it, 'AXMenuItemCmdVirtualKey'),
      });
      let subs = [];
      try { subs = it.menus(); } catch (e) {}
      for (const m of subs) walk(m, path.concat([name]));
    }
  }
  for (const bar of proc.menuBars[0].menuBarItems()) {
    const name = bar.name();
    if (!name || name === 'Apple') continue;
    for (const m of bar.menus()) walk(m, [name]);
  }
  return JSON.stringify(out);
}
EOF

read -r -d '' PY <<'EOF' || true
import json, sys
VK = {36: "↩", 48: "⇥", 49: "Space", 51: "⌫", 53: "⎋", 117: "⌦",
      123: "←", 124: "→", 125: "↓", 126: "↑", 115: "Home", 119: "End",
      116: "PgUp", 121: "PgDn"}
rows = []
for it in json.load(sys.stdin):
    ch, vk, mods = it.get("ch"), it.get("vk"), it.get("mods") or 0
    key = (ch or "").strip()
    if not key and isinstance(vk, int) and vk in VK:
        key = VK[vk]
    if not key:
        continue
    m = ""
    if mods & 4: m += "⌃"
    if mods & 2: m += "⌥"
    if mods & 1: m += "⇧"
    if not mods & 8: m += "⌘"
    rows.append((" › ".join(it["path"]), m + key.upper()))
print("| Menu path | Shortcut |")
print("|---|---|")
for path, sc in rows:
    print(f"| {path.replace('|', '/')} | {sc} |")
EOF

osascript -l JavaScript -e "$JXA" "$APP" | python3 -c "$PY"
