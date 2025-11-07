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
          -- lsp_format = 'fallback',
          lsp_format = 'never',
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
      javascript = { 'prettier', 'eslint_d', stop_after_first = true },
      typescript = { 'prettier', 'eslint_d', stop_after_first = true },
      javascriptreact = { 'prettier', 'eslint_d', stop_after_first = true },
      typescriptreact = { 'prettier', 'eslint_d', stop_after_first = true },
      css = { 'stylelint', 'prettier' },
      scss = { 'stylelint', 'prettier' },
      php = { 'pint' },
      ['twig'] = { 'twig_cs_fixer' },
      ['html.twig'] = { 'twig_cs_fixer' },
    },
    formatters = {
      twig_cs_fixer = {
        command = 'twig-cs-fixer',
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
