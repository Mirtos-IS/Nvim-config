"Functions
 " Configurações do CoC.nvim
    " inoremap <silent><expr> <TAB>
    "       \ pumvisible() ? "\<C-n>" :
    "       \ <SID>check_back_space() ? "\<TAB>" :
    "       \ coc#refresh()
    " inoremap <expr><M-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    " function! s:check_back_space() abort
    "   let col = col('.') - 1
    "   return !col || getline('.')[col - 1]  =~# '\s'
    " endfunction

    " inoremap <silent> <expr> <S-CR> pumvisible() ? coc#_select_confirm()
    "                             \ : "\<C-g>u\<C-R>\<c-r>=coc#on_enter()\<C-R>"


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

"auto ; at the end if <M-o> in insert mode
" let g:ok_chars = "([{,;"
    "function AutoEndLinePHP()
    "    let current_line = getline('.')
    "    let lastchar = matchstr(current_line, '[^/]$')
    "    if !empty(matchstr(g:ok_chars, lastchar))
    "        return
    "    endif
    "    "while 1
    "    "    let next_char = getcharstr()
    "    "    "tab = 9, space_bar = 32, backspace = <80>kb
    "    "    if next_char != '	' || next_char != ' ' || next_char != '\<BS>'
    "    "        break
    "    "    endif
    "    "endwhile
    "    ""- = 95, checking for -> method chaining
    "    "if next_char == '-'
    "    "    return
    "    "endif
    "    ""If ; need to be set
    "    "normal! <up>g_a;<down>g_a
    "    "echo current_line
    "    "echo lastchar
    "    "" let a = getchar()
    "    "" echo a
    "endfunction
" if !exists(g:project_dir)
"     let g:project_dir = 'src'
" endif

"     function CtagsAsync(timer_id)
"         let l:callbacks = {
"                 \ 'on_stdout': function('OnEvent'),
"               \ }
"         call jobstart(g:CtagsCmd(), l:callbacks)
"     endfunction


"     function OnEvent(job_id, data, event)
"         if a:event == 'stdout'
"             echo "Tags file saved on " . g:tags_dir
"         endif
"     endfunction

"     function g:CtagsCmd()
"         let current_dir = expand('%:p:h')
"         let g:tags_dir = substitute(current_dir, g:project_dir . '\zs.*$', '' , '' )
"         let cmd = 'ctags -R ' . g:tags_dir
"         return cmd
"     endfunction

"     function Ctags(project_dir = '')
"         if exists(a:project_dir)
"             let g:project_dir = a:project_dir
"         endif
"         call CtagsAsync(30000)
"     endfunction
