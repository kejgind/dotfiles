-- AI-powered code assistant with chat interface
return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  opts = {
    provider = 'copilot',
    mode = 'agentic',
    instructions_file = 'avante.md',

    -- Behavior settings - manual control, no auto-suggestions to avoid copilot conflict
    behaviour = {
      auto_suggestions = false,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = true,
    },

    -- Window positioning - right side, 30% width
    windows = {
      position = 'right',
      width = 30,
      sidebar_header = {
        enabled = true,
        align = 'center',
      },
    },

    -- Delayed hints for selections
    selection = {
      enable = true,
      delay = 300,
    },

    -- File selector - using fzf_lua (lightweight)
    selector = {
      provider = 'fzf_lua',
    },

    -- Suggestion timing controls
    suggestion = {
      debounce = 600,
      throttle = 600,
    },

    -- MCPHub integration - inject Context7 tools via mcp_tool()
    custom_tools = function()
      local ok, mcphub_avante = pcall(require, 'mcphub.extensions.avante')
      if not ok then
        return {}
      end
      local use_mcp_tool, access_mcp_resource = mcphub_avante.mcp_tool()
      return { use_mcp_tool, access_mcp_resource }
    end,

    -- Disable Avante's built-in file operation tools (keep bash, use MCP for files)
    disabled_tools = {
      'append',
      'apply',
      'edit',
      'write',
    },

    providers = {
      copilot = {
        model = 'claude-sonnet-4.5',
        extra_request_body = {
          temperature = 0,
          max_tokens = 8192,
        },
      },
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = 'make',
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'stevearc/dressing.nvim',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    --- The below dependencies are optional,
    'echasnovski/mini.pick', -- for file_selector provider mini.pick
    'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
    'ibhagwan/fzf-lua', -- for file_selector provider fzf
    'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
    'zbirenbaum/copilot.lua', -- for providers='copilot'
    {
      -- support for image pasting
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { 'markdown', 'Avante' },
      },
      ft = { 'markdown', 'Avante' },
    },
  },
}
