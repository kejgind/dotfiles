-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Set up filetype detection for Twig files
vim.filetype.add {
  extension = {
    twig = 'html.twig',
  },
  pattern = {
    ['.*%.twig'] = 'html.twig',
  },
}

-- Disable features in terminal buffers to reduce lag
vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Optimize terminal buffer performance',
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.cursorline = false
    vim.opt_local.signcolumn = 'no'
    vim.opt_local.scrollback = 10000
  end,
})
