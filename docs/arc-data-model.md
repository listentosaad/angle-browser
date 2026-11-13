# Arc sidebar data model

Source: `~/Library/Application Support/Arc/StorableSidebar.json` and
`StorableArchive.*.json` from Arc 1.172.1. **Key names only** — no URLs,
titles or names from the owner's data are recorded here.

Status of each statement:
- **seen** — the key exists in the file (first inspection).
- **inferred** — our reading of what the key means; must be confirmed by
  `scripts/arc-study/sidebar_schema.py` output plus an interactive scenario.

## 1. Space

| Key | Status | Meaning |
|---|---|---|
| `id` | seen | Space id (UUID) |
| `containerIDs` | seen | Two containers: `pinned` and `unpinned` |
| `customInfo.iconType` | seen | Icon of the Space: a symbol icon or an emoji |
| `profile` | seen | `default`, or a custom profile reference |
| color / gradient | **unknown** | Not yet found. Look for a theme/color key in the schema dump |
| title | **unknown** | Not yet found in the key list |

## 2. Items — one tree

All sidebar entries are items in one tree. Each item has `id`, `parentID` and
`childrenIds` (seen). The item kind is one of:

| Kind | Keys (seen) | Meaning (inferred) |
|---|---|---|
| `tab` | `savedURL`, `savedTitle`, `savedMuteStatus`, `timeLastActiveAt`, custom icon | A tab row. Has a saved URL, so it can exist **without a loaded page** |
| `list` | `childrenIds` | A folder. Can hold tabs and other folders (nesting) |
| `splitView` | `itemWidthFactors`, `layoutOrientation`, `focusItemID` | 2+ tabs shown side by side; sizes as fractions |
| `itemContainer` / `spaceItems` | — | Root of a Space section (pinned or unpinned) |
| `itemContainer` / `topApps` | — | Favorites grid at the top of the sidebar, **one per profile** |

## 3. Archive

`StorableArchive.*.json` files hold tabs that Arc archived automatically
(inferred: unpinned "Today" tabs not used for some time). Schema to be dumped.

## 4. What this means for Angle (first reading)

Chrome's model is flat: a `Browser` window has one `TabStripModel`, one
profile, and Tab Groups are one level deep. Arc needs:

1. **Nested folders** → a tree, not flat groups.
2. **Unloaded items** with `savedURL` → a sidebar row that has no `WebContents`.
3. **Profile per Space** → Chrome ties one window to one profile.
4. **Split view** as an item that owns other items.
5. **Archive** as a second store.

So "Space = Tab Group" probably does not cover the behavior. Final answer comes
from phase 2 (`docs/decisions/001-space-model.md`).

## 5. Open questions (answer with the schema dump + scenarios)

1. How are dictionaries encoded? (Plain JSON objects, or arrays that alternate
   `id, object, id, object`?) This changes how a migration/import tool reads it.
2. Where are Space title, color and gradient stored?
3. Is `topApps` keyed by profile id? What happens with two Spaces on the same profile?
4. Does a `tab` item store its "pinned" state, or is it only its container?
5. What extra keys does a renamed tab have (custom title vs `savedTitle`)?
6. What triggers a write to `StorableArchive.*.json`, and how are files split?
