# Herdr App Keymaps Reference

Default + custom keymaps for herdr-app (GUI). Bindings live in `~/.config/herdr-app/keys.json` (patched by `scripts/install-herdr.sh`).

## Legend

| Symbol | Meaning |
|--------|---------|
| `C-x` | Ctrl + x |
| `S-x` | Shift + x |
| `M-x` | Alt + x |

---

## Default Keybindings

Built-in herdr-app bindings. `M-h/j/k/l` are taken by herdr, programs in the terminal don't get them.

### Spaces (Workspaces)

| Keymap | Description |
|--------|-------------|
| `M-1` … `M-9` | Go to space N (sidebar order) |
| `C-S-PageDown` / `C-S-PageUp` | Next / previous space |
| `C-S-n` | New space |
| `S-F2` | Rename space |

### Agents

| Keymap | Description |
|--------|-------------|
| `M-Down` / `M-Up` | Next / previous agent (across spaces and tabs, Agents list order) |
| `C-S-k` | Picker: go to space / tab / agent by name |

### Tabs

| Keymap | Description |
|--------|-------------|
| `C-1` … `C-9` | Go to tab N |
| `C-Tab` / `C-S-Tab` | Next / previous tab |
| `M-]` / `M-[` | Next / previous tab |
| `C-PageDown` / `C-PageUp` | Next / previous tab |

### Panes (Splits in a Tab)

| Keymap | Description |
|--------|-------------|
| `M-h` / `M-l` | Focus pane left / right (also `M-Left` / `M-Right`) |
| `M-k` / `M-j` | Focus pane up / down |
| `M-S-h/j/k/l` | Swap pane with neighbor |
| `C-S-o` | Split right |
| `C-S-e` | Split down |
| `C-S-z` | Zoom pane (toggle) |
| `C-S-x` | Close pane |

### App

| Keymap | Description |
|--------|-------------|
| `C-S-p` | Command palette (all commands + bindings) |
| `C-=` / `C--` / `C-0` | App zoom in / out / reset |

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
