vim.g.mapleader = ' '

vim.keymap.set('n', '<leader><leader>s', ':so %<CR>', {})
vim.keymap.set('n', '<leader><leader>a', ':so $MYVIMRC<CR>', {})
-- place this in one of your configuration file(s)
vim.keymap.set('n', 'p', '<cmd>HopWord<CR>', {silent = true})

--swapping movemente keys to jklç
vim.cmd( 'set langmap=yq,cw,le,mr,kt,zy,fu,ui,\'p,ia,ss,rd,tf,gg,nh,ej,ok,al,qz,vx,wc,dv,jb,bn,hm')
vim.cmd( 'set langmap+=JQ,CW,LE,MR,KT,ZY,FU,UI,ÇP,IA,SS,RD,TF,GG,NH,EJ,OK,AL,QZ,VX,WC,DV,YB,BN,HM')
vim.cmd( 'set langmap+=\\o')

vim.keymap.set({'n', 'v'}, '<C-o>', '<C-b>', {remap = true})
vim.keymap.set({'n', 'v'}, '<C-e>', '<C-f>', {remap = true})

--changing windows
vim.keymap.set('n', '<leader>w', '<C-w>', {})

--Ctags
vim.keymap.set('', '<leader>w[',':vs<CR>:ta <C-R><C-w><CR>', {})

--lsp
vim.keymap.set('n', '<leader>g', vim.lsp.buf.definition, {silent=true})

--deleting without yank
vim.keymap.set({'n', 'v'}, 'v', '"_v', {})

--paste without yank
vim.keymap.set('v', 'ç', '"_dÇ', {})

--general shortcuts - <C-K> to get the true input
vim.keymap.set({'n', 'v'}, '<C-s>', '<cmd>w!<CR>', {silent = true})
vim.keymap.set('i', '<C-s>', '<ESC><cmd>w!<CR>', {silent = true})
vim.keymap.set('n', '<C-q>', '<cmd>undo<CR>', {silent = true})
vim.keymap.set({'i', 'v'}, '<C-q>', '<ESC><cmd>undo<CR>', {silent = true})

--select word and do something
-- vim.keymap.set('n', '<leader>v', 'viw', {})
-- vim.keymap.set('n', '<leader>y', 'yiw', {})
-- vim.keymap.set('n', '<leader>c', 'ciw', {})

--search and replace word under cursor
vim.keymap.set('n', '<leader>s', ':s/<C-R><C-W>//g<left><left>', {})
vim.keymap.set('n', '<leader>t', ':%s/<C-R><C-W>//g<left><left>', {})

--go to curent return type in php
vim.keymap.set('n', '<leader>rr', '[[f)a: ', {remap = true})

--remove search highlight
vim.keymap.set('n', '<ESC>', '<cmd>nohls<CR>', {})

--move lines around the code
vim.keymap.set('n', '<M-o>', '<cmd>m -2<CR>==', {})
vim.keymap.set('n', '<M-e>', '<cmd>m +1<CR>==', {})
vim.keymap.set('v', '<M-o>', "<cmd>m '<-2<CR>gv=gv", {})
vim.keymap.set('v', '<M-e>', "<cmd>m '>+1<CR>gv=gv", {})
--tab for indentention

vim.keymap.set('n', '<tab>', '>>', {})
vim.keymap.set('v', '<tab>', '>gv', {})
vim.keymap.set('n', '<s-tab>', '<<', {})
vim.keymap.set('v', '<s-tab>', '<gv', {})

--horizontal scroll
vim.keymap.set('n', '<C-a>', 'zL', {})
vim.keymap.set('n', '<C-n>', 'zH', {})

--buffer shortcuts
vim.keymap.set('n', '<leader>a', '<cmd>bp<CR>', {})
vim.keymap.set('n', '<leader>n', '<cmd>bn<CR>', {})
vim.keymap.set('n', '<leader>f', '<cmd>Bdelete<CR>', {})
vim.keymap.set('n', '<F3>', '<cmd>TFile<CR>', {})

--window shortcuts
vim.keymap.set('n', '<leader>y', '<cmd>q<CR>', {})

--auto put ; to the end of line
vim.keymap.set('n', '<M-;>', 'A;<ESC>')
vim.keymap.set('i', '<M-;>', '<ESC>A;')

--PHP-Refactor-toolbox shortcuts
vim.keymap.set('n', '<Leader>rlv', '<cmd>call PhpRenameLocalVariable()<CR>')
vim.keymap.set('n', '<Leader>rcv', '<cmd>call PhpRenameClassVariable()<CR>')
vim.keymap.set('n', '<Leader>rm',  '<cmd>call PhpRenameMethod()<CR>')
vim.keymap.set('n', '<Leader>reu', '<cmd>call PhpExtractUse()<CR>')
vim.keymap.set('v', '<Leader>rec', '<cmd>call PhpExtractConst()<CR>')
vim.keymap.set('n', '<Leader>rep', '<cmd>call PhpExtractClassProperty()<CR>')
vim.keymap.set('v', '<Leader>rem', '<cmd>call PhpExtractMethod()<CR>')
vim.keymap.set('n', '<Leader>rnp', '<cmd>call PhpCreateProperty()<CR>')
vim.keymap.set('n', '<Leader>rdu', '<cmd>call PhpDetectUnusedUseStatements()<CR>')
vim.keymap.set('v', '<Leader>==',  '<cmd>call PhpAlignAssigns()<CR>')
vim.keymap.set('n', '<Leader>rgs', '<cmd>call PhpCreateSettersAndGetters()<CR>')
vim.keymap.set('n', '<Leader>rog', '<cmd>call PhpCreateGetters()<CR>')
vim.keymap.set('n', '<Leader>rda', '<cmd>call PhpDocAll()<CR>')

--PHPFolding
vim.keymap.set('n', '<leader>1', '<cmd>EnableFastPHPFolds<CR>', {silent=true})
vim.keymap.set('n', '<leader>2', '<cmd>DisablePHPFolds<CR>', {silent=true})

--exit toggleterm with esc
function _G.set_terminal_keymaps()
    local opts = {buffer = 0}
    vim.keymap.set('t', '<esc>', "<cmd>ToggleTerm<CR>", opts)
end

vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')

--use my checklist plugin
require('plugin.todolist.window')
--my ckecklist specific shortcuts
vim.keymap.set('n', '<leader>c', ':lua ToggleChecklist()<CR>', {silent=true})
function Set_checklist_keymaps()
  vim.keymap.set('n', '<esc>', ':lua ToggleChecklist()<CR>', {silent=true, buffer=true})

end
vim.cmd('autocmd BufEnter *.md lua Set_checklist_keymaps()')
