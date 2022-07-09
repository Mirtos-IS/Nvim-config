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
    Plug 'c9s/phpunit.vim'
    Plug 'adoy/vim-php-refactoring-toolbox'
    Plug 'phpactor/phpactor', {'for': 'php', 'tag': '*', 'do': 'composer install --no-dev -o'}
"Random Plugins
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}
    Plug 'psliwka/vim-smoothie'| "smooth C-d, C-u, C-f, C-b bc i get lost a lot using it
    Plug 'windwp/nvim-autopairs'

call plug#end()

lua require("nvim-autopairs").setup {}
"load macros and shortcuts
    runtime maps.vim
"Load ColorScheme
    runtime view.vim

"Built in
    set showcmd
    "row number
        set number
        set relativenumber
        set ruler
        set nohlsearch
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

" Function to trim extra whitespace in whole file
    function! Trim()
        let l:save = winsaveview()
        keeppatterns %s/\s\+$//e
        call winrestview(l:save)
    endfun

    command! -nargs=0 Trim call Trim()

"Emmet only for html and css files

    let g:user_emmet_install_global = 0
    autocmd FileType html,css,php,blade,blade.php EmmetInstall
    "Let leader key being something more easy to use
    let g:user_emmet_leader_key='<C-SPACE>'

"PHPfold
    let g:DisableAutoPHPFolding=1
    map <silent> <M-O>5P <Esc>:EnablePHPFolds<CR>
    map <silent> <M-O>5Q <Esc>:DisablePHPFolds<CR>

    " Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocAction('format')

"PHP-Refactoting-toolbox
    let g:vim_php_refactoring_auto_validate_sg = 1
    let g:vim_php_refactoring_use_default_mapping = 0
    let g:vim_php_refactoring_auto_validate_g = 1



 " changing location of phpunit files
     let g:phpunit_testroot = '~/Desktop/Damas-RPG/server/api/tests'
     let g:phpunit_srcroot = '~/Desktop/Damas-RPG/server/api/app'
     let g:phpunit_bin = '~/Desktop/Damas-RPG/server/api/vendor/bin/phpunit'
     let g:phpunit_options = ["--colors"]


"FZF function to allow FZF go up to parent dir
    function! TFile(dir)
      if empty(a:dir)
        let dir = getcwd()
      else
        let dir = a:dir
      endif
      let parentdir = fnamemodify(dir, ':h')
      let spec = fzf#wrap(fzf#vim#with_preview({'options': ['--expect', 'ctrl-j', '--bind=ctrl-k:down,;:up'] }))

      " hack to retain original sink used by fzf#vim#files
      let origspec = copy(spec)

      unlet spec.sinklist
      unlet spec['sink*']
      function spec.sinklist(lines) closure
        if len(a:lines) < 2
          return
        endif
        if a:lines[0] == 'ctrl-j'
          call TFile(parentdir)
        else
          call origspec.sinklist(a:lines)
        end
      endfunction
      call fzf#vim#files(dir, spec)
    endfunction

    command! -nargs=* TFile call TFile(<q-args>)

