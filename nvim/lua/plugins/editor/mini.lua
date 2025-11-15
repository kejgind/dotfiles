-- Collection of various small independent plugins/modules
return {
  'nvim-mini/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    -- Move any selection in any direction
    -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
    require('mini.move').setup()

    -- Work with trailing whitespace
    require('mini.trailspace').setup()

    -- Show notifications in floating window
    require('mini.notify').setup()

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    local statusline = require 'mini.statusline'
    -- set use_icons to true if you have a Nerd Font
    statusline.setup { use_icons = vim.g.have_nerd_font }

    -- Custom location section with spaces around separator
    -- Shows: line|total │ column|total (or line │ column when truncated)
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function(args)
      args = args or {}
      if MiniStatusline.is_truncated(args.trunc_width or 75) then
        return string.format('%d │ %d', vim.fn.line '.', vim.fn.virtcol '.')
      end
      return string.format('%d|%d │ %d|%d', vim.fn.line '.', vim.fn.line '$', vim.fn.virtcol '.', vim.fn.virtcol '$')
    end

    -- ... and there is more!
    --  Check out: https://github.com/nvim-mini/mini.nvim
  end,
}
