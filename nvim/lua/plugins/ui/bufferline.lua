-- Buffer line with full width (no offsets for sidebars)
return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  opts = {
    options = {
      -- Use icons from nerd fonts
      show_buffer_icons = vim.g.have_nerd_font,
      show_buffer_close_icons = true,
      show_close_icon = true,

      -- LSP diagnostics integration
      diagnostics = 'nvim_lsp',
      diagnostics_indicator = function(count, level)
        local icon = level:match 'error' and ' ' or ' '
        return ' ' .. icon .. count
      end,

      -- Show buffer numbers for quick navigation
      numbers = 'ordinal',

      -- Active buffer indicator style
      indicator = {
        style = 'underline',
      },

      -- Styling
      separator_style = 'thin',
      always_show_bufferline = true,
    },
  },
}
