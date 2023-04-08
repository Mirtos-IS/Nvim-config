require('plugins.sail_test.functions')

local notify = require("notify")
local tinkerBufnr = -1

vim.api.nvim_create_user_command("SailRunTest", function()
  local file_name = vim.fn.expand('%:t')
  local is_php_test = string.find(file_name, '.*Test.php')
  if is_php_test == nil then
    notify('This is not a php test file')
    return
  end
  local command = GetTestCommand()
  OpenTerminal(command, 3)
end,{})

vim.api.nvim_create_user_command("SailTestCurrentMethod", function()
  local file_name = vim.fn.expand('%:t')
  local is_php_test = string.find(file_name, '.*Test.php')
  if is_php_test == nil then
    notify('This is not a php test file')
    return
  end

  RunTestCurrentMethod()
end,{})

vim.api.nvim_create_user_command("SailTinker", function ()
  if tinkerBufnr > -1 then
    local text = GetLastNonEmptyLine(tinkerBufnr)
    local isOpen = string.find(text, '>>>')
    if isOpen ~= nil then
      vim.cmd("2ToggleTerm size=100")
      return
    end
  end
  local command = 'clear && sail tinker'
  OpenTerminal(command)
  vim.cmd('wincmd l')
  tinkerBufnr = vim.api.nvim_win_get_buf(0)

end,{})
