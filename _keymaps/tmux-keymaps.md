# Tmux Keymaps Reference

Comprehensive keymap reference for your tmux configuration.

## Legend

| Symbol | Meaning |
|--------|---------|
| `prefix` | `Ctrl+Space` (custom, default is `Ctrl+b`) |
| `C-x` | Ctrl + x |
| `S-x` | Shift + x |
| `M-x` | Alt/Meta + x |

**Mode Indicators:**
- **Normal** = default tmux mode, commands require `prefix` first
- **No prefix** = works without pressing prefix
- **Copy-mode** = entered via `prefix [`, uses vi-style keys

---

## Custom Keybindings

Custom bindings from `tmux/tmux.conf`. All require `prefix` unless noted.

### Prefix

| Keymap | Description |
|--------|-------------|
| `C-Space` | Prefix key (replaces default `C-b`) |
| `prefix C-Space` | Send prefix to nested tmux session |

### Config

| Keymap | Description |
|--------|-------------|
| `prefix r` | Reload tmux config |

### Window Navigation

| Keymap | Description |
|--------|-------------|
| `prefix n` | Next window (repeatable) |
| `prefix p` | Previous window (repeatable) |
| `prefix C-n` | Next window (Ctrl held after prefix) |
| `prefix C-p` | Previous window (Ctrl held after prefix) |
| `prefix C-l` | Next window (vim-style, repeatable) |
| `prefix C-h` | Previous window (vim-style, repeatable) |
| `prefix Space` | Switch to last used window |

### Window Reordering

| Keymap | Description |
|--------|-------------|
| `prefix <` | Move current window left (repeatable) |
| `prefix >` | Move current window right (repeatable) |

### Pane Navigation (Vi-style)

| Keymap | Description |
|--------|-------------|
| `prefix h` | Select pane left (repeatable) |
| `prefix j` | Select pane down (repeatable) |
| `prefix k` | Select pane up (repeatable) |
| `prefix l` | Select pane right (repeatable) |

---

## vim-tmux-navigator Plugin

Seamless navigation between tmux panes and Neovim splits. These work **without prefix**.

| Keymap | Mode | Description |
|--------|------|-------------|
| `C-h` | No prefix | Move to left pane/split |
| `C-j` | No prefix | Move to lower pane/split |
| `C-k` | No prefix | Move to upper pane/split |
| `C-l` | No prefix | Move to right pane/split |
| `C-\` | No prefix | Move to previous pane/split |

---

## Default Tmux Keybindings

Built-in tmux commands. All require `prefix` unless noted.

### Sessions

| Keymap | Description |
|--------|-------------|
| `prefix d` | Detach from session |
| `prefix s` | Choose session from list |
| `prefix $` | Rename current session |
| `prefix (` | Switch to previous session |
| `prefix )` | Switch to next session |
| `prefix L` | Switch to last session |

### Windows (Tabs)

| Keymap | Description |
|--------|-------------|
| `prefix c` | Create new window |
| `prefix &` | Kill current window (with confirm) |
| `prefix ,` | Rename current window |
| `prefix w` | Choose window from list (tree view) |
| `prefix 0-9` | Select window by number |
| `prefix l` | Switch to last active window |
| `prefix f` | Find window by name |
| `prefix .` | Move window to a new index |
| `prefix '` | Select window by index (prompt) |

### Panes

| Keymap | Description |
|--------|-------------|
| `prefix %` | Split pane vertically (left/right) |
| `prefix "` | Split pane horizontally (top/bottom) |
| `prefix x` | Kill current pane (with confirm) |
| `prefix z` | Toggle pane zoom (fullscreen) |
| `prefix o` | Cycle focus to next pane |
| `prefix ;` | Move to last active pane |
| `prefix q` | Show pane numbers (type number to select) |
| `prefix {` | Swap pane with previous |
| `prefix }` | Swap pane with next |
| `prefix !` | Break pane into its own window |
| `prefix Space` | Cycle through pane layouts |
| `prefix M-1` | Layout: even-horizontal |
| `prefix M-2` | Layout: even-vertical |
| `prefix M-3` | Layout: main-horizontal |
| `prefix M-4` | Layout: main-vertical |
| `prefix M-5` | Layout: tiled |

### Pane Resizing

| Keymap | Description |
|--------|-------------|
| `prefix C-Up` | Resize pane up (1 cell) |
| `prefix C-Down` | Resize pane down (1 cell) |
| `prefix C-Left` | Resize pane left (1 cell) |
| `prefix C-Right` | Resize pane right (1 cell) |
| `prefix M-Up` | Resize pane up (5 cells) |
| `prefix M-Down` | Resize pane down (5 cells) |
| `prefix M-Left` | Resize pane left (5 cells) |
| `prefix M-Right` | Resize pane right (5 cells) |

### Copy & Paste

