vim.g.mapleader = ' '

vim.keymap.set('n', '<leader><leader>s', ':so %<CR>', {})
vim.keymap.set('n', '<leader><leader>a', ':so $MYVIMRC<CR>', {})
-- place this in one of your configuration file(s)
vim.keymap.set('n', '<leader>n', '<cmd>HopWord<CR>', {silent = true})

--swapping movemente keys to jklç
vim.cmd( 'set langmap=nh,ej,ok,al,hn,je,ka,lo')
vim.cmd( 'set langmap+=NH,EJ,OK,AL,HN,JE,KA,LO')
vim.keymap.set('n', '<space>m', vim.diagnostic.open_float,{})

vim.keymap.set('', '<LeftMouse>', '', {})
vim.keymap.set('', '<RightMouse>', '', {})
vim.keymap.set('', '<MiddleMouse>', '', {})

--fixing some quirks with langmap
vim.keymap.set('n', '<C-l>', '<C-o>', {})
vim.keymap.set('n', '<C-i>', '<C-i>', {})
vim.keymap.set('n', '<C-k>', '<C-a>', {})

vim.keymap.set({'n', 'v'}, '<C-o>', '<C-u>', {remap = true})
vim.keymap.set({'n', 'v'}, '<C-e>', '<C-d>', {remap = true})

--<leader>w for quick win movement
vim.keymap.set('n', '<leader>w', '<C-w>', {})

--lsp
vim.keymap.set('n', '<leader>g', vim.lsp.buf.definition, {silent=true})

--deleting without yank
vim.keymap.set({'n', 'v'}, 'x', '"_x', {})

--paste without yank
vim.keymap.set('v', 'p', '"_dp', {})

--copy to clipboard
vim.keymap.set({'n', 'v'}, '<C-y>', '"+y',{})

--copy to clipboard
vim.keymap.set({'n', 'v'}, '<C-p>', '"+p',{})

--make life easier with inner motion
vim.keymap.set({'n', 'v'}, '<leader>y', 'yi',{})
vim.keymap.set({'n', 'v'}, '<leader>v', 'vi',{})
vim.keymap.set({'n', 'v'}, '<leader>c', 'ci',{})
vim.keymap.set({'n', 'v'}, '<leader>d', 'di',{})

--general shortcuts - <C-K> to get the true input
vim.keymap.set({'n', 'v'}, '<C-s>', '<cmd>w!<CR>', {silent = true})
vim.keymap.set('i', '<C-s>', '<ESC><cmd>w!<CR>', {silent = true})
vim.keymap.set('n', '<C-z>', '<cmd>undo<CR>', {silent = true})
vim.keymap.set('n', '<S-u>', '<cmd>redo<CR>', {silent = true})
vim.keymap.set({'i', 'v'}, '<C-z>', '<ESC><cmd>undo<CR>', {silent = true})

--search and replace word under cursor
vim.keymap.set('n', '<S-s>', ':s/<C-R><C-W>//g<left><left>', {})
vim.keymap.set('n', '<leader>f', ':%s/<C-R><C-W>//g<left><left>', {})

--go to curent return type in php
vim.keymap.set('n', '<leader>rr', '[[f)a: ', {remap = true})

--remove search highlight
vim.keymap.set('n', '<ESC>', '<cmd>nohls<CR>', {})

--move lines around the code
vim.keymap.set('n', '<M-j>', '<cmd>m +1<CR>==', {})
vim.keymap.set('n', '<M-k>', '<cmd>m -2<CR>==', {})
vim.keymap.set('v', '<M-k>', ":m '<-2<CR>gv=gv", {})
vim.keymap.set('v', '<M-j>', ":m '>+1<CR>gv=gv", {})

--tab for indentention
vim.keymap.set('n', '<tab>', '>>', {})
vim.keymap.set('v', '<tab>', '>gv', {})
vim.keymap.set('n', '<s-tab>', '<<', {})
vim.keymap.set('v', '<s-tab>', '<gv', {})

--horizontal scroll
vim.keymap.set('n', '<C-a>', 'zL', {})
vim.keymap.set('n', '<C-n>', 'zH', {})

--tab shortcuts
vim.keymap.set('n', '<leader>th', '<cmd>tabnew<CR>', {silent=true})
vim.keymap.set('n', '<leader>tu', '<cmd>tabc<CR>', {silent=true})
vim.keymap.set('n', '<leader>h', '<cmd>keepjumps tabp<CR>', {silent=true})
vim.keymap.set('n', '<leader>l', '<cmd>keepjumps tabn<CR>', {silent=true})

--buffer shortcuts
vim.keymap.set('n', '<M-h>', '<cmd>keepjumps bp<CR>', {})
vim.keymap.set('n', '<M-l>', '<cmd>keepjumps bn<CR>', {})
vim.keymap.set('n', '<leader>u', '<cmd>Bdelete<CR>', {})

