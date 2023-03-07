-- require("focus").setup({
--   cursorline = false,
--   relativenumber = false,
--   width = 110,
-- })

require("mason").setup()
require("mason-lspconfig").setup()


local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=false, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', '<cmd>lua require("telescope.builtin").lsp_definitions()<CR>', bufopts)
  vim.keymap.set('n', 'O', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>pa', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', '<cmd>lua require("telescope.builtin").lsp_references()<CR>', bufopts)
end

require("mason-lspconfig").setup_handlers {
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {
      on_attach = on_attach,
      capabilities = capabilities
    }
  end,
}

require'lspconfig'.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim', 'widget', 'volume_now', 'bat_now', 'root', 'awesome'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false, -- THIS IS THE IMPORTANT LINE TO ADD
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

require('lspconfig').emmet_ls.setup({
    -- on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'blade', 'php' },
    init_options = {
      html = {
        options = {
          -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
          ["bem.enabled"] = true,
        },
      },
    }
})

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

require('vim.treesitter.query').set_query('php', 'folds', '[ (function_definition) (function_static_declaration) (method_declaration) ] @fold ')

require('nvim-treesitter.configs').setup{
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}

require("toggleterm").setup{
  open_mapping = [[<C-t>]],
  hide_number = true,
  persist_mode = false,
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
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require'cmp'
local luasnip = require("luasnip")

cmp.setup({
  mapping = {
    ['<C-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-h>'] = cmp.mapping.scroll_docs(4),
    ["<S-CR>"] = cmp.mapping.confirm { select = true },
    ["<c-space>"] = cmp.mapping.complete(),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-a>"] = cmp.mapping(function ()
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      end
    end, {"i", "s"}),
    ["<C-n>"] = cmp.mapping(function ()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      end
    end, {"i", "s"}),
  },
  snippet = {
    expand = function(args)
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
require("nvim-dap-virtual-text").setup{
  enabled = true,
}
require("dapui").setup()

require'nvim-treesitter.configs'.setup {
  textobjects = {
    move = {
      enable = true,
      set_jumps = false, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["[["] = "@method",
      },
      goto_next_end = {
        ["[]"] = "@method",
      },
      goto_previous_start = {
        ["]]"] = "@method",
      },
      goto_previous_end = {
        ["]["] = "@method",
      },
    },
  },
}

require('Comment').setup {
  sticky = true,
}
local builtin = require('telescope.builtin')
local actions = require("telescope.actions")
require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
  },
  pickers = {
    live_grep = {
      mappings = {
        i = {
          ["<LEFT>"] = function(prompt_bufnr)
            local dir = vim.fn.expand("%:p:h:h")
            require("telescope.actions").close(prompt_bufnr)
            vim.cmd(string.format("silent cd %s", dir))
            builtin.live_grep()
          end,
          ["<RIGHT>"] = function(prompt_bufnr)
            local selection = require("telescope.actions.state").get_selected_entry()
            local dir = vim.fn.fnamemodify(selection.path, ":p:h")
            require("telescope.actions").close(prompt_bufnr)
            -- Depending on what you want put `cd`, `lcd`, `tcd`
            vim.cmd(string.format("silent cd %s", dir))
            builtin.live_grep()
          end
        }
      }
    },
    find_files = {
      mappings = {
        i = {
          ["<LEFT>"] = function(prompt_bufnr)
            local dir = vim.fn.expand("%:p:h:h")
            require("telescope.actions").close(prompt_bufnr)
            vim.cmd(string.format("silent cd %s", dir))
            builtin.find_files()
          end,
          ["<RIGHT>"] = function(prompt_bufnr)
            local selection = require("telescope.actions.state").get_selected_entry()
            local dir = vim.fn.fnamemodify(selection.path, ":p:h")
            require("telescope.actions").close(prompt_bufnr)
            -- Depending on what you want put `cd`, `lcd`, `tcd`
            vim.cmd(string.format("silent cd %s", dir))
            builtin.find_files()
          end
        }
      }
    },
  }
})

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})

require('telescope').load_extension('fzf')
require 'colorizer'.setup({
 user_default_options = {
    mode = "virtualtext"
  }
})

-- require('gitblame').init()
-- require('gitblame').disable()

require('plugin.todolist.window')
require("plugin.sail_test.commands")
require('view')
