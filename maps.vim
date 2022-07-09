"NerdTree shortcuts
    nnoremap <M-O>5R :NERDTreeToggle<CR>

let mapleader="\<SPACE>"

"swapping hjkl to jklç
    noremap j h
    noremap k j
    noremap ç k
    nmap ; <C-b>| "<C-ç> is recognized as ; for some weird reason, so i used it as a work around vim's C-'non ansi keys' limitation
    vmap ; <C-b>
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
    vnoremap p "0p

"vim is weird and the name of some keys are just weird. C-K in
"insert mode > key combination give you the right name
"Shortcuts:
    nnoremap <silent> <C-s> :w!<CR>
    vnoremap <silent> <C-s> :w!<CR>
    inoremap <silent> <C-s> <Esc>:w!<CR>
    vnoremap <silent> <C-c> "+y<CR>
    nnoremap <silent> <C-z> :undo<CR>
    vnoremap <silent> <C-z> :undo<CR>
    inoremap <silent> <C-z> <Esc>:undo<CR>
"select word and do some action
    nnoremap <leader>v viw
    nnoremap <leader>y yiw
    nnoremap <leader>d diw
"searce and replace the cursor's word.
    "c_C-R (C-r in command mode) copy something from the register and
    "C-A get the word under the cursos (as if you would use viw)
    nnoremap <leader>s :s/<C-R><C-W>//g<left><left>
    nnoremap <leader>f :%s/<C-R><C-W>//g<left><left>
"go to current return type spot in current function
    nmap <unique> <silent> <leader>rr [[f)a: 
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
    nnoremap <C-l> z5l
    nnoremap <C-j> z5h
"buffer shortcuts
    nnoremap <silent> <leader>j :bp<CR>
    nnoremap <silent> <leader>l :bn<CR>
    nnoremap <silent> <leader>u :bd<CR>
    nnoremap <F3> :TFile<CR>| "TFile is a modified version of :Files so i can cd .. inside the window
    nnoremap <F12> :CocCommand<CR>
"this is C-F1. vim is weird and the name of some keys are just weird. C-V in
"insert mode > key combination give you the right name
    nnoremap <leader><F1> :NERDTreeToggle<CR>

"PHP-Refactoting-toolbox shortcuts
    nnoremap <unique> <Leader>rlv :call PhpRenameLocalVariable()<CR>
    nnoremap <unique> <Leader>rcv :call PhpRenameClassVariable()<CR>
    nnoremap <unique> <Leader>rm :call PhpRenameMethod()<CR>
    nnoremap <unique> <Leader>eu :call PhpExtractUse()<CR>
    vnoremap <unique> <Leader>ec :call PhpExtractConst()<CR>
    nnoremap <unique> <Leader>ep :call PhpExtractClassProperty()<CR>
    vnoremap <unique> <Leader>em :call PhpExtractMethod()<CR>
    nnoremap <unique> <Leader>np :call PhpCreateProperty()<CR>
    nnoremap <unique> <Leader>du :call PhpDetectUnusedUseStatements()<CR>
    vnoremap <unique> <Leader>== :call PhpAlignAssigns()<CR>
    nnoremap <unique> <Leader>gs :call PhpCreateSettersAndGetters()<CR>
    nnoremap <unique> <Leader>cog :call PhpCreateGetters()<CR>
    nnoremap <unique> <Leader>da :call PhpDocAll()<CR>
