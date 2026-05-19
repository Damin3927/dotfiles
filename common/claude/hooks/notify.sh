#!/bin/sh
# Claude Code notification hook.
# Argv:  $1 = event name (Stop | Notification)
# Stdin: JSON payload from Claude Code (.message, .transcript_path, .cwd, ...)
#
# Fires:
#   1. Local desktop notification (macOS osascript / Linux notify-send / tmux)
#   2. ntfy.sh push to $NTFY_TOPIC if set
#
# Stop:         body = last assistant text from transcript (fallback "Task finished")
# Notification: body = payload.message (fallback "Needs your attention")

set -u

event="${1:-Stop}"
payload="$(cat 2>/dev/null || true)"

# --- Parse payload + transcript via Python ----------------------------------
# Emits "<project>\x1f<body>" on stdout. Empty on failure.
parsed=""
if command -v python3 >/dev/null 2>&1; then
  parsed="$(CLAUDE_HOOK_PAYLOAD="$payload" CLAUDE_HOOK_EVENT="$event" \
    python3 - <<'PY' 2>/dev/null || true
import json, os, re, sys
from collections import deque

event = os.environ.get("CLAUDE_HOOK_EVENT", "")
try:
    payload = json.loads(os.environ.get("CLAUDE_HOOK_PAYLOAD") or "{}")
except Exception:
    payload = {}

message = (payload.get("message") or "").strip()
transcript = payload.get("transcript_path") or ""
cwd = payload.get("cwd") or ""

last_text = ""
if event == "Stop" and transcript and os.path.isfile(transcript):
    try:
        with open(transcript, "r", encoding="utf-8", errors="replace") as f:
            lines = deque(f, maxlen=400)
        for line in reversed(lines):
            try:
                d = json.loads(line)
            except Exception:
                continue
            if d.get("type") != "assistant":
                continue
            content = (d.get("message") or {}).get("content") or []
            texts = []
            for block in content:
                if isinstance(block, dict) and block.get("type") == "text":
                    t = (block.get("text") or "").strip()
                    if t:
                        texts.append(t)
            if texts:
                last_text = "\n".join(texts)
                break
    except Exception:
        pass

project = os.path.basename(cwd.rstrip("/")) if cwd else ""

body = last_text or message
if not body:
    body = "Task finished" if event == "Stop" else "Needs your attention"

# Tidy whitespace and truncate for notification UI
body = re.sub(r"[ \t]+", " ", body).strip()
body = re.sub(r"\n{2,}", "\n", body)
if len(body) > 280:
    body = body[:280].rstrip() + "…"

sys.stdout.write(project + "\x1f" + body)
PY
  )"
fi

project=""
body=""
if [ -n "$parsed" ]; then
  us=$(printf '\037')
  project="${parsed%%${us}*}"
  body="${parsed#*${us}}"
fi

case "$event" in
  Stop)
    [ -z "$body" ] && body="Task finished"
    priority="default"
    tags="white_check_mark"
    ;;
  Notification)
    [ -z "$body" ] && body="Needs your attention"
    priority="high"
    tags="bell"
    ;;
  *)
    [ -z "$body" ] && body="$event"
    priority="default"
    tags="information_source"
    ;;
esac

title="Claude Code"

osa_escape() { printf '%s' "$1" | sed 's/\\/\\\\/g; s/"/\\"/g'; }

# --- 1. Local notification (best effort, never blocks) ---------------------
case "$(uname -s)" in
  Darwin)
    sub_clause=""
    if [ -n "$project" ]; then
      sub_clause=" subtitle \"$(osa_escape "$project")\""
    fi
    osascript -e "display notification \"$(osa_escape "$body")\" with title \"$(osa_escape "$title")\"$sub_clause sound name \"Glass\"" >/dev/null 2>&1 &
    ;;
  Linux)
    local_title="$title"
    [ -n "$project" ] && local_title="$title · $project"
    if command -v notify-send >/dev/null 2>&1; then
      notify-send "$local_title" "$body" >/dev/null 2>&1 &
    elif [ -n "${TMUX:-}" ] && command -v tmux >/dev/null 2>&1; then
      tmux display-message "$local_title: $body" >/dev/null 2>&1 &
    fi
    ;;
esac

# --- 2. ntfy push (only when NTFY_TOPIC is set) ----------------------------
if [ -n "${NTFY_TOPIC:-}" ] && command -v curl >/dev/null 2>&1; then
  ntfy_title="$title"
  [ -n "$project" ] && ntfy_title="$title · $project"
  curl -fsS --max-time 5 \
    -H "Title: $ntfy_title" \
    -H "Priority: $priority" \
    -H "Tags: $tags" \
    -d "$body" \
    "https://ntfy.sh/$NTFY_TOPIC" >/dev/null 2>&1 &
fi

exit 0
