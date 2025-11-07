# AGENTS.md

## Build/Lint/Test Commands
- Format: `stylua init.lua lua/`
- Check health: `nvim +checkhealth`
- Plugin status: `nvim +Lazy` (U=update, S=sync, X=clean)
- LSP tools: `nvim +Mason`
- No unit tests (this is Neovim config)

## Code Style
- **Formatting**: 2-space indent, 160 char width, single quotes, no call parens (per .stylua.toml)
- **Imports**: Use `require 'module'` (no parens), store in local vars with descriptive names
- **Structure**: Plugin specs as tables with `opts`/`config` keys, return table from plugin files
- **Naming**: snake_case for functions/vars, descriptive names (e.g., `lint_augroup` not `lg`)
- **Comments**: `--` with space, descriptive for non-obvious code
- **Keymaps**: Always include `desc` field explaining action in brackets like `[s]tage`
- **Global**: Use `_G.om = {}` namespace for globals
- **Plugins**: Categorized in `lua/plugins/{ai,completion,core,editor,formatting,lsp,ui}/`, kickstart plugins in `lua/kickstart/plugins/`
- **LSP**: Use `on_attach` callback for buffer-local keymaps, servers configured in `lua/plugins/lsp/init.lua`
- **Error handling**: Check file existence with `vim.fn.filereadable`, validate before use

## Architecture
Modular config based on Kickstart.nvim. Entry point: `init.lua` → loads `config/` modules (globals, options, keymaps, autocmds, lazy) → lazy.nvim imports categorized plugins from `plugins/{ai,completion,core,editor,formatting,lsp,ui}/` + kickstart plugins. Total ~1148 lines across all files.
