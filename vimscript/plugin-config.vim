"Emmet only for html and css files

    let g:user_emmet_install_global = 0
    autocmd FileType html,css,php,blade,blade.php EmmetInstall
    "Let leader key being something more easy to use
    let g:user_emmet_leader_key='<C-SPACE>'

"PHPfold
    let g:DisableAutoPHPFolding=1
    map <silent> <M-O>5P <Esc>:EnablePHPFolds<CR>
    map <silent> <M-O>5Q <Esc>:DisablePHPFolds<CR>


"PHP-Refactoting-toolbox
    let g:vim_php_refactoring_auto_validate_sg = 1
    let g:vim_php_refactoring_use_default_mapping = 0
    let g:vim_php_refactoring_auto_validate_g = 1


" changing location of phpunit files
    let g:phpunit_test_root = 'tests/Unit'
    let g:phpunit_src_root = 'app'
    let g:phpunit_bin = 'vendor/bin/phpunit'
    let g:phpunit_options = []

" ctags plugin
    let g:project_dir = 'api'

    autocmd FileType lua,vim set et tabstop=2 softtabstop=2 shiftwidth=2
