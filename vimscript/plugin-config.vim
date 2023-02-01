"Emmet only for html and css files

let g:user_emmet_install_global = 0
autocmd FileType html,css,php,blade,blade.php EmmetInstall
"Let leader key being something more easy to use
let g:user_emmet_leader_key='<C-,>'

"PHP-Refactoting-toolbox
" let g:vim_php_refactoring_auto_validate_sg = 1
" let g:vim_php_refactoring_use_default_mapping = 0
" let g:vim_php_refactoring_auto_validate_g = 1

" " changing location of phpunit files
" let g:phpunit_test_root = 'tests/Unit'
" let g:phpunit_src_root = 'turnouverbnb-web'
" let g:phpunit_bin = 'vendor/bin/phpunit'
" let g:phpunit_options = []

" GitBlame plugin
let g:gitblame_enabled = 0

au TextYankPost * silent! lua vim.highlight.on_yank {higroup="YankHighlight", timeout=70}
