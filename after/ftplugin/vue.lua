local branch = vim.fn['FugitiveGitDir']()

vim.keymap.set('', '<leader>gr', '<cmd>NpmRun<CR>', {silent=true})

vim.api.nvim_create_user_command('NpmRun', function ()
  local command = "sail npm run dev"
  local dir = '/' .. branch:match('.(.*)/.git')
  os.execute(string.format("tmux if-shell 'tmux send-keys -t 0.0 \"%s\n\"' 'select-window -t :0' 'new-window -t :0 -c %s; send-keys -t :0.0 \"%s\n\"; select-window -t :0'", command, dir, command)) end
, {})
