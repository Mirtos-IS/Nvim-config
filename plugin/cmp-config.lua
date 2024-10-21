local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require'cmp'

cmp.setup({
  preselect = false,
  window = {
    documentation = cmp.config.window.bordered(),
    completion = {
      winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu',
    },
  },
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
    ["<C-n>"] = cmp.mapping(function(fallback)
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
    ["<c-p>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-S-P>"] = cmp.mapping(function ()
      if vim.snippet.active({ direction=-1 }) then
        vim.snippet.jump(-1)
      end
    end, {"i", "s"}),
    ["<C-S-N>"] = cmp.mapping(function ()
      if vim.snippet.active({ direction=1 }) then
        vim.snippet.jump(1)
      end
    end, {"i", "s"}),
  },
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
  completion = {
    keyword_length = 1
  },
  experimental = {native_menu = false},
  sources = cmp.config.sources({
    { name = 'nvim_lua' },
    { name = 'nvim_lsp' },
    { name = 'path' }
  }, {
      { name = 'buffer' },
    })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' },
  }, {
      { name = 'buffer' },
    })
})

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
      { name = 'cmdline' }
    })
})
