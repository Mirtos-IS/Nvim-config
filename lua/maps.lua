vim.g.mapleader = ' '

vim.keymap.set('n', '<leader><leader>s', ':so %<CR>', {})
vim.keymap.set('n', '<leader><leader>a', ':so $MYVIMRC<CR>', {})

vim.keymap.set('n', '<leader>h', '<cmd>HopWord<CR>', {silent = true})

--swapping movemente keys to jklç
-- vim.cmd( 'set langmap=nh,ej,ok,al,hn,je,ka,lo,NH,EJ,OK,AL,HN,JE,KA,LO')

vim.keymap.set('', 'n', '<LEFT>', {})
vim.keymap.set('', 'a', '<RIGHT>', {})
vim.keymap.set('', 'e', '<DOWN>', {})
vim.keymap.set('', 'o', '<UP>', {})

vim.keymap.set('', 'N', 'H', {})
vim.keymap.set('', 'A', 'L', {})
vim.keymap.set('', 'E', 'J', {})
vim.keymap.set('', 'O', 'K', {})

vim.keymap.set('', 'k', 'a', {})
vim.keymap.set('', 'l', 'o', {})

vim.keymap.set('', 'K', 'A', {})
vim.keymap.set('', 'L', 'O', {})

vim.keymap.set('', 'h', 'n', {})
vim.keymap.set('', 'H', 'N', {})

--i prefer having it than having to deal with langmap
vim.keymap.set('', '<C-w>n', '<C-w>h', {})
vim.keymap.set('', '<C-w>e', '<C-w>j', {})
vim.keymap.set('', '<C-w>a', '<C-w>l', {})
vim.keymap.set('', '<C-w>o', '<C-w>k', {})

vim.keymap.set('', '<leader>wn', '<C-w>h', {})
vim.keymap.set('', '<leader>we', '<C-w>j', {})
vim.keymap.set('', '<leader>wa', '<C-w>l', {})
vim.keymap.set('', '<leader>wo', '<C-w>k', {})

vim.keymap.set('', '<leader>wN', '<C-w>H', {})
vim.keymap.set('', '<leader>wE', '<C-w>J', {})
vim.keymap.set('', '<leader>wA', '<C-w>L', {})
vim.keymap.set('', '<leader>wO', '<C-w>K', {})

--fixing some quirks with langmap
vim.keymap.set('n', '<C-l>', '<C-o>', {})
vim.keymap.set('n', '<C-i>', '<C-i>', {})
vim.keymap.set('n', '<C-k>', '<C-a>', {})

vim.keymap.set('n', '<leader>w', '<C-w>', {})

vim.keymap.set({'n', 'v'}, '<C-o>', '<C-u>', {remap = true})
vim.keymap.set({'n', 'v'}, '<C-e>', '<C-d>', {remap = true})

--<leader>w for quick win movement
vim.keymap.set('n', '<leader>w', '<C-w>', {})

--lsp
vim.keymap.set('n', '<leader>g', function () require("telescope.builtin").lsp_definitions() end, {silent=true})
vim.keymap.set('n', '<space>m', vim.diagnostic.open_float,{})

--deleting without yank
vim.keymap.set({'n', 'v'}, 'x', '"_x', {})
vim.keymap.set({'n', 'v'}, 'c', '"_c', {})

--paste without yank
vim.keymap.set('v', 'p', '"_dp', {})

--copy to clipboard
vim.keymap.set({'n', 'v'}, '<C-y>', '"+y',{})

--copy to clipboard
vim.keymap.set({'n', 'v'}, '<C-p>', '"+p',{})

--make life easier with inner motion
vim.keymap.set({'n', 'v'}, '<leader>y', 'yi',{})
vim.keymap.set({'n', 'v'}, '<leader>v', 'vi',{})
vim.keymap.set({'n', 'v'}, '<leader>c', '"_ci',{})
vim.keymap.set({'n', 'v'}, '<leader>d', 'di',{})

--general shortcuts - <C-K> to get the true input
vim.keymap.set({'n', 'v'}, '<C-s>', '<cmd>w!<CR>', {silent = true})
vim.keymap.set('i', '<C-s>', '<ESC><cmd>w!<CR>', {silent = true})
vim.keymap.set('n', '<S-u>', '<cmd>redo<CR>', {silent = true})

--search and replace word under cursor
vim.keymap.set('n', '<S-s>', ':s/<C-R><C-W>//g<left><left>', {})
vim.keymap.set('n', '<leader>f', ':%s/<C-R><C-W>//g<left><left>', {})

--go to curent return type in php
vim.keymap.set('n', '<leader>rr', '[[f)a: ', {remap = true})

--remove search highlight
vim.keymap.set('n', '<ESC>', '<cmd>nohls<CR>', {})

--move lines around the code
vim.keymap.set('n', '<M-e>', '<cmd>m +1<CR>==', {})
vim.keymap.set('n', '<M-o>', '<cmd>m -2<CR>==', {})
vim.keymap.set('v', '<M-o>', ":m '<-2<CR>gv=gv", {})
vim.keymap.set('v', '<M-e>', ":m '>+1<CR>gv=gv", {})

