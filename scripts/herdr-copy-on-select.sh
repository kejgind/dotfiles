#!/bin/sh
# Copy-on-select for herdr-app (it has no such option). herdr writes mouse
# selections to the Wayland primary selection; mirror the ones it owns (offer
# carries a "pid/<N>" mime type, N = herdr-app) into the clipboard, through the
# tmux dedent filter. Run by systemd user unit herdr-copy-on-select.service.

if [ "$1" = "--handle" ]; then
  pid=$(wl-paste --primary --list-types 2>/dev/null | sed -n 's|^pid/||p' | head -n1)
  if [ -z "$pid" ] || [ "$(cat "/proc/$pid/comm" 2>/dev/null)" != "herdr-app" ]; then
    cat >/dev/null
    exit 0
  fi
  DEDENT_NO_TMUX=1 exec "$HOME/.local/bin/tmux_dedent_copy"
fi

exec wl-paste --primary --watch "$0" --handle
