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

"Built in
        set showcmd
        set number
        set relativenumber
        set ruler
        set nohlsearch
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

"Global Colors

    set termguicolors
    colorscheme codedark
    hi Normal guibg=none 
    hi LineNr guibg=none
    hi EndOfBuffer guibg=none
    hi Directory guibg=none
    hi NonText guibg=none
    hi FoldColumn guibg=none
    hi folded gui=none guifg=#FCFCFC guibg=none

" Configurações do CoC.nvim

    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" : 
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    inoremap <silent><expr>  pumvisible() ? coc#_select_confirm()
                                  \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
    " nmap <silent> gd <Plug>(coc-definition)
    " nmap <silent> gy <Plug>(coc-type-definition)
    " nmap <silent> gr <Plug>(coc-references)
    " nmap <silent> gi <Plug>(coc-implementation)

"Airline setup

    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#show_buffers = 1
    let g:airline#extensions#tabline#switch_buffers_and_tabs = 1
    let g:airline#extensions#tabline#tab_nr_type = 2
    let g:airline#extensions#tabline#fnamemod=':t'
    let g:airline#extensions#whitespace#enabled = 0
    let g:airline_section_c='%t'
    let g:airline_powerline_fonts=1
    let g:airline_theme='codedark'

" Semshi

    let g:semshi#error_sign_delay=2
    let g:semshi#excluded_hl_groups=['local', 'attribute'] 
    let g:semshi#simplify_markup=v:false
    "Semshi colorscheme
    function MyCustomHighlights()
        hi semshiGlobal             ctermfg=153 guifg=#9CDCFE
        hi semshiImported           ctermfg=86 guifg=#4EC9B0
        hi semshiParameterUnused    cterm=none gui=none
        hi semshiUnresolved         ctermfg=255 cterm=none guifg=#FFFFFF gui=none
        hi semshiBuiltin            ctermfg=214 guifg=#DCDCAA
        hi semshiSelf               ctermfg=199 guifg=#9CDCFE
        hi semshiParameter          ctermfg=153 guifg=#9CDCFE
    endfunction
    autocmd FileType python call MyCustomHighlights()
     autocmd ColorScheme * call MyCustomHighlights()

"Emmet only for html and css files

    let g:user_emmet_install_global = 0
    autocmd FileType html,css,php,blade,blade.php EmmetInstall
    "Let leader key being something more easy to use
    let g:user_emmet_leader_key='<C-SPACE>'

"PHPfold
    let g:DisableAutoPHPFolding=1
    map <F1> <Esc>:EnableFastPHPFolds<CR>
    map <F2> <Esc>:DisablePHPFolds<CR>

    " Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocAction('format')

"PHP-Refactoting-toolbox
    let g:vim_php_refactoring_auto_validate_sg = 1
    let g:vim_php_refactoring_use_default_mapping = 0
    let g:vim_php_refactoring_auto_validate_g = 1
    "PHP-Refactoting-toolbox shortcuts
    nnoremap <unique> <Leader>rlv :call PhpRenameLocalVariable()<CR>
    nnoremap <unique> <Leader>rcv :call PhpRenameClassVariable()<CR>
    nnoremap <unique> <Leader>rm :call PhpRenameMethod()<CR>
    nnoremap <unique> <Leader>eu :call PhpExtractUse()<CR>
    vnoremap <unique> <Leader>ec :call PhpExtractConst()<CR>
    nnoremap <unique> <Leader>ep :call PhpExtractClassProperty()<CR>
    vnoremap <unique> <Leader>em :call PhpExtractMethod()<CR>
    nnoremap <unique> <Leader>np :call PhpCreateProperty()<CR>
    nnoremap <unique> <Leader>du :call PhpDetectUnusedUseStatements()<CR>
    vnoremap <unique> <Leader>== :call PhpAlignAssigns()<CR>
    nnoremap <unique> <Leader>gs :call PhpCreateSettersAndGetters()<CR>
    nnoremap <unique> <Leader>cog :call PhpCreateGetters()<CR>
    nnoremap <unique> <Leader>da :call PhpDocAll()<CR>



 " changing location of phpunit files
     let g:phpunit_testroot = '~/Downloads/phpunit/tests'
     let g:phpunit_srcroot = '~/Downloads/phpunit/src'
     let g:phpunit_bin = '~/Downloads/phpunit/vendor/bin/phpunit'
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

