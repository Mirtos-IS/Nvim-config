vim.o.completeopt='menu,menuone,noselect'

--load vimscript stuff
vim.o.showcmd = true
vim.o.scrolloff = 10
vim.opt.iskeyword:append('$,-,@,#')
vim.o.number = true
vim.o.relativenumber = true
vim.o.ruler = true
vim.o.hlsearch = false
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.laststatus=3
vim.o.mouse=false
vim.o.wrap = false
vim.o.pumblend = 30
vim.o.pumheight = 15
vim.o.autochdir = true
vim.o.tabstop=4
vim.o.softtabstop=4
vim.o.shiftwidth=4
vim.o.expandtab = true
vim.opt.fillchars = {fold = " "}
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldenable = false
vim.o.swapfile = false
vim.o.undofile = true
--vim.o.langremap = true

vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  callback = function ()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end
})

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = {'*.lua', '*.vue', '*.js', '*.vim', '*.blade.php'},
  callback = function ()
    vim.opt_local.tabstop=2
    vim.opt_local.softtabstop=2
    vim.opt_local.shiftwidth=2
  end
})

vim.api.nvim_create_user_command('MyConfig', function ()
    require('telescope.builtin').nvim_files()
end
, {})
