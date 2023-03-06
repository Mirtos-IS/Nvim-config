local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
   -- 'wbthomason/packer.nvim',
  --fuzzy finder
   'mattn/emmet-vim',
   { 'nvim-telescope/telescope.nvim', version = '0.1.1', dependencies = { {'nvim-lua/plenary.nvim'} } },
   -- {'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
   {'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },
  --colorscheme
   'tomasiser/vim-code-dark',
  --fancy lualine
   { 'nvim-lualine/lualine.nvim', dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true } },
   'tiagovla/scope.nvim',
  --QoL plugins
   'tpope/vim-surround',
   'numToStr/Comment.nvim',
   'tpope/vim-repeat',
   'windwp/nvim-autopairs',
   'moll/vim-bbye',
   'psliwka/vim-smoothie', --"smooth C-d, C-u, C-f, C-b bc i get lost a lot using it
   'NvChad/nvim-colorizer.lua',
  --php plugins
  --  'adoy/vim-php-refactoring-toolbox'
  --debug
   'mfussenegger/nvim-dap',
   "rcarriga/nvim-dap-ui",
   "theHamsta/nvim-dap-virtual-text",
   "nvim-telescope/telescope-dap.nvim",
  --lsp
   'neovim/nvim-lspconfig',
   'hrsh7th/cmp-nvim-lsp',
   'hrsh7th/cmp-buffer',
   'hrsh7th/cmp-path',
   'hrsh7th/cmp-cmdline',
   'hrsh7th/nvim-cmp',
   'L3MON4D3/LuaSnip',
   'saadparwaiz1/cmp_luasnip',
   "williamboman/mason.nvim",
   "williamboman/mason-lspconfig.nvim",
  --fancy notification
   'rcarriga/nvim-notify',
  --treesitter
   {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
   'nvim-treesitter/nvim-treesitter-textobjects',
   'nvim-treesitter/playground',
  --random plugs
   'akinsho/toggleterm.nvim',
   'phaazon/hop.nvim',
   'dstein64/vim-startuptime',
  --  "beauwilliams/focus.nvim"
  --git plugins
   {'f-person/git-blame.nvim', lazy = true},
   'tpope/vim-fugitive'
}
local opts = {}

require('lazy').setup(plugins, opts)

vim.cmd('source ~/.config/nvim/vimscript/functions.vim')
vim.cmd('source ~/.config/nvim/vimscript/commands.vim')
vim.cmd('source ~/.config/nvim/vimscript/plugin-config.vim')

require("maps")
require("config")
require("plug-config")
