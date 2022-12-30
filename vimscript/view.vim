"Global Colors

    set termguicolors
    colorscheme codedark
    set laststatus=3
    hi Normal guibg=#000000
    hi LineNr guibg=none
    hi EndOfBuffer guibg=none
    hi Directory guibg=none
    hi NonText guibg=none
    hi FoldColumn guibg=none
    hi SignColumn guibg=none guifg=none
    hi folded guifg=#ba8d1a guibg=none gui=none
    hi WinSeparator guibg=none guifg=#272727
    hi FloatBorder guifg=#1d99f3
    " autocompletion menu
    set pumblend=30
    set pumheight=15
    hi PmenuSel blend=0
    "set of highlights for treesitter
    "general
    hi @keyword guifg=#ce86c0
    hi @keyword.function guifg=#ce86c0
    hi @include guifg=#5696c6
    hi @type.qualifier guifg=#5696c6
    hi @function.call guifg=#4ec9b0
    hi @constructor guifg=#dcdcaa

    "lua
    hi @function.call.lua guifg=#dcdcaa

"Whitespace highlight
    hi ExtraWhiteSpace guibg=darkred
    hi YankHighlight guibg=#267683
    au InsertEnter * call clearmatches()
    au InsertLeave * match ExtraWhiteSpace /\s\+$/

    let g:airline#extensions#tabline#enabled = 0
    let g:airline#extensions#tabline#switch_buffers_and_tabs = 1
    let g:airline#extensions#tabline#tab_nr_type = 2
    let g:airline#extensions#tabline#fnamemod=':t'
    let g:airline#extensions#whitespace#enabled = 0
    " let g:airline_section_c = airline#section#create(["%{nvim_treesitter#statusline(60)}"])
    let g:airline_powerline_fonts=1
    let g:airline_theme='deus'

" Semshi

    let g:semshi#error_sign_delay=2
    let g:semshi#excluded_hl_groups=['local', 'attribute']
    let g:semshi#simplify_markup=v:false
" Yank Highlight
    highlight HighlightedyankRegion guibg=white
