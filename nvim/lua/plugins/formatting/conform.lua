-- Autoformat
return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format {
          async = true,
          lsp_format = 'fallback',
          timeout_ms = 1000,
        }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = true,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 500,
          lsp_format = 'fallback',
        }
      end
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      javascript = { 'prettierd', 'eslint_d', stop_after_first = true },
      typescript = { 'prettierd', 'eslint_d', stop_after_first = true },
      javascriptreact = { 'prettierd', 'eslint_d', stop_after_first = true },
      typescriptreact = { 'prettierd', 'eslint_d', stop_after_first = true },
      css = { 'stylelint', 'prettierd' },
      scss = { 'stylelint', 'prettierd' },

      -- Dynamic PHP formatter selection based on project type
      php = function(bufnr)
        local cwd = vim.fn.getcwd()

        -- Laravel: Check for artisan file
        if vim.fn.filereadable(cwd .. '/artisan') == 1 then
          return { 'pint' }
        end

        -- Symfony: Check for bin/console
        if vim.fn.filereadable(cwd .. '/bin/console') == 1 then
          return { 'php_cs_fixer' }
        end

        -- WordPress: Check for wp-config.php (use LSP fallback)
        if vim.fn.filereadable(cwd .. '/wp-config.php') == 1 then
          return {} -- Empty = LSP fallback
        end

        -- Default: use LSP fallback
        return {}
      end,

      ['twig'] = { 'twig_cs_fixer' },
      ['html.twig'] = { 'twig_cs_fixer' },
    },
    formatters = {
      twig_cs_fixer = {
        command = 'twig-cs-fixer',
        args = { 'fix', '$FILENAME' },
        stdin = false,
      },
      php_cs_fixer = {
        command = 'php-cs-fixer',
        args = { 'fix', '$FILENAME' },
        stdin = false,
      },
    },
  },
  config = function(_, opts)
    require('conform').setup(opts)
    -- This will help us see debug info
    vim.g.conform_debug = 1
  end,
}
