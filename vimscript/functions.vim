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

    function IsModified()
      return getbufinfo('%')[0].changed > 0
    endfunction
