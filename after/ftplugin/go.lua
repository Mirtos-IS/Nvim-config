local branch = vim.fn['FugitiveGitDir']()

--go specific maping
vim.keymap.set('', '<leader>gr', '<cmd>GoRun<CR>', {silent=true})
vim.keymap.set('', '<leader>ta', '<cmd>RunGoTest<CR>', {silent=true})
vim.keymap.set('', '<leader>tf', '<cmd>RunGoTestOnFunc<CR>', {silent=true})

vim.api.nvim_create_user_command('GoRun', function ()
  local command = "C-c\" \" go run *.go"
  local dir = '/' .. branch:match('.(.*)/.git')
  os.execute(string.format("tmux if-shell 'tmux send-keys -t 2.0 \"%s\n\"' 'select-window -t :2' 'new-window -t :2 -c %s; send-keys -t :2.0 \"%s\n\"; select-window -t :2'", command, dir, command))
end
, {})
