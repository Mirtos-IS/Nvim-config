vim.o.completeopt='menu,menuone,noselect'

--load vimscript stuff
vim.o.showcmd = false
vim.o.showmode = false
vim.o.scrolloff = 10
vim.o.number = true
vim.o.relativenumber = true
vim.o.ruler = true
vim.o.hlsearch = false
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.laststatus=3
vim.o.mouse=""
vim.o.wrap = false
vim.o.pumblend = 30
vim.o.pumheight = 15
vim.o.autochdir = true
vim.o.cursorline = true
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
vim.o.signcolumn = 'no'
vim.filetype.add({
 extension = {
  templ = "templ",
 },
})

if vim.fn.empty('$TMUX') then
  vim.o.ruler=false
end
