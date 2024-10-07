local utils = require('plugins.test-results.utils')
local notify = require('notify').notify

local M = {}
M.source = 'PHPCS'

function M.parser(data)
  if string.find(utils.dump(data), 'messages') == nil then
    return
  end

  if string.find(utils.dump(data[4]), 'messages') ~= nil then
    data = data[4]
  else
    data = data[1]
  end

  local result_raw = vim.fn.json_decode(data)
  local _, result = next(result_raw.files)
  if type(next(result.messages)) == "nil" then
    return
  end


  local violations = result.messages
  for i, violation in ipairs(violations) do
    local begin_line = violation.line
    local column = violation.column - 1
    local description = violation.message
    utils.markFail(i, begin_line, begin_line, column,  description, 'PHPCS Error', M.source)
  end
end

local function runPhpcs()
  utils.cleanTest(M.source)
  utils.bufnr = vim.api.nvim_get_current_buf()

  local file = vim.fn.expand('%:p')
  local git_root_dir = '/' .. vim.fn['FugitiveGitDir']():match('.(.*)/.git')
  local phpcs_cmd = git_root_dir .. '/vendor/bin/phpcs'
  local options = '--report=json --no-cache --standard=' .. git_root_dir .. '/.linters/phpcs.xml'

  local full_command = phpcs_cmd .. ' ' .. options .. ' ' .. file
  return utils.runLinter(full_command, M)
end

vim.api.nvim_create_user_command("RunPhpcs", function ()
  if utils.isPhpFile() then
    runPhpcs()
  end
end, {})

return M
