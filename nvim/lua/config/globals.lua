-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Set the global namespace
_G.om = {}

-- Load secrets from ~/.config/secrets.env
local function load_secrets()
  local secrets_file = vim.fn.expand '~/.config/secrets.env'
  local secrets = {}
  if vim.fn.filereadable(secrets_file) == 1 then
    for line in io.lines(secrets_file) do
      local key, value = line:match '^([^=]+)=(.+)$'
      if key and value then
        secrets[key] = value
      end
    end
  end
  return secrets
end
_G.om.secrets = load_secrets()