| Keymap | Description |
|--------|-------------|
| `prefix [` | Enter copy mode |
| `prefix ]` | Paste buffer |
| `prefix =` | Choose paste buffer from list |
| `prefix #` | List all paste buffers |
| `prefix PgUp` | Enter copy mode and scroll up one page |

### Miscellaneous

| Keymap | Description |
|--------|-------------|
| `prefix :` | Enter command prompt |
| `prefix ?` | List all key bindings |
| `prefix t` | Show clock |
| `prefix ~` | Show previous tmux messages |
| `prefix i` | Display window information |
| `prefix m` | Mark current pane |
| `prefix M` | Clear marked pane |

---

## Vi Copy-Mode (Full)

Entered via `prefix [`. Since `mode-keys vi` is set, all navigation is vi-style.

### Exiting Copy-Mode

| Keymap | Description |
|--------|-------------|
| `q` | Cancel / exit copy mode |
| `Escape` | Cancel / clear selection |

### Cursor Movement

| Keymap | Description |
|--------|-------------|
| `h` | Move left |
| `j` | Move down |
| `k` | Move up |
| `l` | Move right |
| `w` | Next word start |
| `W` | Next WORD start |
| `b` | Previous word start |
| `B` | Previous WORD start |
| `e` | Next word end |
| `E` | Next WORD end |
| `0` | Start of line |
| `$` | End of line |
| `^` | First non-blank character |
| `g0` | Start of visual line |
| `g$` | End of visual line |
| `gg` | Go to top of history |
| `G` | Go to bottom (end of history) |

### Screen Position

| Keymap | Description |
|--------|-------------|
| `H` | Move cursor to top of visible screen |
| `M` | Move cursor to middle of visible screen |
| `L` | Move cursor to bottom of visible screen |

### Scrolling

| Keymap | Description |
|--------|-------------|
| `C-u` | Scroll up half page |
| `C-d` | Scroll down half page |
| `C-b` | Scroll up full page |
| `C-f` | Scroll down full page |
| `C-y` | Scroll up one line |
| `C-e` | Scroll down one line |

### Search

| Keymap | Description |
|--------|-------------|
| `/` | Search forward |
| `?` | Search backward |
| `n` | Next search match |
| `N` | Previous search match |

### Character Search

| Keymap | Description |
|--------|-------------|
| `f{char}` | Jump forward to character |
| `F{char}` | Jump backward to character |
| `t{char}` | Jump forward to before character |
| `T{char}` | Jump backward to after character |
| `;` | Repeat last character search |
| `,` | Repeat last character search (reverse) |

### Selection & Yanking

| Keymap | Description |
|--------|-------------|
| `v` | Begin selection (visual) |
| `V` | Select entire line (visual line) |
| `C-v` | Begin rectangle/block selection |
| `Space` | Begin selection (alternative) |
| `y` | Copy (yank) selection and exit |
| `Enter` | Copy (yank) selection and exit |
| `D` | Copy from cursor to end of line |
| `A` | Append to selection and copy |
| `o` | Move cursor to other end of selection |
| `O` | Move cursor to other corner (block mode) |

### Marks & Jumps

| Keymap | Description |
|--------|-------------|
| `m{letter}` | Set mark |
| `'{letter}` | Jump to mark |
| `{number}:` | Go to line number |

---

## Mouse

Mouse support is **enabled** (`set -g mouse on`).

| Action | Description |
|--------|-------------|
| Click pane | Select/focus pane |
| Click window tab | Switch to window |
| Drag pane border | Resize pane |
| Scroll wheel | Scroll (enters copy-mode automatically) |
| Click & drag | Select text (enters copy-mode) |

---

## Session Defaults

Every new session automatically starts with **5 windows**:

| Window | Content |
|--------|---------|
| 1 | Shell (focused on start) |
| 2 | Shell |
| 3 | Shell |
| 4 | Shell |
| 5 | Yazi (file manager) |

All windows inherit the session's working directory. Configured via `session-created` hook in `tmux.conf`.

---

## Quick Tips

1. **Window reorder**: `prefix <` / `prefix >` to move current window left/right
2. **Zoom pane**: `prefix z` to toggle fullscreen on a single pane
3. **Quick split**: `prefix %` vertical, `prefix "` horizontal
4. **Navigate everywhere**: `C-h/j/k/l` works across tmux panes and Neovim splits seamlessly
5. **Last window**: `prefix Space` to toggle between two most recent windows
6. **Session switch**: `prefix s` to pick from session list
7. **Copy text**: `prefix [` to enter copy-mode, `v` to select, `y` to yank, `prefix ]` to paste
8. **Find window**: `prefix f` to search windows by name
9. **Pane to window**: `prefix !` to break a pane into its own window
10. **Reload config**: `prefix r` after editing tmux.conf

---

*Generated for tmux configuration at `~/dotfiles/tmux/tmux.conf`*
