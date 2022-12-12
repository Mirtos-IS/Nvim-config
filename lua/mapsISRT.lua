vim.g.mapleader = ' '

vim.keymap.set('n', '<leader><leader>s', ':so %<CR>', {})
vim.keymap.set('n', '<leader><leader>a', ':so $MYVIMRC<CR>', {})
-- place this in one of your configuration file(s)
vim.keymap.set('n', '<leader>n', '<cmd>HopWord<CR>', {silent = true})

--swapping movemente keys to jklç
vim.cmd( 'set langmap=nh,ej,ok,al,hn,je,ka,lo')
vim.cmd( 'set langmap+=NH,EJ,OK,AL,HN,JE,KA,LO')

vim.keymap.set({'n', 'v'}, '<C-o>', '<C-b>', {remap = true})
vim.keymap.set({'n', 'v'}, '<C-e>', '<C-f>', {remap = true})

--Ctags
vim.keymap.set('', '<leader>w[',':vs<CR>:ta <C-R><C-w><CR>', {})

--lsp
vim.keymap.set('n', '<leader>g', vim.lsp.buf.definition, {silent=true})

--deleting without yank
vim.keymap.set({'n', 'v'}, 'x', '"_x', {})

--paste without yank
vim.keymap.set('v', 'p', '"_dp', {})

--copy to clipboard
vim.keymap.set({'n', 'v'}, '<leader>y', '"+y',{})

--copy to clipboard
vim.keymap.set({'n', 'v'}, '<leader>p', '"+p',{})

--general shortcuts - <C-K> to get the true input
vim.keymap.set({'n', 'v'}, '<C-s>', '<cmd>w!<CR>', {silent = true})
vim.keymap.set('i', '<C-s>', '<ESC><cmd>w!<CR>', {silent = true})
vim.keymap.set('n', '<C-z>', '<cmd>undo<CR>', {silent = true})
vim.keymap.set('n', '<S-u>', '<cmd>redo<CR>', {silent = true})
vim.keymap.set({'i', 'v'}, '<C-z>', '<ESC><cmd>undo<CR>', {silent = true})

--search and replace word under cursor
vim.keymap.set('n', '<leader>s', ':s/<C-R><C-W>//g<left><left>', {})
vim.keymap.set('n', '<leader>f', ':%s/<C-R><C-W>//g<left><left>', {})

--go to curent return type in php
vim.keymap.set('n', '<leader>rr', '[[f)a: ', {remap = true})

--remove search highlight
vim.keymap.set('n', '<ESC>', '<cmd>nohls<CR>', {})

--move lines around the code
vim.keymap.set('n', '<M-j>', '<cmd>m +1<CR>==', {})
vim.keymap.set('n', '<M-k>', '<cmd>m -2<CR>==', {})
vim.keymap.set('v', '<M-k>', "<cmd>m '<-2<CR>gv=gv", {})
vim.keymap.set('v', '<M-j>', "<cmd>m '>+1<CR>gv=gv", {})

--tab for indentention
vim.keymap.set('n', '<tab>', '>>', {})
vim.keymap.set('v', '<tab>', '>gv', {})
vim.keymap.set('n', '<s-tab>', '<<', {})
vim.keymap.set('v', '<s-tab>', '<gv', {})

--horizontal scroll
vim.keymap.set('n', '<C-a>', 'zL', {})
vim.keymap.set('n', '<C-n>', 'zH', {})

--buffer shortcuts
vim.keymap.set('n', '<M-h>', '<cmd>bp<CR>', {})
vim.keymap.set('n', '<M-l>', '<cmd>bn<CR>', {})
vim.keymap.set('n', '<leader>u', '<cmd>Bdelete<CR>', {})
vim.keymap.set('n', '<F3>', '<cmd>TFile<CR>', {})
vim.keymap.set('n', '<F6>', '<cmd>Rg<CR>', {})

--window shortcuts
vim.keymap.set('n', '<leader>q', '<cmd>q<CR>', {})

--auto put ; to the end of line
vim.keymap.set('n', '<M-;>', 'A;<ESC>')
vim.keymap.set('i', '<M-;>', '<ESC>A;')

--PHP-Refactor-toolbox shortcuts
vim.keymap.set('n', '<Leader>rav', '<cmd>call PhpRenameLocalVariable()<CR>') --<leader>rlm
vim.keymap.set('n', '<Leader>rcv', '<cmd>call PhpRenameClassVariable()<CR>')
vim.keymap.set('n', '<Leader>rm',  '<cmd>call PhpRenameMethod()<CR>')
vim.keymap.set('n', '<Leader>rju', '<cmd>call PhpExtractUse()<CR>') --<leader>rem, thanks to lang.
vim.keymap.set('v', '<Leader>rjc', '<cmd>call PhpExtractConst()<CR>')
vim.keymap.set('n', '<Leader>rjp', '<cmd>call PhpExtractClassProperty()<CR>')
vim.keymap.set('v', '<Leader>rjm', '<cmd>call PhpExtractMethod()<CR>')
vim.keymap.set('n', '<Leader>rnp', '<cmd>call PhpCreateProperty()<CR>')
vim.keymap.set('n', '<Leader>rdu', '<cmd>call PhpDetectUnusedUseStatements()<CR>')
vim.keymap.set('v', '<Leader>==',  '<cmd>call PhpAlignAssigns()<CR>')
vim.keymap.set('n', '<Leader>rgs', '<cmd>call PhpCreateSettersAndGetters()<CR>')
vim.keymap.set('n', '<Leader>rlg', '<cmd>call PhpCreateGetters()<CR>') --<leader>rog
vim.keymap.set('n', '<Leader>rdk', '<cmd>call PhpDocAll()<CR>') --<leader>rda

--PHPFolding
vim.keymap.set('n', '<leader>1', '<cmd>EnableFastPHPFolds<CR>', {silent=true})
vim.keymap.set('n', '<leader>2', '<cmd>DisablePHPFolds<CR>', {silent=true})

--gitblame plugin
vim.keymap.set('n', '<leader>b', ':GitBlameToggle<CR>', {silent=true})

--exit toggleterm with esc
function _G.set_terminal_keymaps()
    local opts = {buffer = 0}
  print('oi')
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
--currently you need langnoremap to my fzf hack to work properly
function ToggleLangnoremap()
    vim.o.langremap = false
end
function ToggleLangremap()
    vim.o.langremap = true
end
  vim.cmd('autocmd TermOpen *#FZF lua ToggleLangnoremap()')
  vim.cmd('autocmd TermClose *#FZF lua ToggleLangremap()')
