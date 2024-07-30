require("mason").setup()
require("mason-lspconfig").setup()


local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  client.server_capabilities.semanticTokensProvider = nil
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=false, buffer=bufnr }
  vim.keymap.set('n', '<localleader>D', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'O', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<localleader>i', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<localleader>ld', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<localleader>lr', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<localleader>la', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<localleader>e', function () require("fzf-lua").lsp_definitions({ jump_to_single_result = true }) end, {silent=true})
  vim.keymap.set('n', '<localleader>r', function ()
    require('fzf-lua').lsp_references({
      winopts = {preview = {layout = "vertical", vertical = "up:60%"}}
    })
  end, bufopts)
end

local lspconfig = require('lspconfig')
require("mason-lspconfig").setup_handlers {
  function (server_name) -- default handler (optional)
    lspconfig[server_name].setup {
      on_attach = on_attach,
      capabilities = capabilities
    }
  end,
}

lspconfig.html.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "html", "templ" },
})

lspconfig.htmx.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "html", "templ" },
})

lspconfig.lua_ls.setup {
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

require("nvim-autopairs").setup {
  ignored_next_char = [=[[%w%%%'%[%"%.$&]]=],
  enable_check_bracket_line = false,
  map_c_h = true,
  map_c_w = true,
  fast_wrap = {
    map = '<M-e>'
  },
}

vim.notify = require("notify")

require('nvim-treesitter.configs').setup{ auto_install = true,
  sync_install = false,
  ensure_installed = {},
  ignore_install = {},
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
      toggle_query_editor = 'l',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'k',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
  textobjects = {
    move = {
      enable = true,
      set_jumps = false,
      goto_next_start = {
        ["]]"] = "@method",
      },
      goto_previous_start = {
        ["[["] = "@method",
      },
    },
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["im"] = "@function.method.body",
        ["km"] = "@method",
      },
      selection_nodes = {
        ["@function.method.body"] = 'V',
        ["@method"] = 'V',
      },
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
  preselect = false,
  mapping = {
    ['<C-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-h>'] = cmp.mapping.scroll_docs(4),
    ["<M-Space>"] = cmp.mapping.confirm { select = true },
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
    ["<C-e>"] = cmp.mapping(function ()
      luasnip.change_choice(1)
    end, {"i", "s"}),
    ["<C-o>"] = cmp.mapping(function ()
      luasnip.change_choice(-1)
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
    { name = 'nvim_lua' },
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

local oldDir, newDir
require("fzf-lua").setup({
  winopts = {
    preview = {
      horizontal = 'right:50%',
    },
    on_close = function()
      if newDir == nil or newDir == oldDir then
        newDir = nil
        oldDir = nil
      else
        oldDir = newDir
      end
    end,
  },
  fzf_opts = {
    ["--layout"]         = "default",
  },
  files = {
    git_icons = false,
  },
  actions = {
    true,
    files = {
    git_icons = false,
      true,
      ["LEFT"] = function ()
        oldDir = oldDir or vim.fn.expand("%:p:h")
        newDir = vim.fn.fnamemodify(oldDir, ":p:h:h")
        require("fzf-lua").files({cwd = newDir})
      end
    },
  },
  grep = {
    actions = {
      ["LEFT"] = function ()
        oldDir = oldDir or vim.fn.expand("%:p:h")
        newDir = vim.fn.fnamemodify(oldDir, ":p:h:h")
        require("fzf-lua").live_grep({cwd = newDir})
      end
    }
  },
  previewers = {
    builtin = {
      extensions = {
        ["png"]       = { "viu", "-b" },
        ["jpg"]       = { "viu", "-b" },
      }
    }
  }
})

require 'colorizer'.setup({
{ "css", "javascript", "lua", "vim", "toml", "typescript", "conf", "vue", "templ" },
 user_default_options = {
    mode = "virtualtext"
  }
})

require('gitblame').setup({
  enabled = false,
  delay = 0
})

require('harpoon').setup({
  global_settings = {
    mark_branch = true,
  }
})

require("treesitter-context").setup()

require("plugins")
