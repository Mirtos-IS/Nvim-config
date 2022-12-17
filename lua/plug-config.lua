require("focus").setup({
    cursorline = false,
    relativenumber = false,
    width = 110,
  })

require("mason").setup()
require("mason-lspconfig").setup()

require("mason-lspconfig").setup_handlers {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {}
  end,
  -- Next, you can provide a dedicated handler for specific servers.
  -- For example, a handler override for the `rust_analyzer`:
  ["rust_analyzer"] = function ()
    require("rust-tools").setup {}
  end
}

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=false, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>pa', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
end

require'lspconfig'.tsserver.setup{}

require'lspconfig'.vuels.setup{}

require'lspconfig'.sumneko_lua.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

require('hop').setup({
    keys = 'etovxqpdgflhcisuran',
  })

require("nvim-autopairs").setup {
  ignored_next_char = [=[[%w%%%'%[%"%.$&]]=],
  map_c_h = true,
  map_c_w = true,
  fast_wrap = {
    map = '<M-e>'
  },
}

vim.notify = require("notify")

require('nvim-treesitter.configs').setup{
  auto_install = true,
    highlight = {
        disable = {"php", "vim", "vue"},
        enable = true,
        additional_vim_regex_highlighting = true,
    },
}

require("toggleterm").setup{
    open_mapping = [[<C-t>]],
    hide_number = true,
    start_in_insert = true,
    direction = 'float',
    terminal_mappings = true,
    highlights = {
        Normal = {
            guibg = "#000000",
        },
        FloatBorder = {
            guifg = "#1d99f3",
        },
    },
}


  local cmp = require'cmp'
  local luasnip = require("luasnip")

  cmp.setup({
     mapping = {
        ["<S-CR>"] = cmp.mapping.confirm { select = true },
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
            else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        },
      snippet = {
        expand = function(args)
            local luasnip = require("luasnip")
            if not luasnip then
                return
            end
            luasnip.lsp_expand(args.body)
        end,
    },
    completion = {
        keyword_length = 1
    },
    experimental = {native_menu = false},
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users.
      { name = 'path' }
    }, {
      { name = 'buffer' },
    })
  })

luasnip.config.set_config{
  history = true,

  updateevents = "TextChanged, TextChangedI",

  enable_autosnippets = true,
}

luasnip.snippets = {
  all = {
    luasnip.parser.parse_snippet("fact", "$$1 = factory($2::classe)->create($0)end"),
  },
  lua = {
    luasnip.parser.parse_snippet("fact", "$$1 = factory($2::classe)->create($0)end"),
    luasnip.parser.parse_snippet("cons", "function __construct")
  },
}
  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['intelephense'].setup {
    on_attach = on_attach,
    capabilities = capabilities
  }
  -- require('lspconfig')['sumneko_lua'].setup {
  --   on_attach = on_attach,
  --   capabilities = capabilities
  -- }
  require('lspconfig')['vuels'].setup {
    on_attach = on_attach,
    capabilities = capabilities
  }

local dap = require'dap'
dap.adapters.php = {
  type = "executable",
  command = "node",
  args = { '/path/to/vscode-php-debug/out/phpDebug.js' }
}

dap.configurations.php = {
  {
    name = "Listen for Xdebug",
    type = "php",
    request = "launch",
    hostname = "0.0.0.0",
    port = 9003,
    log = true,
    pathMappings = {
      ["/var/www/html"] = "${workspaceFolder}"
    },
    ignore = {
      "**/vendor/**/*.php"
    },
    stopOnEntry = false,
  }
}
require("nvim-dap-virtual-text").setup()
require("dapui").setup()

require("plugin.sail_test.autotest")
