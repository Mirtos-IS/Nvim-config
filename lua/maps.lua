--leader mapping
vim.g.mapleader = ' '

vim.keymap.set('n', '<leader><leader>s', ':so %<CR>', {})
vim.keymap.set('n', '<leader><leader>a', ':so $MYVIMRC<CR>', {})

vim.keymap.set('', '<leader>wn', '<C-w>h', {})
vim.keymap.set('', '<leader>we', '<C-w>j', {})
vim.keymap.set('', '<leader>wa', '<C-w>l', {})
vim.keymap.set('', '<leader>wo', '<C-w>k', {})
vim.keymap.set('', '<leader>wl', '<C-w>o', {})

local nvim_tmux_nav = require('nvim-tmux-navigation')
vim.keymap.set('', '<M-n>', nvim_tmux_nav.NvimTmuxNavigateLeft, {})
vim.keymap.set('', '<M-e>', nvim_tmux_nav.NvimTmuxNavigateDown, {})
vim.keymap.set('', '<M-a>', nvim_tmux_nav.NvimTmuxNavigateRight, {})
vim.keymap.set('', '<M-o>', nvim_tmux_nav.NvimTmuxNavigateUp, {})

vim.keymap.set('', '<M-l>', '<C-w>o', {})

vim.keymap.set('', '<leader>wN', '<C-w>H', {})
vim.keymap.set('', '<leader>wE', '<C-w>J', {})
vim.keymap.set('', '<leader>wA', '<C-w>L', {})
vim.keymap.set('', '<leader>wO', '<C-w>K', {})

--<leader>w for quick win movement
vim.keymap.set('n', '<leader>w', '<C-w>', {})

--make life easier with inner motion
vim.keymap.set({'n', 'v'}, '<leader>y', 'yi',{remap = true})
vim.keymap.set({'n', 'v'}, '<leader>v', 'vi',{remap = true})
vim.keymap.set({'n', 'v'}, '<leader>c', '"_ci',{remap = true})
vim.keymap.set({'n', 'v'}, '<leader>d', 'di',{remap = true})

vim.keymap.set({'n', 'v'}, '<C-y>', '"+y',{remap = true})

--search and replace word under cursor
vim.keymap.set('n', '<leader>f', ':%s/<C-r><C-W>/<C-u><C-W>/g<left><left>', {})
--search what in register
vim.keymap.set('n', '<C-h>', '/<C-r>"<CR>', {})

--quickfix shortcuts
vim.keymap.set('n', '<M-h>', '<cmd>keepjumps cn<CR>', {silent=true})
vim.keymap.set('n', '<M-H>', '<cmd>keepjumps cp<CR>', {silent=true})

vim.keymap.set('n', '<leader>q', '<cmd>q!<CR>', {})

--harpoon manip
vim.keymap.set('n', '<leader>p', function ()
  require("harpoon.ui").toggle_quick_menu()
end, {silent=true})
vim.keymap.set('n', '<leader>e', function ()
  require("harpoon.mark").add_file()
end, {silent=true})

--buffer
vim.keymap.set('n', '<leader>b', function () require("fzf-lua").buffers({files = {path_shorten=2}}) end)


--localleader mapping
vim.g.maplocalleader = vim.api.nvim_replace_termcodes('<BS>', false, false, true)

--tab
vim.keymap.set('n', '<localleader>a', ":tabn<CR>", {silent=true})
vim.keymap.set('n', '<localleader>n', ":tabp<CR>", {silent=true})

--grep current word
vim.keymap.set('n', '<localleader>f', function ()
  require("fzf-lua").live_grep({search=vim.fn.expand("<cword>")})
end)

--diagnostic
vim.keymap.set('n', '<localleader>dd', function () require("fzf-lua").diagnostics_document() end)
vim.keymap.set('n', '<localleader>de', function () vim.diagnostic.goto_next() end, {})
vim.keymap.set('n', '<localleader>do', function () vim.diagnostic.goto_prev() end, {})
vim.keymap.set('n', '<localleader>o', function () vim.diagnostic.open_float({
  source = true,
  format = function(diag)
    return diag.user_data
  end
}) end,{silent=true})

--git
vim.keymap.set('n', '<localleader>bb', ':GBlame<CR>', {silent=true})
vim.keymap.set('n', '<localleader>ga', function ()
  require('notify').notify(string.format('git added %s', vim.fn.expand('%:t')))
  vim.cmd('Git add .')
end, {})
vim.keymap.set('n', '<localleader>gp', function ()
  require('notify').notify('Pushing changes')
  local branch = vim.fn['FugitiveHead']()
  vim.cmd(string.format('Git! push --set-upstream origin %s', branch))
end, {})
vim.keymap.set('n', '<localleader>gc', function ()
  local branch = vim.fn['FugitiveGitDir']()
  if branch:find('turno') then
    branch = vim.fn['FugitiveHead']()
    local text = branch:match('T[^-]*-[^-]*')
    vim.cmd('Git commit')
    if (vim.bo.filetype ~= 'gitcommit') then
      return;
    end
    vim.cmd(string.format('norm i%s:  ', text))
    vim.cmd('startinsert')
  else
    vim.cmd('Git commit')
    vim.cmd('startinsert')
  end
end, {})
vim.keymap.set('n', '<localleader>gb', function () require("fzf-lua").git_bcommits() end, {silent=true})
vim.keymap.set('n', '<localleader>bt', '<cmd>GitBlameToggle<CR>', {silent=true})
vim.keymap.set('n', '<localleader>bo', '<cmd>GitBlameOpenCommitURL<CR>', {silent=true})

