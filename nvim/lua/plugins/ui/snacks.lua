return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  -- @type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    -- explorer = { enabled = true },
    -- picker = {
    --   enabled = true,
    --   hidden = true,
    --   ignored = true,
    --   exclude = { 'node_modules', '.git' },
    -- },

    -- Disable notifier to avoid conflict with mini.notify
    notifier = { enabled = false },

    lazygit = {},
    animate = {},
    scroll = { enabled = true },
  },
  keys = {
    -- Top Pickers & Explorer
    -- {
    --   '<leader>e',
    --   function()
    --     Snacks.explorer()
    --   end,
    --   desc = 'File Explorer',
    -- },
    {
      '<leader>gg',
      function()
        Snacks.lazygit()
      end,
      desc = 'Lazygit',
    },
  },
}
