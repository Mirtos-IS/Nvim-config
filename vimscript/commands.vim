"Trim whispace
    command! -nargs=0 Trim call Trim()
" "Go to my init.vim
"     command! -nargs=? MyConfig call MyConfig(<q-args>)

au InsertEnter * call clearmatches()
au InsertLeave * match ExtraWhiteSpace /\s\+$/
