-- MCP Hub - Bridge for Model Context Protocol servers
return {
  'ravitemer/mcphub.nvim',
  lazy = false, -- Load immediately for Avante integration
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    -- MCP servers config location
    servers_json_path = vim.fn.stdpath('config') .. '/mcp/servers.json',

    -- Avante integration
    extensions = {
      avante = {
        make_slash_commands = true, -- Enable /mcp:context7:prompt commands
      }
    },

    -- Start with manual approval, toggle via `ga` in Hub UI
    auto_approve = false,

    -- Pass CONTEXT7_API_KEY from secrets to MCP server env
    env = {
      CONTEXT7_API_KEY = _G.om.secrets.CONTEXT7_API_KEY or '',
    },
  },
}
