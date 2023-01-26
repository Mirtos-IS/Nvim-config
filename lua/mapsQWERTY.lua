vim.g.mapleader = ' '

vim.cmd( 'set langmap=jh,kj,çk,h`')

vim.keymap.set('n', '<leader><leader>s', ':so %<CR>', {})
vim.keymap.set('n', '<leader><leader>a', ':so $MYVIMRC<CR>', {})
-- place this in one of your configuration file(s)
vim.keymap.set('n', '`', '<cmd>HopWord<CR>', {silent = true}) --` is h, don't ask lol

vim.keymap.set({'n', 'v'}, '<C-ç>', '<C-b>', {remap = true})
vim.keymap.set({'n', 'v'}, '<C-k>', '<C-f>', {remap = true})

--isrt layout
function IsrtLayoutKeymaps()
  require('mapsISRT')
end

vim.keymap.set('n', '<leader><leader>i', ':lua IsrtLayoutKeymaps()<CR>', {})

--changing windows
vim.keymap.set('n', '<leader>w', '<C-w>', {})

--Ctags
vim.keymap.set('', '<leader>w[',':vs<CR>:ta <C-R><C-w><CR>', {})

--lsp
vim.keymap.set('n', '<leader>g', vim.lsp.buf.definition, {silent=true})

--swapping b and q bc b to go back a word is cringe
vim.keymap.set({'n', 'v'}, 'b', 'q', {})
vim.keymap.set({'n', 'v'}, 'q', 'b', {})

--deleting without yank
vim.keymap.set({'n', 'v'}, 'x', '"_x', {})

--paste without yank
vim.keymap.set('v', 'p', '"_dp', {})

--copy to clipboard
vim.keymap.set({'n', 'v'}, '<leader>y', '"+y',{})

--general shortcuts - <C-K> to get the true input
vim.keymap.set({'n', 'v'}, '<C-s>', '<cmd>w!<CR>', {silent = true})
vim.keymap.set('i', '<C-s>', '<ESC><cmd>w!<CR>', {silent = true})
vim.keymap.set('n', '<C-z>', '<cmd>undo<CR>', {silent = true})
vim.keymap.set({'i', 'v'}, '<C-z>', '<ESC><cmd>undo<CR>', {silent = true})

--search and replace word under cursor
vim.keymap.set('n', '<leader>s', ':s/<C-R><C-W>//g<left><left>', {})
vim.keymap.set('n', '<leader>f', ':%s/<C-R><C-W>//g<left><left>', {})

--go to curent return type in php
vim.keymap.set('n', '<leader>rr', '[[f)a: ', {remap = true})

--remove search highlight
vim.keymap.set('n', '<ESC>', '<cmd>nohls<CR>', {})

--move lines around the code
vim.keymap.set('n', '<M-ç>', '<cmd>m -2<CR>==', {})
vim.keymap.set('n', '<M-j>', '<cmd>m +1<CR>==', {})
vim.keymap.set('v', '<M-ç>', "<cmd>m '<-2<CR>gv=gv", {})
vim.keymap.set('v', '<M-j>', "<cmd>m '>+1<CR>gv=gv", {})

--tab for indentention
vim.keymap.set('n', '<tab>', '>>', {})
vim.keymap.set('v', '<tab>', '>gv', {})
vim.keymap.set('n', '<s-tab>', '<<', {})
vim.keymap.set('v', '<s-tab>', '<gv', {})

--horizontal scroll
vim.keymap.set('n', '<C-l>', 'zL', {})
vim.keymap.set('n', '<C-j>', 'zH', {})

--buffer shortcuts
vim.keymap.set('n', '<leader>h', '<cmd>bp<CR>', {})
vim.keymap.set('n', '<leader>l', '<cmd>bn<CR>', {})
vim.keymap.set('n', '<leader>u', '<cmd>Bdelete<CR>', {})
vim.keymap.set('n', '<F3>', '<cmd>TFile<CR>', {})
vim.keymap.set('n', '<leader>g', '<cmd>Rg<CR>', {})

--window shortcuts
vim.keymap.set('n', '<leader>q', '<cmd>q<CR>', {})

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
vim.keymap.set('n', '<leader>1', '<cmd>set foldenable<CR>', {silent=true})
vim.keymap.set('n', '<leader>2', '<cmd>set nofoldenable<CR>', {silent=true})

--gitblame plugin
vim.keymap.set('n', '<leader>`', ':GitBlameToggle<CR>', {silent=true})

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
