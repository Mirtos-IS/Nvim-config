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
  vim.keymap.set('n', 'g<localleader>e', function () vim.cmd("vsplit") require("fzf-lua").lsp_definitions({ jump_to_single_result = true }) end, {silent=true})
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
