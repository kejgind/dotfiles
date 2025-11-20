# Neovim Keymaps Reference

Comprehensive keymap reference for your Neovim configuration.

## Legend

| Symbol | Meaning |
|--------|---------|
| `<leader>` | Space key |
| `<C-x>` or `<c-x>` | Ctrl + x |
| `<M-x>` | Alt/Meta + x |
| `<S-x>` | Shift + x |
| `<CR>` | Enter/Return key |
| `<Esc>` | Escape key |
| `<Tab>` | Tab key |

**Mode Indicators:**
- `n` = Normal mode
- `v`/`x` = Visual/Visual-block mode
- `i` = Insert mode
- `t` = Terminal mode

---

## Global Navigation (Go-to Keymaps)

These fundamental navigation keymaps work across your codebase and are provided by LSP from `lsp/init.lua`.

| Keymap | Mode | Description |
|--------|------|-------------|
| `gd` | `n` | Go to definition |
| `gD` | `n` | Go to declaration |
| `gr` | `n` | Go to references |
| `gI` | `n` | Go to implementation |

---

## Base Keymaps

Core Neovim keymaps from `config/keymaps.lua`.

### Search & Display

| Keymap | Mode | Description |
|--------|------|-------------|
| `<Esc>` | `n` | Clear search highlights |

### Window Navigation

| Keymap | Mode | Description |
|--------|------|-------------|
| `<C-h>` | `n` | Move focus to left window |
| `<C-l>` | `n` | Move focus to right window |
| `<C-j>` | `n` | Move focus to lower window |
| `<C-k>` | `n` | Move focus to upper window |

### Terminal Mode

| Keymap | Mode | Description |
|--------|------|-------------|
| `<Esc><Esc>` | `t` | Exit terminal mode |

### Diagnostics

| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>q` | `n` | Open diagnostic quickfix list |

### Visual Mode

| Keymap | Mode | Description |
|--------|------|-------------|
| `y` | `v` | Yank while maintaining cursor position |

### Arrow Keys (Disabled with hints)

| Keymap | Mode | Description |
|--------|------|-------------|
| `<left>` | `n` | Shows "Use h to move!!" |
| `<right>` | `n` | Shows "Use l to move!!" |
| `<up>` | `n` | Shows "Use k to move!!" |
| `<down>` | `n` | Shows "Use j to move!!" |

---

## LSP (Language Server Protocol)

LSP-specific keymaps from `lsp/init.lua`. These are available when an LSP is attached to the buffer.

### Code Navigation

| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>D` | `n` | Type definition |
| `<leader>ds` | `n` | Document symbols |
| `<leader>ws` | `n` | Workspace symbols |

### Code Actions

| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>rn` | `n` | Rename symbol |
| `<leader>ca` | `n`, `x` | Code action |
| `<leader>K` | `n` | Show hover documentation |

### Toggles

| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>th` | `n` | Toggle inlay hints |

---

## Telescope (Fuzzy Finder)

Search and navigation keymaps from `telescope.lua`.

### Search Operations

| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>sh` | `n` | Search help |
| `<leader>sk` | `n` | Search keymaps |
| `<leader>sf` | `n` | Search files |
| `<leader>ss` | `n` | Search select Telescope |
| `<leader>sw` | `n` | Search current word |
| `<leader>sg` | `n` | Search by grep |
| `<leader>sd` | `n` | Search diagnostics |
| `<leader>sr` | `n` | Search resume |
| `<leader>s.` | `n` | Search recent files |
| `<leader>sn` | `n` | Search Neovim files |
| `<leader>s/` | `n` | Search in open files |

### Buffer Navigation

| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader><leader>` | `n` | Find existing buffers |
| `<leader>/` | `n` | Fuzzy search in current buffer |

---

## Git (Gitsigns)

Git operations from `gitsigns.lua`.

### Hunk Navigation

| Keymap | Mode | Description |
|--------|------|-------------|
| `]c` | `n` | Jump to next git change |
| `[c` | `n` | Jump to previous git change |

### Hunk Operations

| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>hs` | `n`, `v` | Stage hunk |
| `<leader>hr` | `n`, `v` | Reset hunk |
| `<leader>hS` | `n` | Stage buffer |
| `<leader>hu` | `n` | Undo stage hunk |
| `<leader>hR` | `n` | Reset buffer |
| `<leader>hp` | `n` | Preview hunk |
| `<leader>hi` | `n` | Preview hunk inline |

### Git Information

| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>hb` | `n` | Blame line |
| `<leader>hd` | `n` | Diff against index |
| `<leader>hD` | `n` | Diff against last commit |

### Toggles

| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>tb` | `n` | Toggle git show blame line |
| `<leader>tD` | `n` | Toggle git show deleted |

---

## Multi-Cursor

Multi-cursor operations from `multicursor.lua`.

### Vertical Cursors

| Keymap | Mode | Description |
|--------|------|-------------|
| `<C-Up>` | `n`, `x` | Add cursor above |
| `<C-Down>` | `n`, `x` | Add cursor below |

### Match Operations

| Keymap | Mode | Description |
|--------|------|-------------|
| `<C-n>` | `n`, `x` | Add cursor to next match |
| `<C-p>` | `n`, `x` | Add cursor to previous match |
| `<leader>s` | `n`, `x` | Skip next match |
| `<leader>S` | `n`, `x` | Skip previous match |
| `<leader>A` | `n`, `x` | Match all in buffer |

### Control

| Keymap | Mode | Description |
|--------|------|-------------|
| `<C-LeftMouse>` | `n` | Add/remove cursor |
| `<leader><Esc>` | `n` | Clear multicursors |

---

## Terminal (Snacks)

Terminal and Lazygit operations from `snacks.lua`.

### Terminal

| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>tt` | `n`, `t` | Toggle terminal |
| `<leader>tm` | `n`, `t` | Maximize terminal |
| `<leader>tn` | `n`, `t` | Normal terminal size |

### Git

| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>gg` | `n` | Open Lazygit |

---

## File Explorer (Neo-tree)

File tree operations from `neo-tree.lua`.

### External Keymaps

| Keymap | Mode | Description |
|--------|------|-------------|
| `\` | `n` | Reveal/toggle Neo-tree |

### Internal Keymaps (when in Neo-tree window)

| Keymap | Mode | Description |
|--------|------|-------------|
| `\` | `n` | Close Neo-tree |
| `P` | `n` | Toggle preview |

---

## Formatting (Conform)

Code formatting from `conform.lua`.

| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>f` | `n`, `v` | Format buffer |

---

## Mini.nvim

Various editing operations from `mini.lua`.

### Surround Operations

| Keymap | Mode | Description | Example |
|--------|------|-------------|---------|
| `sa{motion}{char}` | `n` | Surround add | `saiw)` - surround word with parentheses |
| `sd{char}` | `n` | Surround delete | `sd'` - delete surrounding quotes |
| `sr{old}{new}` | `n` | Surround replace | `sr)'` - replace ) with ' |

### Visual Move

| Keymap | Mode | Description |
|--------|------|-------------|
| `<M-h>` | `v` | Move selection left |
| `<M-j>` | `v` | Move selection down |
| `<M-k>` | `v` | Move selection up |
| `<M-l>` | `v` | Move selection right |

### Text Objects (mini.ai)

Enhanced text objects work with operators like `d`, `c`, `y`, `v`:

- `va)` - visually select around parentheses
- `yinq` - yank inside next quote
- `ci'` - change inside single quotes

---

## Copilot

AI code suggestions from `copilot.lua`.

| Keymap | Mode | Description |
|--------|------|-------------|
| `<M-l>` | `i` | Accept suggestion |
| `<M-]>` | `i` | Next suggestion |
| `<M-[>` | `i` | Previous suggestion |
| `<C-]>` | `i` | Dismiss suggestion |

---

## Completion (Blink)

Autocompletion keymaps from `blink-cmp.lua`. Using the `default` preset.

### Completion Navigation

| Keymap | Mode | Description |
|--------|------|-------------|
| `<C-y>` | `i` | Accept completion |
| `<C-space>` | `i` | Open menu or docs |
| `<C-n>` | `i` | Select next item |
| `<C-p>` | `i` | Select previous item |
| `<Up>` | `i` | Select previous item |
| `<Down>` | `i` | Select next item |
| `<C-e>` | `i` | Hide menu |
| `<C-k>` | `i` | Toggle signature help |

### Snippet Navigation

