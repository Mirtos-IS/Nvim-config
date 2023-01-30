require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  --fuzzy finder
  use 'mattn/emmet-vim'
  use { 'nvim-telescope/telescope.nvim', tag = '0.1.1', requires = { {'nvim-lua/plenary.nvim'} } }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  --colorscheme
  use 'tomasiser/vim-code-dark'
  --fancy airline
  use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
  use 'tiagovla/scope.nvim'
  --QoL plugins
  use 'tpope/vim-surround'
  use 'numToStr/Comment.nvim'
  use 'tpope/vim-repeat'
  use 'windwp/nvim-autopairs'
  use 'moll/vim-bbye'
  use 'psliwka/vim-smoothie' --"smooth C-d, C-u, C-f, C-b bc i get lost a lot using it
  --php plugins
  -- use 'adoy/vim-php-refactoring-toolbox'
  --debug
  use 'mfussenegger/nvim-dap'
  use "rcarriga/nvim-dap-ui"
  use "theHamsta/nvim-dap-virtual-text"
  use "nvim-telescope/telescope-dap.nvim"
  --lsp
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  --fancy notification
  use 'rcarriga/nvim-notify'
  --treesitter
  use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'nvim-treesitter/playground'
  --random plugs
  use 'akinsho/toggleterm.nvim'
  use 'phaazon/hop.nvim'
  use 'dstein64/vim-startuptime'
  use { "beauwilliams/focus.nvim", config = function() require("focus").setup() end }
  --git plugins
  use 'f-person/git-blame.nvim'
  use 'tpope/vim-fugitive'
end)

vim.cmd('source ~/.config/nvim/vimscript/functions.vim')
vim.cmd('source ~/.config/nvim/vimscript/commands.vim')
vim.cmd('source ~/.config/nvim/vimscript/snippets.vim')
vim.cmd('source ~/.config/nvim/vimscript/plugin-config.vim')

require("maps")
require("config")
require("plug-config")