--clipboard action
vim.keymap.set({'n', 'v'}, '<localleader>y', '"+yi',{remap = true})
vim.keymap.set({'n', 'v'}, '<localleader>p', '"+pi',{remap = true})

vim.keymap.set('n', '<localleader>q', ':qa!<CR>', {silent = true})


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

vim.keymap.set('', 'k', 's', {})
vim.keymap.set('', 's', 'a', {})
vim.keymap.set('', 'l', 'o', {})

vim.keymap.set('', 'K', 'S', {})
vim.keymap.set('', 'S', 'A', {})
vim.keymap.set('', 'L', 'O', {})

vim.keymap.set('', 'h', 'n', {})
vim.keymap.set('', 'H', 'N', {})

--i prefer having it than having to deal with langmap
vim.keymap.set('', '<C-w>n', '<C-w>h', {})
vim.keymap.set('', '<C-w>e', '<C-w>j', {})
vim.keymap.set('', '<C-w>a', '<C-w>l', {})
vim.keymap.set('', '<C-w>o', '<C-w>k', {})
vim.keymap.set('', '<C-w>l', '<C-w>o', {})


vim.keymap.set('', '<M-c>', '<C-w>c', {})

vim.keymap.set('', '<M-N>', '<C-w>H', {})
vim.keymap.set('', '<M-A>', '<C-w>L', {})

--fixing some quirks with langmap
vim.keymap.set('n', '<C-l>', '<C-o>', {})
vim.keymap.set('n', '<C-m>', '<c-i>', {})
vim.keymap.set('', '<C-k>', '<C-a>', {})
vim.keymap.set('', 'g<C-k>', 'g<C-a>', {})

vim.keymap.set({'n', 'v'}, '<C-o>', '<C-u>zz', {remap = true})
vim.keymap.set({'n', 'v'}, '<C-e>', '<C-d>zz', {remap = true})

--deleting without yank
vim.keymap.set({'n', 'v'}, 'x', '"_x', {})
vim.keymap.set({'n', 'v'}, 'c', '"_c', {})

--paste without yank
vim.keymap.set('v', 'p', '"_dp', {})

--general shortcuts - <C-K> to get the true input
vim.keymap.set({'n', 'v'}, '<C-s>', '<cmd>w!<CR>', {silent = true})
vim.keymap.set('i', '<C-s>', '<ESC><cmd>w!<CR>', {silent = true})
vim.keymap.set('n', '<S-u>', '<cmd>redo<CR>', {silent = true})

--remove search highlight

vim.keymap.set('n', '<ESC>', '<cmd>nohls<CR>', {})
--move lines around the code
vim.keymap.set('n', '<M-E>', '<cmd>m +1<CR>==', {})
vim.keymap.set('n', '<M-O>', '<cmd>m -2<CR>==', {})
vim.keymap.set('v', '<M-E>', ":m '>+1<CR>gv=gv", {})
vim.keymap.set('v', '<M-O>', ":m '<-2<CR>gv=gv", {})

--dismiss notify notifications
vim.keymap.set('', '<M-ESC>', function () require('notify').dismiss() end, {})

--tab for indentention
vim.keymap.set('n', '<tab>', '>>', {})
vim.keymap.set('v', '<tab>', '>gv', {})
vim.keymap.set('n', '<s-tab>', '<<', {})
vim.keymap.set('v', '<s-tab>', '<gv', {})

--horizontal scroll
vim.keymap.set('n', '<C-a>', 'zL', {})
vim.keymap.set('n', '<C-n>', 'zH', {})

--buffer shortcuts
vim.keymap.set('n', '<M-x>', '<cmd>bd<CR>', {})

--fuzzy finder
vim.keymap.set('n', '<F3>', function () require("fzf-lua").files() end , {silent=true})
vim.keymap.set('n', '<F6>', function () require("fzf-lua").live_grep() end , {silent=true})

--auto add ; to the end of line
vim.keymap.set('n', '<M-;>', 'A;<ESC>', {})
vim.keymap.set('i', '<M-;>', '<ESC>A;<ESC>', {})

--call cmp select in current word
vim.keymap.set('n', '<C-SPACE>', 'wi<C-SPACE>', {remap = true})

--use my checklist plugin
--my ckecklist specific shortcuts
vim.keymap.set('n', '<F4>', ':lua ToggleTodolist()<CR>', {silent=true})
vim.keymap.set('n', '<F5>', ':lua ToggleChecklist()<CR>', {silent=true})


vim.keymap.set('n', '<C-c>', ':ccl<enter>', {silent=true})

local all_letter = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

vim.keymap.set('n', "'s", "'S", {})
vim.keymap.set('n', "'w", "'W", {})

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

function Set_checklist_keymaps()
  vim.keymap.set('n', '<esc>', ':lua ToggleChecklist()<CR>', {silent=true, buffer=true})
  -- vim.keymap.set('n', '<leader>e', ':ToggleTermSendCurrentLine 2<CR>', {silent=true, buffer=true})
end

function Set_todolist_keymaps()
  vim.keymap.set('n', '<F4>', function () ToggleTodolist() end, {silent=true})
end

vim.cmd('autocmd BufEnter checklist.md lua Set_checklist_keymaps()')
vim.cmd('autocmd BufEnter todolist.md lua Set_checklist_keymaps()')

--snippets

vim.keymap.set('n', ',e', 'o<ESC>:-1read ~/.config/nvim/snippets/err<CR>o', {silent=true})
