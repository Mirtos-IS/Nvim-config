
"Trim whispace
    command! -nargs=0 Trim call Trim()
"Go to my init.vim
    command! -nargs=? MyConfig call MyConfig(<q-args>)
" Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocAction('format')
