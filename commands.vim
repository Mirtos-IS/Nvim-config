"Trim whispace
    command! -nargs=0 Trim call Trim()
"Go to my init.vim
    command! -nargs=? MyConfig call MyConfig(<q-args>)
" Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocAction('format')
" Tfile is a modified fzf :Files function to allow going up dir
    command! -nargs=* TFile call TFile(<q-args>)
