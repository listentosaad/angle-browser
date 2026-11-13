#!/usr/bin/env python3
"""Print the *shape* of an Arc JSON file (StorableSidebar.json, StorableArchive.*.json).

Output is a Markdown table of key paths, value types and counts. It never prints
string values, numbers, URLs or titles. The only values printed are short
identifier-like strings under keys named with --show-values-for (defaults are
discriminator keys such as "type").

Privacy rules applied:
  * UUID-like keys become <uuid>; any key that is not a plain identifier
    (spaces, dots, slashes, URLs) becomes <key>.
  * Lists that alternate "<uuid>", {object}, "<uuid>", {object} (a common way
    Swift encodes dictionaries) are reported as such and walked as maps.

Usage:
  sidebar_schema.py FILE.json [--show-values-for KEY ...]
"""
from __future__ import annotations

import argparse
import json
import re
import sys
from collections import Counter, defaultdict

UUID_RE = re.compile(
    r"^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$")
IDENT_RE = re.compile(r"^[A-Za-z_][A-Za-z0-9_]{0,63}$")
VALUE_RE = re.compile(r"^[A-Za-z][A-Za-z0-9_]{0,31}$")
DEFAULT_VALUE_KEYS = ("type", "kind", "iconType", "layoutOrientation")


def safe_key(key: str) -> str:
    if UUID_RE.match(key):
        return "<uuid>"
    if IDENT_RE.match(key):
        return key
    return "<key>"


def type_name(v) -> str:
    if v is None:
        return "null"
    if isinstance(v, bool):
        return "bool"
    if isinstance(v, int):
        return "int"
    if isinstance(v, float):
        return "float"
    if isinstance(v, str):
        return "uuid-string" if UUID_RE.match(v) else "string"
    if isinstance(v, dict):
        return "object"
    if isinstance(v, list):
        return "list"
    return type(v).__name__


def is_alternating_map(lst: list) -> bool:
    if len(lst) < 2 or len(lst) % 2:
        return False
    return all(isinstance(k, str) and UUID_RE.match(k) for k in lst[0::2]) and all(
        isinstance(v, dict) for v in lst[1::2])


class Schema:
    def __init__(self, value_keys):
        self.value_keys = set(value_keys)
        self.types = defaultdict(Counter)
        self.values = defaultdict(Counter)

    def walk(self, node, path: str, key: str | None = None) -> None:
        t = type_name(node)
        if isinstance(node, list) and is_alternating_map(node):
            t = "list(alternating uuid, object)"
        self.types[path][t] += 1

        if isinstance(node, dict):
            for k, v in node.items():
                sk = safe_key(str(k))
                self.walk(v, f"{path}.{sk}", sk)
        elif isinstance(node, list):
            if t.startswith("list(alternating"):
                for v in node[1::2]:
                    self.walk(v, f"{path}.<uuid>")
            else:
                for v in node:
                    self.walk(v, f"{path}[]")
        elif isinstance(node, str) and key in self.value_keys and VALUE_RE.match(node):
            self.values[path][node] += 1

    def markdown(self) -> str:
        lines = ["| Path | Types (count) | Values |", "|---|---|---|"]
        for path in sorted(self.types):
            types = ", ".join(f"{t} ({n})" for t, n in sorted(self.types[path].items()))
            vals = ", ".join(f"`{v}` ({n})" for v, n in sorted(self.values[path].items()))
            lines.append(f"| `{path}` | {types} | {vals} |")
        return "\n".join(lines) + "\n"


def main(argv=None) -> int:
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("file")
    ap.add_argument("--show-values-for", action="append", default=None, metavar="KEY")
    args = ap.parse_args(argv)
    with open(args.file, encoding="utf-8") as f:
        data = json.load(f)
    schema = Schema(args.show_values_for or DEFAULT_VALUE_KEYS)
    schema.walk(data, "$")
    sys.stdout.write(schema.markdown())
    return 0


if __name__ == "__main__":
    sys.exit(main())
