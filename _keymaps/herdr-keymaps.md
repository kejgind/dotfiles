# Herdr App Keymaps Reference

Custom keymaps for herdr-app (GUI). Bindings live in `~/.config/herdr-app/keys.json` (patched by `scripts/install-herdr.sh`).

## Legend

| Symbol | Meaning |
|--------|---------|
| `C-x` | Ctrl + x |
| `S-x` | Shift + x |

---

## Custom Keybindings

### Git

| Keymap | Description |
|--------|-------------|
| `C-S-g` | Lazygit for a repo of the current workspace (picker → lazygit in peek overlay) |

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
