"NerdTree shortcuts
    nnoremap <M-O>5R :NERDTreeToggle<CR>

let mapleader="\<SPACE>"

"swapping hjkl to jklç
    noremap j h
    noremap k j
    noremap ç k
    nmap <C-ç> <C-b>| "<C-ç> is recognized as ; for some weird reason, so i used it as a work around vim's C-'non ansi keys' limitation
    vmap <C-ç> <C-b>
    nmap <C-k> <C-f>
    vmap <C-k> <C-f>


"changing windows
    nnoremap <leader>w <C-w>
    nnoremap <leader>wj <C-w>h
    nnoremap <leader>wç <C-w>k
    nnoremap <leader>wk <C-w>j
    nnoremap <C-w>k <C-w>j
    nnoremap <C-w>ç <C-w>k
    nnoremap <C-w>j <C-w>h

"Ctags
    nmap <leader>w[ :vsp <CR>:ta <C-R><C-w><CR>| "open a ctag reference in a vertical split

" swapping b and default shortcuts
    nnoremap b q
    vnoremap b q
    nnoremap q b
    vnoremap q b

" delete without yanking
    nnoremap x "_x
    vnoremap x "_x

" paste without yanking
    vnoremap p "_dP

"vim is weird and the name of some keys are just weird. C-K in
"insert mode > key combination give you the right name
"Shortcuts:
    nnoremap <silent> <C-s> :w!<CR>
    vnoremap <silent> <C-s> :w!<CR>
    inoremap <silent> <C-s> <C-c>:w!<CR>
    nnoremap <silent> <C-z> :undo<CR>
    vnoremap <silent> <C-z> <C-c>:undo<CR>
    inoremap <silent> <C-z> <C-c>:undo<CR>
"select word and do some action
    nnoremap <leader>v viw
    nnoremap <leader>y yiw
    nnoremap <leader>c ciw
"searce and replace the cursor's word.
    "c_C-R (C-r in command mode) copy something from the register and
    "C-A get the word under the cursos (as if you would use viw)
    nnoremap <leader>s :s/<C-R><C-W>//g<left><left>
    nnoremap <leader>f :%s/<C-R><C-W>//g<left><left>
"go to current return type spot in current function
    nmap <silent> <leader>rr [[f)a: 
"Remove search highlight
    nnoremap <silent><ESC> :nohls<CR>
"Move lines around the code
    nnoremap <silent> <M-ç> :m -2<CR>==| "Vim can't recognize <S-ç> but it can recognize Ç so i leave it here as a workaround
    nnoremap <silent> <M-k> :m +1<CR>==
    vnoremap <silent> <M-ç> :m '<-2<CR>gv=gv
    vnoremap <silent> <M-k> :m '>+1<CR>gv=gv
"Tab for indentation
    nnoremap <silent> <tab> >>
    vnoremap <silent> <tab> >gv
    nnoremap <silent> <s-tab> <<
    vnoremap <silent> <s-tab> <gv
"Horizontal scroll
    nnoremap <C-l> zL
    nnoremap <C-j> zH
"buffer shortcuts
    nnoremap <silent> <leader>j :bp<CR>
    nnoremap <silent> <leader>l :bn<CR>
    nnoremap <silent> <leader>u :Bdelete<CR>
    nnoremap <F3> :TFile<CR>| "TFile is a modified version of :Files so i can cd .. inside the window
    nnoremap <F12> :CocCommand<CR>
"this is C-F1. vim is weird and the name of some keys are just weird. C-V in
"insert mode > key combination give you the right name
    nnoremap <leader><F1> :NERDTreeToggle<CR>

"auto end with ;
    inoremap <M-;> <C-c>A;
    nnoremap <M-;> A;<C-c>

"PHP-Refactoting-toolbox shortcuts
    nnoremap <Leader>rlv :call PhpRenameLocalVariable()<CR>
    nnoremap <Leader>rcv :call PhpRenameClassVariable()<CR>
    nnoremap <Leader>rm :call PhpRenameMethod()<CR>
    nnoremap <Leader>reu :call PhpExtractUse()<CR>
    vnoremap <Leader>rec :call PhpExtractConst()<CR>
    nnoremap <Leader>rep :call PhpExtractClassProperty()<CR>
    vnoremap <Leader>rem :call PhpExtractMethod()<CR>
    nnoremap <Leader>rnp :call PhpCreateProperty()<CR>
    nnoremap <Leader>rdu :call PhpDetectUnusedUseStatements()<CR>
    vnoremap <Leader>== :call PhpAlignAssigns()<CR>
    nnoremap <Leader>rgs :call PhpCreateSettersAndGetters()<CR>
    nnoremap <Leader>rog :call PhpCreateGetters()<CR>
    nnoremap <Leader>rda :call PhpDocAll()<CR>
