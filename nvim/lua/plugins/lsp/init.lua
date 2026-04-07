-- Main LSP Configuration
return {
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    { 'mason-org/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- Useful status updates for LSP.
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { 'j-hui/fidget.nvim', opts = {} },

    -- Allows extra capabilities provided by blink.cmp
    'saghen/blink.cmp',
  },
  config = function()
    -- Brief aside: **What is LSP?**
    --
    -- LSP is an initialism you've probably heard, but might not understand what it is.
    --
    -- LSP stands for Language Server Protocol. It's a protocol that helps editors
    -- and language tooling communicate in a standardized fashion.
    --
    -- In general, you have a "server" which is some tool built to understand a particular
    -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
    -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
    -- processes that communicate with some "client" - in this case, Neovim!
    --
    -- LSP provides Neovim with features like:
    --  - Go to definition
    --  - Find references
    --  - Autocompletion
    --  - Symbol Search
    --  - and more!
    --
    -- Thus, Language Servers are external tools that must be installed separately from
    -- Neovim. This is where `mason` and related plugins come into play.
    --
    -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
    -- and elegantly composed help section, `:help lsp-vs-treesitter`

    --  This function gets run when an LSP attaches to a particular buffer.
    --    That is to say, every time a new file is opened that is associated with
    --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
    --    function will be executed to configure the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        -- NOTE: Remember that Lua is a real programming language, and as such it is possible
        -- to define small helper and utility functions so you don't have to repeat yourself.
        --
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buf = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

        -- Find references for the word under your cursor.
        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

        -- Show hover with function Definition
        map('<leader>K', vim.lsp.buf.hover, '[K]iller view')

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
            end,
          })
        end

        -- The following code creates a keymap to toggle inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, '[T]oggle Inlay [H]ints')
          -- Enable inlay hints by default
          vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
        end
      end,
    })

    -- Emmet language server for CSS, Twig, HTML, SASS, SCSS
    vim.api.nvim_create_autocmd({ 'FileType' }, {
      pattern = 'css,twig,html,sass,scss',
      callback = function()
        vim.lsp.start {
          cmd = { 'emmet-language-server', '--stdio' },
          root_dir = vim.fs.dirname(vim.fs.find({ '.git' }, { upward = true })[1]),
          -- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
          -- **Note:** only the options listed in the table are supported.
          init_options = {
            ---@type table<string, string>
            includeLanguages = {},
            --- @type string[]
            excludeLanguages = {},
            --- @type string[]
            extensionsPath = {},
            --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
            preferences = {},
            --- @type boolean Defaults to `true`
            showAbbreviationSuggestions = true,
            --- @type "always" | "never" Defaults to `"always"`
            showExpandedAbbreviation = 'always',
            --- @type boolean Defaults to `false`
            showSuggestionsAsSnippets = false,
            --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
            syntaxProfiles = {},
            --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
            variables = {},
          },
        }
      end,
    })

    -- Enhance LSP capabilities with blink.cmp
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    -- Configure lua_ls via native Neovim 0.11 API
    vim.lsp.config('lua_ls', {
      capabilities = capabilities,
      settings = {
        Lua = {
          completion = {
            callSnippet = 'Replace',
          },
          hint = {
            enable = true,
            paramName = 'All',
            paramType = true,
            arrayIndex = 'Auto',
          },
          -- diagnostics = { disable = { 'missing-fields' } },
        },
      },
    })
    vim.lsp.enable 'lua_ls'

    require('mason').setup()

    local ensure_installed = {
      'lua-language-server',
      'stylua',
      'prettierd',
      'eslint_d',
      'stylelint',
      'pint',
      'php-cs-fixer',
      'twigcs',
      'twig-cs-fixer',
      'twiggy-language-server',
      'intelephense',
    }

    -- Detect project type for PHP LSP routing
    -- See lua/config/project.lua for detection logic and framework->tool mapping
    local project = require 'config.project'
    local project_type = project.detect()

    -- Configure twig language server with framework-aware settings
    -- Laravel uses Blade (not Twig), so twiggy is disabled for Laravel projects
    -- WordPress (Timber) and generic PHP use 'twig' framework mode
    -- Symfony uses 'symfony' framework mode for enhanced support
    vim.lsp.config('twiggy_language_server', {
      settings = {
        twiggy = {
          framework = project_type == 'symfony' and 'symfony' or 'twig',
          autoInsertSpaces = true,
          inlayHints = {
            enabled = true,
            filters = {
              functionNames = true,
              variableNames = true,
            },
          },
          diagnostics = {
            twigCsFixer = true,
          },
        },
      },
    })

    -- Configure intelephense for WordPress projects
    vim.lsp.config('intelephense', {
      cmd = { 'intelephense', '--stdio' },
      filetypes = { 'php' },
      capabilities = capabilities,
      root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local cwd = assert(vim.uv.cwd())
        local root = vim.fs.root(fname, { 'wp-config.php', 'composer.json', '.git' })
        on_dir(root and vim.fs.relpath(cwd, root) and cwd)
      end,
      settings = {
        intelephense = {
          -- OPTION 1 (ACTIVE): Set to true to use intelephense formatting
          -- OPTION 2: Set to false to use external formatter (phpcbf) - configure in conform.lua
          format = { enable = true },
          stubs = {
            'wordpress',
            'bcmath',
            'curl',
            'date',
            'dom',
            'fileinfo',
            'filter',
            'gd',
            'gettext',
            'hash',
            'iconv',
            'imagick',
            'json',
            'libxml',
            'mbstring',
            'mysqli',
            'mysqlnd',
            'openssl',
            'pcre',
            'PDO',
            'pdo_mysql',
            'Phar',
            'SimpleXML',
            'sockets',
            'sodium',
            'standard',
            'tokenizer',
            'xml',
            'xmlreader',
            'xmlwriter',
            'zip',
            'zlib',
          },
        },
      },
    })

    -- Configure phptools (devsense) for Laravel, Symfony, and generic PHP projects
    vim.lsp.config('phptools', {
      cmd = { 'devsense-php-ls', '--stdio' },
      filetypes = { 'php' },
      capabilities = capabilities,
      root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local cwd = assert(vim.uv.cwd())
        local root = vim.fs.root(fname, { 'composer.json', '.git' })
        on_dir(root and vim.fs.relpath(cwd, root) and cwd)
      end,
      init_options = {
        ['0'] = _G.om.secrets.PHPTOOLS_LICENSE or '',
      },
      settings = {
        php = {
          version = '8.4',
          problems = {
            scope = 'all',
          },
          inlayHints = {
            parameters = { enabled = true },
            types = { enabled = true },
            functionReturnTypes = { enabled = true },
          },
        },
      },
    })

    -- Enable/disable PHP LSPs based on project type
    -- WordPress: intelephense (with WP stubs + formatting)
    -- Laravel/Symfony/Other: phptools (devsense)
    if project_type == 'wordpress' then
      vim.lsp.enable('intelephense', true)
      vim.lsp.enable('phptools', false)
    else
      vim.lsp.enable('intelephense', false)
      vim.lsp.enable('phptools', true)
    end

    -- Enable twiggy for all PHP projects except Laravel (which uses Blade, not Twig)
    vim.lsp.enable('twiggy_language_server', project_type ~= 'laravel')

    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      -- Disable automatic enable - we manage PHP LSPs conditionally
      automatic_enable = {
        exclude = { 'intelephense', 'phptools', 'twiggy_language_server' },
      },
    }
  end,
}
