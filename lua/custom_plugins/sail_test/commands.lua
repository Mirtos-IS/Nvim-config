local notify = require("notify")

vim.api.nvim_create_user_command("SailRunTest", function(split)
  split = split.args == 'v' or split.args == 'split'

  local file_name = vim.fn.expand('%:t')
  local is_php_test = string.find(file_name, '.*Test.*.php')
  if is_php_test == nil then
    notify('This is not a php test file')
    return
  end
  local command = GetTestCommand()
  OpenTerminal(command, split)
end,{nargs = "*"})

vim.api.nvim_create_user_command("SailTestCurrentMethod", function(split)
  split = split.args == 'v' or split.args == 'split'

  local file_name = vim.fn.expand('%:t')
  local is_php_test = string.find(file_name, '.*Test.*.php')
  if is_php_test == nil then
    notify('This is not a php test file')
    return
  end

  RunTestCurrentMethod(split)
end,{nargs = "*"})
