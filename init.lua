require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  --fuzzy finder
  use 'junegunn/fzf.vim'
  use 'mattn/emmet-vim'
  --colorscheme
  use 'tomasiser/vim-code-dark'
  --fancy airline
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  --python fancy colors
  use {'numirias/semshi', run = ':UpdateRemotePlugins' }
  --fancy icons and colors regex based
  use 'ryanoasis/vim-devicons'
  use 'sheerun/vim-polyglot'
  --QoL plugins
  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'
  use 'windwp/nvim-autopairs'
  use 'Mirtos-IS/auto-ctags-cmd.vim'
  use 'moll/vim-bbye'
  use 'psliwka/vim-smoothie' --"smooth C-d, C-u, C-f, C-b bc i get lost a lot using it
  --php plugins
  use 'rayburgemeestre/phpfolding.vim'
  use '2072/PHP-Indenting-for-VIm'
  use 'adoy/vim-php-refactoring-toolbox'
  use 'Mirtos-IS/PHPUnit.vim'
  --lsp
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  --fancy notification
  use 'rcarriga/nvim-notify'
  --treesitter
  use 'akinsho/toggleterm.nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  --random plugs
  use 'phaazon/hop.nvim'
  use 'dstein64/vim-startuptime'

end)

require("maps")
require("plug-config")
require("config")

vim.cmd('source ~/.config/nvim/vimscript/functions.vim')
vim.cmd('source ~/.config/nvim/vimscript/commands.vim')
vim.cmd('source ~/.config/nvim/vimscript/snippets.vim')
vim.cmd('source ~/.config/nvim/vimscript/view.vim')
vim.cmd('source ~/.config/nvim/vimscript/plugin-config.vim')
