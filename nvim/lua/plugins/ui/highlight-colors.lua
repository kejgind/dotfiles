-- Highlight color codes with their actual colors
return {
  'brenoprata10/nvim-highlight-colors',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    -- Render style: 'background', 'foreground', or 'virtual'
    render = 'background',

    -- Enable different color formats
    enable_hex = true,
    enable_short_hex = true,
    enable_rgb = true,
    enable_hsl = true,
    enable_var_usage = true,
    enable_named_colors = true,
    enable_tailwind = false,
  },
}
