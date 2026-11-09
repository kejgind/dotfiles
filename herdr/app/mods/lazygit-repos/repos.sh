#!/bin/sh
# Usage: repos.sh <candidate-dir>...
# Workspace root = outermost git repo containing the first candidate that is in git.
# Prints "ROOT\t<root>" then "<repo>\t<branch>" per repo (root first), .worktrees skipped.

root=
for c in "$@"; do
  [ -d "$c" ] || continue
  r=$(git -C "$c" rev-parse --show-toplevel 2>/dev/null) || continue
  while p=$(git -C "$(dirname "$r")" rev-parse --show-toplevel 2>/dev/null) && [ "$p" != "$r" ]; do
    r=$p
  done
  root=$r
  break
done
[ -n "$root" ] || exit 3

printf 'ROOT\t%s\n' "$root"
{
  echo "$root/.git"
  find "$root" -mindepth 2 -maxdepth 4 \
    \( -name .worktrees -o -name node_modules -o -name vendor \) -prune \
    -o -name .git -print 2>/dev/null | sort
} | while read -r g; do
  # .git file -> linked worktree (gitdir: .../worktrees/...) skip; submodule keep
  [ -f "$g" ] && grep -q '/worktrees/' "$g" && continue
  d=${g%/.git}
  printf '%s\t%s\n' "$d" "$(git -C "$d" branch --show-current 2>/dev/null)"
done
