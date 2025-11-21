-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time (increased from 250ms to reduce terminal lag)
vim.o.updatetime = 1000

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.o.list = true
vim.o.listchars = 'tab:» ,trail:·,nbsp:␣'

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10
vim.o.sidescrolloff = 10

-- Ask for confirmation instead of erroring
vim.o.confirm = true

-- Configure tabs size
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4


-- Change diagnostic symbols in the sign column (gutter)
if vim.g.have_nerd_font then
  vim.diagnostic.config({
    signs = {
      text = {
        [1] = '',  -- ERROR
        [2] = '',  -- WARN
        [3] = '',  -- INFO
        [4] = '',  -- HINT
      },
      numhl = {
        [1] = 'DiagnosticSignError',
        [2] = 'DiagnosticSignWarn',
        [3] = 'DiagnosticSignInfo',
        [4] = 'DiagnosticSignHint',
      },
      texthl = {
        [1] = 'DiagnosticSignError',
        [2] = 'DiagnosticSignWarn',
        [3] = 'DiagnosticSignInfo',
        [4] = 'DiagnosticSignHint',
      },
    },
  })
end
