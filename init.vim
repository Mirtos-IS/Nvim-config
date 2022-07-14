call plug#begin()

"Fuzzy Finder
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Better HTML edit
    Plug 'mattn/emmet-vim'
"Pretty Colors
    Plug 'tomasiser/vim-code-dark'
"Directory navigation
    Plug 'preservim/nerdtree'
"Better and prettier layour
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
"Better python syntax and colors
    Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }
"Syntax highlighter
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'ryanoasis/vim-devicons'
    Plug 'sheerun/vim-polyglot'
    Plug 'jez/vim-better-sml'
"For PHP
    "Plug 'StanAngeloff/php.vim'
    Plug 'rayburgemeestre/phpfolding.vim'
    Plug '2072/PHP-Indenting-for-VIm'
    Plug 'tpope/vim-commentary'
    Plug 'adoy/vim-php-refactoring-toolbox'
    Plug 'Mirtos-IS/PHPUnit.vim'
    Plug 'Mirtos-IS/auto-ctags-cmd.vim'
    Plug 'phpactor/phpactor', {'for': 'php', 'tag': '*', 'do': 'composer install --no-dev -o'}
"Random Plugins
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}
    Plug 'psliwka/vim-smoothie'| "smooth C-d, C-u, C-f, C-b bc i get lost a lot using it
    Plug 'windwp/nvim-autopairs'
    Plug 'tpope/vim-surround'

call plug#end()

lua require("nvim-autopairs").setup {}
"load macros and shortcuts
    runtime maps.vim
"Load ColorScheme
    runtime view.vim
"Load Function
    runtime functions.vim
"Load Commands i have set
    runtime commands.vim
    runtime snippets.vim
"Built in
    set showcmd
    "row number
        set number
        set relativenumber
        set ruler
        set nohlsearch
        set path+=**
        set wildmenu
    "right focus when splitting
        set splitright
        set splitbelow
    "mouse suport
        set mouse=a
    "no newline if reach the horizontal limit
        set nowrap
    "fzf always default to current directory
        set autochdir
    "set yank to clipboard as default
        set clipboard=unnamedplus
        set tabstop=4
        set softtabstop=4
        set shiftwidth=4
        set expandtab
        set fillchars=fold:\ 
    "Indent
        set autoindent
        set smartindent

"Emmet only for html and css files

    let g:user_emmet_install_global = 0
    autocmd FileType html,css,php,blade,blade.php EmmetInstall
    "Let leader key being something more easy to use
    let g:user_emmet_leader_key='<C-SPACE>'

"PHPfold
    let g:DisableAutoPHPFolding=1
    map <silent> <M-O>5P <Esc>:EnablePHPFolds<CR>
    map <silent> <M-O>5Q <Esc>:DisablePHPFolds<CR>


"PHP-Refactoting-toolbox
    let g:vim_php_refactoring_auto_validate_sg = 1
    let g:vim_php_refactoring_use_default_mapping = 0
    let g:vim_php_refactoring_auto_validate_g = 1



" changing location of phpunit files
    let g:phpunit_test_root = 'tests/Unit'
    let g:phpunit_src_root = 'app'
    let g:phpunit_bin = 'vendor/bin/phpunit'
    let g:phpunit_options = []

" ctags plugin 
    let g:project_dir = 'api'
