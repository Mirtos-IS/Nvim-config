local tinkerBufnr = -1
vim.api.nvim_create_user_command("SailRunTest", function()
  local file_name = vim.fn.expand('%:t')
  local is_php_test = string.find(file_name, '.*Test.php')
  if is_php_test == nil then
    print('This is not a php file')
    return
  end
  local command = GetTestCommand()
  OpenTerminal(command)
end,{})

vim.api.nvim_create_user_command("SailTinker", function ()
  print(tinkerBufnr)
  if tinkerBufnr > -1 then
    local text = vim.api.nvim_buf_get_lines(tinkerBufnr, 0, 1, 0)[1]
    local isOpen = string.find(text, '>>>')
    local isOpen2 = string.find(text, 'Psy Shell')
    if isOpen ~= nil or isOpen2 ~= nil then
      vim.cmd("2ToggleTerm")
      return
    end
  end
  local command = 'clear && sail tinker'
  OpenTerminal(command)
  vim.cmd('wincmd l')
  tinkerBufnr = vim.api.nvim_win_get_buf(0)

end,{})

function OpenTerminal(command)
    vim.cmd("2TermExec cmd='"..command.."' dir=$WORK direction=vertical")
  end

function GetTestCommand()
  local file_full_dir = vim.fn.expand('%:p')
  local file_test_dir = string.gsub(file_full_dir, '.*tests', 'tests')
  local cmd = 'clear && sail test '
  return cmd .. file_test_dir
end
