vim.api.nvim_create_user_command("SailRunTest", function()
  local file_name = vim.fn.expand('%:t')
  local is_php_test = string.find(file_name, '.*Test.php')
  if is_php_test == nil then
    print('This is not a php file')
    return
  end
  local file_dir = GetTestFileDir()
  OpenTerminal(file_dir)
end,{})

function OpenTerminal(file_dir)
    local cmd = 'clear && sail test '
    local command = cmd .. file_dir
    vim.cmd("2TermExec cmd='"..command.."' dir=$WORK direction=vertical")
  end

function GetTestFileDir()
  local file_full_dir = vim.fn.expand('%:p')
  local file_test_dir = string.gsub(file_full_dir, '.*tests', 'tests')
  return file_test_dir
end

