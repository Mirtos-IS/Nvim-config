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
  --fuzzy finder
  "ibhagwan/fzf-lua",

  "nvim-lua/plenary.nvim",
  --colorscheme
  "catppuccin/nvim", name = "catppuccin",
  --fancy statusbar and tabline
  'tiagovla/scope.nvim',
  'vimpostor/vim-tpipeline',
  --QoL plugins
  "folke/zen-mode.nvim",
  'windwp/nvim-autopairs',
  {'NvChad/nvim-colorizer.lua', lazy = true},
  --lsp
  'neovim/nvim-lspconfig',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-nvim-lua',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/nvim-cmp',
  'L3MON4D3/LuaSnip',
  'saadparwaiz1/cmp_luasnip',
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  --treesitter
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
  'nvim-treesitter/nvim-treesitter-context',
  {'nvim-treesitter/playground', lazy = true},
  --random plugs
  {'dstein64/vim-startuptime'},
  'rcarriga/nvim-notify',
  --git plugins
  'f-person/git-blame.nvim',
  'tpope/vim-fugitive',
  {'Mirtos-IS/harpoon', lazy = true },
  --tmux
  { "alexghergh/nvim-tmux-navigation" },
}
local opts = {}

require('lazy').setup(plugins, opts)

require("maps")
require("config")
require("plug-config")
require("commands")
