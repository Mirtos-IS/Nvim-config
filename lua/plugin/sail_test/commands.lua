require('plugin.sail_test.functions')

local notify = require("notify")
local tinkerBufnr = -1

vim.api.nvim_create_user_command("SailRunTest", function()
  local file_name = vim.fn.expand('%:t')
  local is_php_test = string.find(file_name, '.*Test.php')
  if is_php_test == nil then
    notify('This is not a php file')
    return
  end
  local command = GetTestCommand()
  OpenTerminal(command, 3)
end,{})

vim.api.nvim_create_user_command("SailTestCurrentMethod", function()
  local file_name = vim.fn.expand('%:t')
  local is_php_test = string.find(file_name, '.*Test.php')
  if is_php_test == nil then
    notify('This is not a php file')
    return
  end

  RunTestCurrentMethod()
end,{})

vim.api.nvim_create_user_command("SailTinker", function ()
  if tinkerBufnr > -1 then
    local text = vim.api.nvim_buf_get_lines(tinkerBufnr, 0, 1, 0)[1]
    local isOpen = string.find(text, '>>>')
    local isOpen2 = string.find(text, 'Psy Shell')
    if isOpen ~= nil or isOpen2 ~= nil then
      vim.cmd("2ToggleTerm size=100")
      return
    end
  end
  local command = 'clear && sail tinker'
  OpenTerminal(command)
  vim.cmd('wincmd l')
  tinkerBufnr = vim.api.nvim_win_get_buf(0)

end,{})
