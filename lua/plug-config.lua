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
  vim.keymap.set('n', '<localleader>d', '<cmd>lua require("telescope.builtin").lsp_definitions()<CR>', bufopts)
  vim.keymap.set('n', 'O', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<localleader>i', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<localleader>ld', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<localleader>lr', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<localleader>la', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<localleader>e', function () require("telescope.builtin").lsp_definitions() end, {silent=true})
  vim.keymap.set('n', '<localleader>r', function ()
    require('telescope.builtin').lsp_references({
    layout_strategy='vertical',
    path_display = {
      smart = true,
    }})
  end, bufopts)
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
    filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'blade' },
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
  enable_check_bracket_line = false,
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

require("toggleterm").setup{
  open_mapping = [[<C-t>]],
  hide_number = true,
  persist_mode = false,
  start_in_insert = true,
  insert_mappings = false,
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
  preselect = false,
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

-- Setup lspconfig.

local dap = require'dap'
dap.adapters.php = {
  type = "executable",
  command = "node",
  args = { '/home/mirtos/GitRepos/vscode-php-debug/out/phpDebug.js' }
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

require('Comment').setup {
  sticky = true,
  extra = {
    ---Add comment on the line above
    above = 'gcL',
    ---Add comment on the line below
    below = 'gcl',
    ---Add comment at the end of line
    eol = 'gcK',
  },
}
local builtin = require('telescope.builtin')
local actions = require("telescope.actions")
local action_state = require('telescope.actions.state')

local custom_actions = {}

function custom_actions.fzf_multi_select(prompt_bufnr)
  local picker = action_state.get_current_picker(prompt_bufnr)
  local num_selections = table.getn(picker:get_multi_selection())

  if num_selections > 1 then
    picker = action_state.get_current_picker(prompt_bufnr)
    for _, entry in ipairs(picker:get_multi_selection()) do
      vim.cmd(string.format("%s %s", ":e!", entry.value))
    end
    vim.cmd('stopinsert')
  else
    actions.file_edit(prompt_bufnr)
  end
end

require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ['<C-h>'] = require('telescope.actions.layout').toggle_preview,
        ['<tab>'] = actions.toggle_selection + actions.move_selection_next,
        ['<s-tab>'] = actions.toggle_selection + actions.move_selection_previous,
        -- ['<CR>'] = custom_actions.select_default,
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
          end,
          ['<CR>'] = custom_actions.fzf_multi_select,
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
          end,
          ['<CR>'] = custom_actions.fzf_multi_select,
        }
      }
    },
  },
})

require('telescope').load_extension('fzf')
require 'colorizer'.setup({
 user_default_options = {
    mode = "virtualtext"
  }
})

require('harpoon').setup({
  mark_branch = true,
})

require("treesitter-context").setup()
require('octo').setup()
require('git').setup({
  default_mappings = false,

  keymaps = {
    blame = "<localleader>b",
    quit_blame = "<localleader>b",
    blame_commit = "<CR>",
    browse = "<localleader>go",
    open_pull_request = "<localleader>gp",
    create_pull_request = "<localleader>gn",
    diff = "<localleader>gd",
    diff_close = "<localleader>gD",
    revert = "<localleader>gr",
    revert_file = "<localleader>gR",
  },
  -- Default target branch when create a pull request
  target_branch = "development",
})

require('plugins.todolist.window')
require("plugins.sail_test.commands")
require("plugins.test-results.phpmd")
require("plugins.test-results.phpcs")
require('view')
-- require("plugins.telescope-jira.jira")
