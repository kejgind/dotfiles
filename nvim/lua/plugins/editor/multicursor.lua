-- Multiple cursors plugin
-- https://github.com/jake-stewart/multicursor.nvim
return {
  'jake-stewart/multicursor.nvim',
  branch = '1.0',
  event = 'VeryLazy',
  config = function()
    local mc = require 'multicursor-nvim'
    mc.setup()

    ---@diagnostic disable-next-line: undefined-global
    local set = vim.keymap.set

    -- Vertical cursors - add cursor above/below
    set({ 'n', 'x' }, '<C-Up>', function()
      mc.lineAddCursor(-1)
    end, { desc = 'Add cursor above' })
    set({ 'n', 'x' }, '<C-Down>', function()
      mc.lineAddCursor(1)
    end, { desc = 'Add cursor below' })

    -- Match word/selection under cursor
    set({ 'n', 'x' }, '<C-n>', function()
      mc.matchAddCursor(1)
    end, { desc = 'Add cursor to next match' })
    set({ 'n', 'x' }, '<C-p>', function()
      mc.matchAddCursor(-1)
    end, { desc = 'Add cursor to prev match' })

    -- Skip match (don't add cursor, move to next/prev)
    set({ 'n', 'x' }, '<leader>s', function()
      mc.matchSkipCursor(1)
    end, { desc = '[S]kip next match' })
    set({ 'n', 'x' }, '<leader>S', function()
      mc.matchSkipCursor(-1)
    end, { desc = '[S]kip prev match' })

    -- Match ALL occurrences in buffer
    set({ 'n', 'x' }, '<leader>A', mc.matchAllAddCursors, { desc = 'Match [A]ll in buffer' })

    -- Mouse support - add/remove cursors with Ctrl+Click
    set('n', '<C-LeftMouse>', mc.handleMouse, { desc = 'Add/remove cursor' })

    -- Clear cursors with leader+Esc (keeps <Esc> for clearing search highlights)
    set('n', '<leader><Esc>', function()
      if not mc.cursorsEnabled() then
        mc.enableCursors()
      else
        mc.clearCursors()
      end
    end, { desc = 'Clear multicursors' })

    -- Customize cursor appearance
    local hl = vim.api.nvim_set_hl
    hl(0, 'MultiCursorCursor', { link = 'Cursor' })
    hl(0, 'MultiCursorVisual', { link = 'Visual' })
    hl(0, 'MultiCursorSign', { link = 'SignColumn' })
    hl(0, 'MultiCursorDisabledCursor', { link = 'Visual' })
    hl(0, 'MultiCursorDisabledVisual', { link = 'Visual' })
    hl(0, 'MultiCursorDisabledSign', { link = 'SignColumn' })
  end,
}
