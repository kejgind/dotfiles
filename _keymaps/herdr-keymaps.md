# Herdr App Keymaps Reference

Custom keymaps for herdr-app (GUI). Bindings live in `~/.config/herdr-app/keys.json` (patched by `scripts/install-herdr.sh`).

## Legend

| Symbol | Meaning |
|--------|---------|
| `C-x` | Ctrl + x |
| `S-x` | Shift + x |
| `M-x` | Alt + x |

---

## Custom Keybindings

### Git

| Keymap | Description |
|--------|-------------|
| `C-S-g` | Lazygit for a repo of the current workspace (picker → lazygit in peek overlay) |

### Pane Size

Mods `herdr/app/mods/pane-equalize` + `pane-resize-*`. Act on the active tab's splits.

| Keymap | Description |
|--------|-------------|
| `C-M-=` | Equalize all splits of the tab (3 columns → 33% each, nested splits too) |
| `C-M-h` | Move focused pane's divider left 5% |
| `C-M-l` | Move focused pane's divider right 5% |
| `C-M-k` | Move focused pane's divider up 5% |
| `C-M-j` | Move focused pane's divider down 5% |

Divider = pane's right/bottom one when it has a neighbor there, else left/top (tmux-like).

### Lazygit Repo Picker

Mod `herdr/app/mods/lazygit-repos`. Lists workspace root repo + nested repos (`.worktrees` skipped). One repo → opens lazygit directly.

| Keymap | Description |
|--------|-------------|
| *type* | Filter repos by name / branch |
| `Up` / `Down` | Move selection |
| `C-p` / `C-n` | Move selection |
| Mouse wheel | Scroll list |
| `Enter` | Open selected repo in lazygit |
| `Esc` | Close picker |

### Lazygit Peek

| Keymap | Description |
|--------|-------------|
| `q` | Quit lazygit, closes the peek |
| `✕` (click) | Hide peek; lazygit keeps running, next `C-S-g` on same repo reopens it |
| `↗ keep` (click) | Keep lazygit as a regular tab |

---

*Generated for herdr-app configuration at `~/dotfiles/herdr/`*
