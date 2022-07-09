"Functions
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

" Function to trim extra whitespace in whole file
    function! Trim()
        let l:save = winsaveview()
        keeppatterns %s/\s\+$//e
        call winrestview(l:save)
    endfun

"Open my init.vim from anywhere
    function! MyConfig(split = 0)
        if !empty(a:split)
            exec ":" . a:split . " $MYVIMRC"
            return
        else
            exec ":e $MYVIMRC"
            return
        endif
    endfunction

"FZF_action remapping
    let g:fzf_action = {
        \ 'ctrl-s': 'split',
        \ 'ctrl-v': 'vsplit'}

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