| Keymap | Mode | Description |
|--------|------|-------------|
| `<Tab>` | `i` | Move right in snippet |
| `<S-Tab>` | `i` | Move left in snippet |

---

## Avante AI

AI-powered coding assistant from `avante.lua`. See `:help avante` for more details.

### Sidebar Operations

| Keymap | Mode | Description |
|--------|------|-------------|
| `]p` | `n` | Next prompt |
| `[p` | `n` | Previous prompt |
| `A` | `n` | Apply all suggestions |
| `a` | `n` | Apply cursor suggestion |
| `r` | `n` | Retry user request |
| `e` | `n` | Edit user request |
| `<Tab>` | `n` | Switch windows |
| `<S-Tab>` | `n` | Reverse switch windows |
| `d` | `n` | Remove file |
| `@` | `n` | Add file |
| `q` | `n` | Close sidebar |

### Avante Commands

| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>aa` | `n` | Show sidebar |
| `<leader>at` | `n` | Toggle sidebar visibility |
| `<leader>ar` | `n` | Refresh sidebar |
| `<leader>af` | `n` | Switch sidebar focus |
| `<leader>a?` | `n` | Select model |
| `<leader>an` | `n` | New ask |
| `<leader>ae` | `n` | Edit selected blocks |
| `<leader>aS` | `n` | Stop current AI request |
| `<leader>ah` | `n` | Select between chat histories |
| `<leader>ad` | `n` | Toggle debug mode |
| `<leader>as` | `n` | Toggle suggestion display |
| `<leader>aR` | `n` | Toggle repomap |

### Suggestion Operations

| Keymap | Mode | Description |
|--------|------|-------------|
| `<M-l>` | `i` | Accept suggestion |
| `<M-]>` | `i` | Next suggestion |
| `<M-[>` | `i` | Previous suggestion |
| `<C-]>` | `i` | Dismiss suggestion |

### File Operations

| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>ac` | `n` | Add current buffer to selected files |
| `<leader>aB` | `n` | Add all buffer files to selected files |

### Diff Operations

| Keymap | Mode | Description |
|--------|------|-------------|
| `co` | `n` | Choose ours |
| `ct` | `n` | Choose theirs |
| `ca` | `n` | Choose all theirs |
| `cb` | `n` | Choose both |
| `cc` | `n` | Choose cursor |
| `]x` | `n` | Move to next conflict |
| `[x` | `n` | Move to previous conflict |

### Confirm Operations

| Keymap | Mode | Description |
|--------|------|-------------|
| `<C-w>f` | `n` | Focus confirm window |
| `c` | `n` | Confirm code |
| `r` | `n` | Confirm response |
| `i` | `n` | Confirm input |

---

## Undotree

Undo history visualization from `undotree.lua`.

| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader><F5>` | `n` | Toggle undotree |

---

## Summary by Leader Key Groups

Quick reference for leader-key organized commands:

- **`<leader>a*`** - Avante AI operations
- **`<leader>c*`** - Code operations (LSP code actions)
- **`<leader>d*`** - Document operations (LSP symbols)
- **`<leader>f`** - Format buffer
- **`<leader>g*`** - Git operations (Lazygit)
- **`<leader>h*`** - Git hunk operations (Gitsigns)
- **`<leader>q`** - Quickfix diagnostics
- **`<leader>r*`** - Rename operations (LSP)
- **`<leader>s*`** - Search operations (Telescope)
- **`<leader>t*`** - Toggle operations (hints, blame, terminal)
- **`<leader>w*`** - Workspace operations (LSP)

---

## Quick Tips

1. **Window Navigation**: Use `<C-h/j/k/l>` for quick window switching
2. **Fuzzy Finding**: `<leader>sf` for files, `<leader>sg` for grep
3. **Git Workflow**: `<leader>gg` for Lazygit, `]c`/`[c]` for hunk navigation
4. **AI Assistance**: `<leader>aa` to open Avante sidebar
5. **Multi-cursor**: `<C-n>` to select multiple occurrences
6. **Quick Format**: `<leader>f` to format current buffer
7. **Code Navigation**: Use `gd`, `gr`, `gI` for LSP navigation
8. **Terminal**: `<leader>tt` to toggle terminal quickly

---

*Generated for Neovim configuration at `/home/krzysiek/dotfiles/nvim`*
