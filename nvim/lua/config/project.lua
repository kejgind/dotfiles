-- Project type detection helpers
-- Used by LSP and formatting configs to route PHP tools per framework
--
-- Detection runs once at config load time.
-- Returns: 'wordpress', 'laravel', 'symfony', or nil (generic PHP)

local M = {}

-- WordPress: wp-config.php in project root
function M.is_wordpress()
  local cwd = vim.fn.getcwd()
  return vim.fn.filereadable(cwd .. '/wp-config.php') == 1
end

-- Symfony: symfony.lock, config/bundles.php, or bin/console
function M.is_symfony()
  local cwd = vim.fn.getcwd()
  return vim.fn.filereadable(cwd .. '/symfony.lock') == 1
    or vim.fn.filereadable(cwd .. '/config/bundles.php') == 1
    or vim.fn.filereadable(cwd .. '/bin/console') == 1
end

-- Laravel: artisan file or vendor/laravel directory
function M.is_laravel()
  local cwd = vim.fn.getcwd()
  return vim.fn.filereadable(cwd .. '/artisan') == 1
    or vim.fn.isdirectory(cwd .. '/vendor/laravel') == 1
end

-- Detect project type, checked in priority order:
--   1. WordPress (most specific marker)
--   2. Laravel (artisan is unique to Laravel)
--   3. Symfony (checked last, broader markers)
--
-- Framework -> LSP -> Formatter mapping:
--   wordpress -> intelephense -> intelephense LSP formatting
--   laravel   -> phptools     -> pint
--   symfony   -> phptools     -> php-cs-fixer
--   nil       -> phptools     -> LSP fallback (phptools)
function M.detect()
  if M.is_wordpress() then
    return 'wordpress'
  end
  if M.is_laravel() then
    return 'laravel'
  end
  if M.is_symfony() then
    return 'symfony'
  end
  return nil
end

return M
