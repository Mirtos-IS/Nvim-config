call plug#begin()

Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'mattn/emmet-vim'
Plug 'tomasiser/vim-code-dark'
Plug 'sheerun/vim-polyglot'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'StanAngeloff/php.vim'
Plug 'rayburgemeestre/phpfolding.vim'
Plug '2072/PHP-Indenting-for-VIm'
Plug 'jez/vim-better-sml'
Plug 'tpope/vim-commentary'

call plug#end()

lua require('nvim-autopairs').setup{}

"Built in
set number
set ruler
set mouse=a
set nowrap
set autochdir
set tabstop=4
set shiftwidth=4
set fillchars=fold:\ 

"Indent 
set autoindent
set smartindent

"Global Colors

set termguicolors
colorscheme codedark
hi Normal guibg=black ctermbg=black
hi LineNr guibg=#0A0A0A
hi EndOfBuffer guibg=black
hi Directory guibg=black
hi NonText guibg=black
hi FoldColumn guibg=black
hi folded gui=None guifg=#FCFCFC guibg=black

" Configurações do CoC.nvim

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><CS-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <C-space> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


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
autocmd FileType html,css,php EmmetInstall
"Let leader key being something more easy to use
let g:user_emmet_leader_key='<C-SPACE>'

"PHPfold
let g:DisableAutoPHPFolding=1
map <F1> <Esc>:EnableFastPHPFolds<CR>
map <F2> <Esc>:DisablePHPFolds<CR>

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

"NerdTree shortcurs
nnoremap <M-O>5R :NERDTreeToggle<CR>

let mapleader="\<SPACE>"

"swapping hjkl to jklç 
noremap j h
noremap k j
noremap ç k
nnoremap <leader>k <C-f>
nnoremap <leader>ç <C-b>
"vim is weird and the name of some keys are just weird. C-K in
"insert mode > key combination give you the right name
"Shortcuts:
nnoremap <BS> X
nnoremap <silent> <C-s> :w!<CR>
inoremap <silent> <C-s> <Esc>:w!<CR>
vnoremap <silent> <C-c> "+y<CR>
nnoremap <silent> <C-z> :undo<CR>
inoremap <silent> <C-z> <Esc>:undo<CR>
nnoremap <C-n> :!touch 
"Move lines around the code
nnoremap <silent> <M-ç> :m -2<CR>==
nnoremap <silent> <M-k> :m +1<CR>==
vnoremap <silent> <M-ç> :m '<-2<CR>gv=gv
vnoremap <silent> <M-k> :m '>+1<CR>gv=gv
"Horizontal scroll
nnoremap <C-l> z3l
nnoremap <C-j> z3h
"buffer shortcuts
nnoremap <silent> <leader>j :bp<CR>
nnoremap <silent> <leader>l :bn<CR>
nnoremap <silent> <leader>d :bd<CR>
nnoremap <F3> :Files<CR>
nnoremap <F12> :CocCommand<CR>
"this is C-F1. vim is weird and the name of some keys are just weird. C-K in
"insert mode > key combination give you the right name
nnoremap <M-O>5P :tabnew<CR>

