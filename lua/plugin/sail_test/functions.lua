local ts_utils = require'nvim-treesitter.ts_utils'
local notify = require("notify")

function OpenTerminal(command, term)
  term = term or 2
    vim.cmd(term .. "TermExec cmd='"..command.."' dir=$WORK direction=vertical size=100")
  end

function GetTestCommand(method)
  method = method or nil

  local file_full_dir = vim.fn.expand('%:p')
  local file_test_dir = string.gsub(file_full_dir, '.*tests', 'tests')
  local cmd = 'clear && sail test '
  if method == nil then
    return cmd .. file_test_dir
  end
  return cmd .. '--filter ' .. method .. ' ' ..file_test_dir
end

function RunTestCurrentMethod()
  local method_name = GetCurrentFunctionName()
  if string.len(method_name) < 4 then
    notify('no method was found')
    return
  end
  local cmd = GetTestCommand(method_name)
  OpenTerminal(cmd, 3)
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

  return vim.treesitter.query.get_node_text(expr:child(2),0)
end