--fuzzy finder
vim.keymap.set('n', '<F3>', '<cmd>lua require("telescope.builtin").find_files()<CR>', {})
vim.keymap.set('n', '<F6>', '<cmd>lua require("telescope.builtin").live_grep()<CR>', {})

--window shortcuts
vim.keymap.set('n', '<leader>q', '<cmd>q!<CR>', {})

--auto add ; to the end of line
vim.keymap.set('n', '<M-;>', 'A;<ESC>', {})
vim.keymap.set('i', '<M-;>', '<ESC>A;<ESC>', {})

--call cmp select in current word
vim.keymap.set('n', '<C-SPACE>', 'wi<C-SPACE>', {remap = true})

--PHP-Refactor-toolbox shortcuts
-- vim.keymap.set('n', '<Leader>rav', '<cmd>call PhpRenameLocalVariable()<CR>') --<leader>rlm
-- vim.keymap.set('n', '<Leader>rcv', '<cmd>call PhpRenameClassVariable()<CR>')
-- vim.keymap.set('n', '<Leader>rm',  '<cmd>call PhpRenameMethod()<CR>')
-- vim.keymap.set('n', '<Leader>rju', '<cmd>call PhpExtractUse()<CR>') --<leader>rem, thanks to lang.
-- vim.keymap.set('v', '<Leader>rjc', '<cmd>call PhpExtractConst()<CR>')
-- vim.keymap.set('n', '<Leader>rjp', '<cmd>call PhpExtractClassProperty()<CR>')
-- vim.keymap.set('v', '<Leader>rjm', '<cmd>call PhpExtractMethod()<CR>')
-- vim.keymap.set('n', '<Leader>rnp', '<cmd>call PhpCreateProperty()<CR>')
-- vim.keymap.set('n', '<Leader>rdu', '<cmd>call PhpDetectUnusedUseStatements()<CR>')
-- vim.keymap.set('v', '<Leader>==',  '<cmd>call PhpAlignAssigns()<CR>')
-- vim.keymap.set('n', '<Leader>rgs', '<cmd>call PhpCreateSettersAndGetters()<CR>')
-- vim.keymap.set('n', '<Leader>rlg', '<cmd>call PhpCreateGetters()<CR>') --<leader>rog
-- vim.keymap.set('n', '<Leader>rdk', '<cmd>call PhpDocAll()<CR>') --<leader>rda

--PHPFolding
vim.keymap.set('n', '<leader>1', '<cmd>set foldenable<CR>', {silent=true})
vim.keymap.set('n', '<leader>2', '<cmd>set nofoldenable<CR>', {silent=true})

--gitblame plugin
vim.keymap.set('n', '<leader>b', ':GitBlameToggle<CR>', {silent=true})

--exit terminal with esc
vim.keymap.set('t', '<M-Esc>', '<C-\\><C-N>', {})
--exit toggleterm with esc
function Set_terminal_keymaps()
    vim.keymap.set('t', '<esc>', "<cmd>ToggleTerm<CR>", {buffer=true})
end

vim.cmd('autocmd! TermOpen term://*toggleterm#* lua Set_terminal_keymaps()')

vim.keymap.set('n','<C-t>',':1ToggleTerm<CR>',{silent=true})
-- vim.keymap.set('n','<M-t>',':2ToggleTerm direction=vertical<CR>',{silent=true})

--use my checklist plugin
require('plugin.todolist.window')
--my ckecklist specific shortcuts
vim.keymap.set('n', '<F5>', ':lua ToggleChecklist()<CR>', {silent=true})
function Set_checklist_keymaps()
  vim.keymap.set('n', '<esc>', ':lua ToggleChecklist()<CR>', {silent=true, buffer=true})
end
vim.cmd('autocmd BufEnter *.md lua Set_checklist_keymaps()')

--keymap for my sail plugin
vim.keymap.set('n', '<leader>sf', '<cmd>SailRunTest<CR>', {silent=true})

--langmap is cringe, so do this piece on code
vim.keymap.set('n', '<leader><ESC>', ':set langnoremap<CR>', {silent=true})
vim.keymap.set('n', '@',function ()
  vim.o.langremap=true
  return '@'
end, {silent=true, expr=true})

vim.keymap.set('n', '<c-esc>', ':ccl<enter>', {silent=true})

--invert so lower case letter are global marks
local all_letter = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

for i = 1, string.len(all_letter) do
  local char = string.sub(all_letter, i, i)
  if (char == char:upper()) then
    local char_lower = char:lower()
    vim.keymap.set('n', 'm'.. char, 'm'..char_lower, {})
    vim.keymap.set('n', "'".. char, "'"..char_lower, {})
  else
    local char_upper = char:upper()
    vim.keymap.set('n', 'm'.. char, 'm'..char_upper, {})
    vim.keymap.set('n', "'".. char, "'"..char_upper, {})
  end
end
