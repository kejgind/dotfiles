-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Set the global namespace
_G.om = {}

-- Load secrets from ~/.secrets/ directory
local function load_secrets()
  local secrets_dir = vim.fn.expand '~/.secrets'
  local secrets = {}

  if vim.fn.isdirectory(secrets_dir) == 1 then
    -- Get only top-level files (no subdirectories)
    local files = vim.fn.globpath(secrets_dir, '*', false, true)
    for _, filepath in ipairs(files) do
      -- Skip directories, process only files
      if vim.fn.isdirectory(filepath) == 0 then
        local filename = vim.fn.fnamemodify(filepath, ':t')
        -- Convert filename to uppercase key (e.g., context7_api_key → CONTEXT7_API_KEY)
        local key = filename:upper()

        -- Read file content and trim whitespace
        if vim.fn.filereadable(filepath) == 1 then
          local content = vim.fn.readfile(filepath)
          if #content > 0 then
            secrets[key] = vim.trim(content[1])
          end
        end
      end
    end
  else
    vim.notify('Secrets directory not found: ' .. secrets_dir, vim.log.levels.WARN)
  end

  return secrets
end
_G.om.secrets = load_secrets()
