local ts_utils = require'nvim-treesitter.ts_utils'
local modules = require('lualine.components.branch.git_branch')
local notify = require("notify")

function OpenTerminal(command, split)
  local dir = '/' .. modules.find_git_dir():match('.(.*)/.git')
  if split then
    os.execute(string.format("tmux if -F '#{==:#{window_panes},1}' 'split-window -dh -l 70 -c %s; send-keys -t 1 \"%s\n\"' 'send-keys -t 1 \"%s\n\"'", dir, command, command))
    return
  end
  os.execute(string.format("tmux if-shell 'tmux send-keys -t 2.0 \"%s\n\"' 'select-window -t :2' 'new-window -t :2 -c %s; send-keys -t :2.0 \"%s\n\"; select-window -t :2'", command, dir, command))
end

function GetTestCommand(method)
  method = method or nil

  local file_full_dir = vim.fn.expand('%:p')
  local file_test_dir = string.gsub(file_full_dir, '.*tests', 'tests')
  local cmd = 'clear && sail test '
  if method == nil then
    return cmd .. file_test_dir .. ' order-by=random'
  end
  return string.format('%s--filter %s %s', cmd, method, file_test_dir)
end

function RunTestCurrentMethod(split)
  local method_name = GetCurrentFunctionName()
  if string.len(method_name) < 4 then
    notify('no method was found')
    return
  end
  local cmd = GetTestCommand(method_name)
  OpenTerminal(cmd, split)
end


function GetCurrentFunctionName()
  local current_node = ts_utils.get_node_at_cursor()
  if not current_node then
    return ""
  end

  local expr = current_node

  while expr do
      if expr:type() == 'function_declaration' or expr:type() == 'method_declaration' then
          break
      end
      expr = expr:parent()
  end

  if not expr then return "" end

  return vim.treesitter.get_node_text(expr:child(2),0)
end
