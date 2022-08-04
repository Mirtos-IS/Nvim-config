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
    keys = 'etovxqpdygfblzhckisuran',
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
        disable = {"php", "vim"},
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

require'lspconfig'.intelephense.setup{}

  local cmp = require'cmp'

  cmp.setup({
    mapping = cmp.mapping({
      ['<TAB>'] = cmp.mapping.select_next_item(),
      ['<S-TAB>'] = cmp.mapping.select_prev_item(),
      ['<S-CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    completion = {
        keyword_length = 2
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
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['intelephense'].setup {
    capabilities = capabilities
  }
