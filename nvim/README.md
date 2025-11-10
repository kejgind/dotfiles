# Neovim Config

Personal Neovim configuration forked from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).

## Structure

- `init.lua` - Main config with core settings + lazy.nvim plugin specs
- `lua/config/` - Modular settings (options, keymaps, autocmds, globals)
- `lua/plugins/` - Custom plugin configs organized by category
- `lua/kickstart/plugins/` - Kickstart plugins (autopairs, gitsigns, indent_line, lint, neo-tree)

## Key Plugins

**Core:** lazy.nvim, treesitter, telescope, blink-cmp, which-key, snacks.nvim  
**LSP:** native LSP (lua_ls, ts_ls, etc) + Mason for tool management  
**AI:** Copilot (inline) + Avante (chat) + MCPHub (MCP bridge) + Context7 (library docs)  
**Editor:** gitsigns, mini.nvim (surround/ai/statusline), todo-comments, undotree  
**Formatting:** conform.nvim (stylua, prettierd, etc)

## Requirements

- Neovim ≥ 0.10
- `git`, `make`, `gcc`, `ripgrep`, `fd`
- Clipboard tool (xclip/xsel/win32yank)
- Nerd Font (set `vim.g.have_nerd_font = true` in init.lua)
- Node.js + npm (for LSP servers like ts_ls)
- `npm install -g mcp-hub@latest` (for MCP integration)
- API keys in `~/.secrets/` directory (each key in separate file, e.g., `~/.secrets/api_key_name`)

## Setup

```sh
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak

# Clone this config
git clone <your-fork-url> ~/.config/nvim

# Start Neovim (lazy.nvim will install plugins automatically)
nvim
```

## Management

- `:Lazy` - Plugin status (U=update, S=sync, X=clean)
- `:Mason` - LSP/formatter/linter tools
- `:checkhealth` - Diagnostic info
- Format: `stylua init.lua lua/`

## Notes

Modular structure derived from kickstart. See `AGENTS.md` for code style + architecture details.
