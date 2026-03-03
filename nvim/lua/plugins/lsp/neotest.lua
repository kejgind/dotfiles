-- Test runner framework with PHPUnit/Pest support
-- Auto-detects vendor/bin/pest vs vendor/bin/phpunit
-- Provides keymaps to run nearest test, current file, or entire suite
-- Output displayed in floating window
return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    -- PHPUnit adapter (actively maintained, works with tree-sitter 0.25+)
    'olimorris/neotest-phpunit',
  },
  keys = {
    {
      '<leader>Tn',
      function()
        require('neotest').run.run()
      end,
      desc = '[T]est [n]earest',
    },
    {
      '<leader>Tf',
      function()
        require('neotest').run.run(vim.fn.expand '%')
      end,
      desc = '[T]est [f]ile',
    },
    {
      '<leader>Ta',
      function()
        require('neotest').run.run(vim.fn.getcwd())
      end,
      desc = '[T]est [a]ll',
    },
    {
      '<leader>To',
      function()
        require('neotest').output.open { enter = true }
      end,
      desc = '[T]est [o]utput',
    },
    {
      '<leader>Ts',
      function()
        require('neotest').summary.toggle()
      end,
      desc = '[T]est [s]ummary',
    },
    {
      '<leader>Tl',
      function()
        require('neotest').run.run_last()
      end,
      desc = '[T]est [l]ast',
    },
  },
  config = function()
    require('neotest').setup {
      -- Floating window for test output
      output = {
        open_on_run = false,
      },
      -- Adapters for PHP test frameworks
      adapters = {
        require 'neotest-phpunit' {
          -- Auto-detect: use Pest if available, otherwise PHPUnit
          phpunit_cmd = function()
            if vim.fn.filereadable 'vendor/bin/pest' == 1 then
              return 'vendor/bin/pest'
            end
            return 'vendor/bin/phpunit'
          end,
          root_files = { 'phpunit.xml', 'composer.json' },
        },
      },
    }
  end,
}
