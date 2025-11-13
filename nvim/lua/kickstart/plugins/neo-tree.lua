-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    sort_case_insensitive = true, -- used when sorting files and directories in the tree
    window = {
      mappings = {
        ['P'] = {
          'toggle_preview',
          config = {
            use_float = true,
            use_snacks_image = true, -- Enable image preview using snacks.nvim
          },
        },
      },
    },
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
          ['gp'] = 'show_filename', -- Show full filename of the current file/directory
        },
      },
    },
    commands = {
      show_filename = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        -- Extract just the filename from the full path
        local filename = vim.fn.fnamemodify(path, ':t')

        -- Create a buffer for the floating window
        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, { filename })

        -- Get cursor position
        local cursor = vim.api.nvim_win_get_cursor(0)
        local row = cursor[1]
        local col = cursor[2]

        -- Calculate floating window size based on filename length
        local win_width = #filename + 4 -- Add some padding
        local win_height = 1

        -- Create the floating window positioned just under the cursor
        local win = vim.api.nvim_open_win(buf, false, {
          relative = 'win',
          width = win_width,
          height = win_height,
          row = row, -- Position below cursor
          col = col,
          style = 'minimal',
          border = 'rounded',
          title = ' Filename ',
          title_pos = 'center',
        })

        -- Set buffer options (using non-deprecated API)
        vim.bo[buf].modifiable = false
        vim.bo[buf].bufhidden = 'wipe'

        -- Close the window after 5 seconds
        vim.defer_fn(function()
          if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, true)
          end
        end, 5000)

        -- Also close on cursor move or buffer leave
        vim.api.nvim_create_autocmd({ 'CursorMoved', 'BufLeave' }, {
          buffer = vim.api.nvim_get_current_buf(),
          once = true,
          callback = function()
            if vim.api.nvim_win_is_valid(win) then
              vim.api.nvim_win_close(win, true)
            end
          end,
        })
      end,
    },
  },
}
