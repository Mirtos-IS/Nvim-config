local utils = require('plugins.test-results.utils')
local notify = require('notify').notify

local M = {}
M.source = 'PHPMD'

function M.parser(data)
  local result = vim.fn.json_decode(data)
  if type(next(result.files)) == "nil" then
    return
  end

  local violations = result.files[1].violations
  for i, violation in ipairs(violations) do
    local begin_line = violation.beginLine
    local end_line = violation.endLine
    local rule = violation.rule
    local description = violation.description
    utils.markFail(i, begin_line, end_line, 0, description, rule,  M.source)
  end
end

local function runPhpmd()
  utils.cleanTest(M.source)
  utils.bufnr = vim.api.nvim_get_current_buf()

  local file = vim.fn.expand('%:p')
  local git_root_dir = '/' .. vim.fn['FugitiveGitDir']():match('.(.*)/.git')
  local phpmd_cmd = git_root_dir .. '/vendor/bin/phpmd'
  local options = 'json ' .. git_root_dir .. '/.linters/phpmd.xml'

  local full_command = phpmd_cmd .. ' ' .. file .. ' ' .. options
  return utils.runLinter(full_command, M)
end

vim.api.nvim_create_user_command("RunPhpmd", function ()
  if utils.isPhpFile() then
    runPhpmd()
  end
end, {})

return M