--tab for indentention
vim.keymap.set('n', '<tab>', '>>', {})
vim.keymap.set('v', '<tab>', '>gv', {})
vim.keymap.set('n', '<s-tab>', '<<', {})
vim.keymap.set('v', '<s-tab>', '<gv', {})

--horizontal scroll
vim.keymap.set('n', '<C-a>', 'zL', {})
vim.keymap.set('n', '<C-n>', 'zH', {})

--tab shortcuts
vim.keymap.set('n', '<leader>tn', '<cmd>tabnew<CR>', {silent=true})
vim.keymap.set('n', '<leader>tu', '<cmd>tabc<CR>', {silent=true})
vim.keymap.set('n', '<leader>n', '<cmd>keepjumps tabp<CR>', {silent=true})
vim.keymap.set('n', '<leader>a', '<cmd>keepjumps tabn<CR>', {silent=true})

--buffer shortcuts
vim.keymap.set('n', '<M-n>', '<cmd>keepjumps bp<CR>', {})
vim.keymap.set('n', '<M-a>', '<cmd>keepjumps bn<CR>', {})
vim.keymap.set('n', '<M-u>', '<cmd>Bdelete<CR>', {})

--fuzzy finder
vim.keymap.set('n', '<F3>', '<cmd>lua require("telescope.builtin").find_files()<CR>' , {silent=true})
vim.keymap.set('n', '<F6>', '<cmd>lua require("telescope.builtin").live_grep()<CR>' , {silent=true})

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

--Folding
vim.keymap.set('n', '<leader>1', '<cmd>set foldenable<CR>', {silent=true})
vim.keymap.set('n', '<leader>2', '<cmd>set nofoldenable<CR>', {silent=true})

--gitblame plugin
vim.keymap.set('n', '<leader>b', ':GitBlameToggle<CR>', {silent=true})

--exit terminal with esc
vim.keymap.set('t', '<M-Esc>', '<C-\\><C-N>', {})

vim.keymap.set('n','<C-t>',':1ToggleTerm<CR>',{silent=true})

--use my checklist plugin
--my ckecklist specific shortcuts
vim.keymap.set('n', '<F4>', ':lua ToggleTodolist()<CR>', {silent=true})
vim.keymap.set('n', '<F5>', ':lua ToggleChecklist()<CR>', {silent=true})


--keymap for my sail plugin
vim.keymap.set('n', '<leader>sf', '<cmd>SailRunTest<CR>', {silent=true})
vim.keymap.set('n', '<leader>st', '<cmd>SailTinker<CR>', {silent=true})
vim.keymap.set('n', '<leader>sm', '<cmd>SailTestCurrentMethod<CR>', {silent=true})

vim.keymap.set('n', '<c-esc>', ':ccl<enter>', {silent=true})

local all_letter = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

for i = 1, string.len(all_letter) do
  local char = string.sub(all_letter, i, i)
  if (char == char:upper()) then
    vim.keymap.set('n', 'm'.. char, 'm'..char:lower(), {})
    vim.keymap.set('n', "'".. char, "'"..char:lower(), {})
  else
    vim.keymap.set('n', 'm'.. char, 'm'..char:upper(), {})
    vim.keymap.set('n', "'".. char, "'"..char:upper(), {})
  end
end

--Harpoon fork mapping
--quick access
vim.keymap.set('n', '<M-t>', function ()
  require("harpoon.ui").nav_file(1)
end, {silent=true})
vim.keymap.set('n', '<M-r>', function ()
  require("harpoon.ui").nav_file(2)
end, {silent=true})
vim.keymap.set('n', '<M-s>', function ()
  require("harpoon.ui").nav_file(3)
end, {silent=true})
vim.keymap.set('n', '<M-i>', function ()
  require("harpoon.ui").nav_file(4)
end, {silent=true})
--harpoon manip
vim.keymap.set('n', '<leader>p', function ()
  require("harpoon.ui").toggle_quick_menu()
end, {silent=true})
vim.keymap.set('n', '<leader>e', function ()
  require("harpoon.mark").add_file()
end, {silent=true})

function Set_terminal_keymaps()

    vim.keymap.set('t', '<esc>', "<cmd>ToggleTerm<CR>", {buffer=true})
end

function Set_checklist_keymaps()
  vim.keymap.set('n', '<esc>', ':lua ToggleChecklist()<CR>', {silent=true, buffer=true})
end

function Set_todolist_keymaps()
  vim.keymap.set('n', '<F4>', ':lua ToggleTodolist()<CR>', {silent=true})
end

vim.cmd('autocmd! TermOpen term://*toggleterm#* lua Set_terminal_keymaps()')
vim.cmd('autocmd BufEnter checklist.md lua Set_checklist_keymaps()')
vim.cmd('autocmd BufEnter todolist.md lua Set_checklist_keymaps()')
