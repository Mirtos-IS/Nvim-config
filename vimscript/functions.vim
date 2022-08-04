" Function to trim extra whitespace in whole file
    function Trim()
        let l:save = winsaveview()
        keeppatterns %s/\s\+$//e
        call winrestview(l:save)
    endfunction

"Open my init.vim from anywhere
    function MyConfig(split = 0)
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
        \ 'S': 'split',
        \ 'V': 'vsplit'}

"FZF function to allow FZF go up to parent dir
    function! TFile(dir)
      if empty(a:dir)
        let dir = getcwd()
      else
        let dir = a:dir
      endif
      let parentdir = fnamemodify(dir, ':h')
      let spec = fzf#wrap(fzf#vim#with_preview({'options': ['--expect', 'J', '--bind=K:down,Ç:up'] }))

      " hack to retain original sink used by fzf#vim#files
      let origspec = copy(spec)

      unlet spec.sinklist
      unlet spec['sink*']
      function spec.sinklist(lines) closure
        if len(a:lines) < 2
          return
        endif
        if a:lines[0] == 'J'
          call TFile(parentdir)
        else
          call origspec.sinklist(a:lines)
        end
      endfunction
      call fzf#vim#files(dir, spec)
    endfunction
