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
    hi folded guifg=#FCFCFC guibg=none
    hi WinSeparator guibg=none guifg=#272727
    hi FloatBorder guifg=#1d99f3
    " autocompletion menu
    set pumblend=30
    set pumheight=15
    hi PmenuSel blend=0

"Whitespace highlight
    hi ExtraWhiteSpace guibg=darkred
    au InsertEnter * call clearmatches()
    au InsertLeave * match ExtraWhiteSpace /\s\+$/

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
