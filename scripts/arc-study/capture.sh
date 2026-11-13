#!/usr/bin/env bash
# Capture stills and recordings of a browser window for the Arc study.
# Runs on macOS only. Needs Screen Recording permission for the terminal app,
# and Accessibility permission for `size` and `region`.
#
#   capture.sh size                                   # move + resize the window
#   capture.sh region                                 # print the capture rect
#   capture.sh shot <scenario> <step> <label>         # PNG still
#   capture.sh rec  <scenario> <step> <label> <secs>  # MOV recording, shows clicks
#
# Env: ANGLE_STUDY_APP (default Arc; use Angle later for compare),
#      ANGLE_STUDY_W/H (default 1280x800), ANGLE_STUDY_X/Y (default 0,40).
set -euo pipefail

APP="${ANGLE_STUDY_APP:-Arc}"
W="${ANGLE_STUDY_W:-1280}"
H="${ANGLE_STUDY_H:-800}"
X="${ANGLE_STUDY_X:-0}"
Y="${ANGLE_STUDY_Y:-40}"

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
INBOX="$ROOT/docs/arc-study/_inbox"

die() { echo "capture.sh: $*" >&2; exit 1; }

[[ "$(uname -s)" == "Darwin" ]] || die "macOS only"

set_size() {
  osascript \
    -e "tell application \"$APP\" to activate" \
    -e "tell application \"System Events\" to tell process \"$APP\"" \
    -e "set position of front window to {$X, $Y}" \
    -e "set size of front window to {$W, $H}" \
    -e "end tell"
}

# Prints "x,y,w,h" of the front window, read back from the system.
region() {
  osascript \
    -e "tell application \"System Events\" to tell process \"$APP\"" \
    -e "set p to position of front window" \
    -e "set s to size of front window" \
    -e "return ((item 1 of p) as text) & \",\" & ((item 2 of p) as text) & \",\" & ((item 1 of s) as text) & \",\" & ((item 2 of s) as text)" \
    -e "end tell"
}

out_path() {
  local scenario="$1" step="$2" label="$3" ext="$4"
  [[ "$scenario" =~ ^[0-9]{2}-[a-z0-9-]+$ ]] || die "scenario must look like 05-spaces"
  [[ "$step" =~ ^[0-9]{2}$ ]] || die "step must be two digits, e.g. 03"
  [[ "$label" =~ ^[a-z0-9-]+$ ]] || die "label must be lowercase words with dashes"
  mkdir -p "$INBOX/$scenario"
  local f="$INBOX/$scenario/$step-$label.$ext"
  [[ ! -e "$f" ]] || die "exists: $f"
  echo "$f"
}

cmd="${1:-}"
case "$cmd" in
  size)
    set_size
    echo "window: $(region)"
    ;;
  region)
    region
    ;;
  shot)
    [[ $# -eq 4 ]] || die "usage: shot <scenario> <step> <label>"
    f="$(out_path "$2" "$3" "$4" png)"
    screencapture -x -R"$(region)" "$f"
    echo "$f"
    ;;
  rec)
    [[ $# -eq 5 ]] || die "usage: rec <scenario> <step> <label> <seconds>"
    [[ "$5" =~ ^[0-9]+$ ]] || die "seconds must be a number"
    f="$(out_path "$2" "$3" "$4" mov)"
    echo "recording $5 s -> $f"
    screencapture -x -v -k -V "$5" -R"$(region)" "$f"
    echo "$f"
    ;;
  *)
    sed -n '2,12p' "$0"
    exit 2
    ;;
esac