"FZF_action remapping
    let g:fzf_action = {
        \ 'ctrl-s': 'split',
        \ 'ctrl-v': 'vsplit'}

"NerdTree shortcuts
    nnoremap <M-O>5R :NERDTreeToggle<CR>

let mapleader="\<SPACE>"

"swapping hjkl to jklç 
    noremap j h
    noremap k j
    noremap ç k
    nmap ; <C-b>| "<C-ç> is recognized as ; for some weird reason, so i used it as a work around vim's C-'non ansi keys' limitation
    vmap ; <C-b>
    nmap <C-k> <C-f>
    vmap <C-k> <C-f>


"changing windows
    nnoremap <leader>w <C-w>
    nnoremap <leader>wj <C-w>h
    nnoremap <leader>wç <C-w>k
    nnoremap <leader>wk <C-w>j
    nnoremap <C-w>k <C-w>j
    nnoremap <C-w>ç <C-w>k
    nnoremap <C-w>j <C-w>h

"Ctags
    nmap <leader>w[ :vsp <CR>:ta <C-R><C-w><CR>| "open a ctag reference in a vertical split

" swapping b and default shortcuts
    nnoremap b q
    vnoremap b q
    nnoremap q b
    vnoremap q b

" delete without yanking
    nnoremap x "_x
    vnoremap x "_x

" paste without yanking
    vnoremap p "0p

"vim is weird and the name of some keys are just weird. C-K in
"insert mode > key combination give you the right name
"Shortcuts:
    nnoremap <silent> <C-s> :w!<CR>
    vnoremap <silent> <C-s> :w!<CR>
    inoremap <silent> <C-s> <Esc>:w!<CR>
    vnoremap <silent> <C-c> "+y<CR>
    nnoremap <silent> <C-z> :undo<CR>
    vnoremap <silent> <C-z> :undo<CR>
    inoremap <silent> <C-z> <Esc>:undo<CR>
"select word and do some action
    nnoremap <leader>v viw
    nnoremap <leader>y yiw
    nnoremap <leader>d diw
"search and replace the cursor's word.
    "c_C-R (C-r in command mode) copy something from the register and 
    "C-A get the word under the cursos (as if you would use viw)
    nnoremap <leader>s :s/<C-R><C-W>//g<left><left>
    nnoremap <leader>f :%s/<C-R><C-W>//g<left><left>
"go to current return type spot in current function
    nmap <unique> <silent> <leader>rr [[f)a: 
"Remove search highlight
    nnoremap <silent><ESC> :nohls<CR>
"Move lines around the code
    nnoremap <silent> <M-ç> :m -2<CR>==| "Vim can't recognize <S-ç> but it can recognize Ç so i leave it here as a workaround
    nnoremap <silent> <M-k> :m +1<CR>==
    vnoremap <silent> <M-ç> :m '<-2<CR>gv=gv
    vnoremap <silent> <M-k> :m '>+1<CR>gv=gv
"Tab for indentation
    nnoremap <silent> <tab> >>
    vnoremap <silent> <tab> >gv
    nnoremap <silent> <s-tab> <<
    vnoremap <silent> <s-tab> <gv
"Horizontal scroll
    nnoremap <C-l> z5l
    nnoremap <C-j> z5h
"buffer shortcuts
    nnoremap <silent> <leader>j :bp<CR>
    nnoremap <silent> <leader>l :bn<CR>
    nnoremap <silent> <leader>u :bd<CR>
    nnoremap <F3> :TFile<CR>| "TFile is a modified version of :Files so i can cd .. inside the window
    nnoremap <F12> :CocCommand<CR>
"this is C-F1. vim is weird and the name of some keys are just weird. C-K in
"insert mode > key combination give you the right name
    nnoremap <leader><F1> :NERDTreeToggle<CR>
