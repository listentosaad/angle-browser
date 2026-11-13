"""Tests for sidebar_schema.py. Run: python3 -m unittest discover -s scripts/arc-study"""
import contextlib
import io
import os
import unittest

import sidebar_schema

FIXTURE = os.path.join(os.path.dirname(__file__), "testdata", "fake_sidebar.json")


def run_tool(*args):
    buf = io.StringIO()
    with contextlib.redirect_stdout(buf):
        sidebar_schema.main([FIXTURE, *args])
    return buf.getvalue()


class SidebarSchemaTest(unittest.TestCase):
    def setUp(self):
        self.out = run_tool()

    def test_never_prints_private_values(self):
        for secret in ("Secret Space Name", "private.example", "My Private Inbox",
                       "Work Profile", "Profile 3", "11111111-1111", "752000000"):
            self.assertNotIn(secret, self.out)

    def test_alternating_lists_are_maps(self):
        self.assertIn("list(alternating uuid, object)", self.out)
        self.assertIn("`$.sidebar.containers[].items.<uuid>.data.tab.savedURL`", self.out)

    def test_non_identifier_keys_are_hidden(self):
        self.assertIn("`$.sidebar.containers[].profiles.<key>.directoryBasename`", self.out)

    def test_enum_values_only_for_chosen_keys(self):
        self.assertIn("`split` (1)", self.out)            # "type" is a default key
        self.assertIn("`horizontal` (1)", self.out)       # "layoutOrientation" too
        self.assertNotIn("allowAudio", self.out)          # not chosen by default
        chosen = run_tool("--show-values-for", "savedMuteStatus")
        self.assertIn("`allowAudio` (1)", chosen)
        self.assertNotIn("`split`", chosen)               # flag replaces defaults

    def test_mixed_list_is_plain_list(self):
        # containerIDs alternates words and uuids, so it is not a uuid map.
        self.assertIn("`$.sidebar.containers[].spaces.<uuid>.containerIDs[]`", self.out)


if __name__ == "__main__":
    unittest.main()
