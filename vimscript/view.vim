"Global Colors
    " autocompletion menu
    set pumblend=30
    set pumheight=15

"Whitespace highlight
    au InsertEnter * call clearmatches()
    au InsertLeave * match ExtraWhiteSpace /\s\+$/
