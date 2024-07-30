local modules = require('lualine.components.branch.git_branch')

--go specific maping
vim.keymap.set('', '<leader>gr', '<cmd>GoRun<CR>', {silent=true})

vim.api.nvim_create_user_command('GoRun', function ()
  local command = "C-c\" \" templ generate && go run *.go"
  local dir = '/' .. modules.find_git_dir():match('.(.*)/.git')
  os.execute(string.format("tmux if-shell 'tmux send-keys -t 2.0 \"%s\n\"' 'select-window -t :2' 'new-window -t :2 -c %s; send-keys -t :2.0 \"%s\n\"; select-window -t :2'", command, dir, command))
end
, {})
