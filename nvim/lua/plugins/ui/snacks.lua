---@diagnostic disable: undefined-global
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

    -- Terminal enabled with performance optimizations
    terminal = {
      win = {
        style = 'terminal',
      },
    },
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

    -- Terminal toggle - regular size
    {
      '<leader>tt',
      function()
        Snacks.terminal.toggle(nil, { win = { position = 'bottom', height = 0.3 } })
      end,
      desc = 'Toggle Terminal',
      mode = { 'n', 't' },
    },

    -- Terminal maximized view (Zed-like behavior)
    {
      '<leader>tm',
      function()
        -- Get current window and check if it's a terminal
        local win = vim.api.nvim_get_current_win()
        local buf = vim.api.nvim_win_get_buf(win)
        local ft = vim.bo[buf].filetype

        if ft == 'snacks_terminal' then
          -- Resize the current terminal window
          local height = math.floor(vim.o.lines * 0.95)
          vim.api.nvim_win_set_height(win, height)
        else
          -- Open new maximized terminal
          Snacks.terminal.toggle(nil, { win = { position = 'bottom', height = 0.95 } })
        end
      end,
      desc = 'Maximize Terminal',
      mode = { 'n', 't' },
    },

    -- Terminal normal size (restore from maximized)
    {
      '<leader>tn',
      function()
        -- Get current window and check if it's a terminal
        local win = vim.api.nvim_get_current_win()
        local buf = vim.api.nvim_win_get_buf(win)
        local ft = vim.bo[buf].filetype

        if ft == 'snacks_terminal' then
          -- Resize to normal size
          local height = math.floor(vim.o.lines * 0.3)
          vim.api.nvim_win_set_height(win, height)
        end
      end,
      desc = 'Normal Terminal Size',
      mode = { 'n', 't' },
    },
  },
}
