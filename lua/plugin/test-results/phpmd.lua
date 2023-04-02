local utils = require('plugin.test-results.utils')
local notify = require('notify').notify
local modules = require('lualine.components.branch.git_branch')

local function parsePhpmd(data)
  local result = vim.fn.json_decode(data)
  if type(next(result.files)) == "nil" then
    notify('No mess detected')
    return
  end

  local violations = result.files[1].violations
  for i, violation in ipairs(violations) do
    local begin_line = violation.beginLine
    local end_line = violation.endLine
    local rule = violation.rule
    local description = violation.description
    utils.markFail(i, begin_line, end_line, description, rule, 'PHPMD')
  end
end

local function runPhpmd()
  utils.tests = {}
  utils.bufnr = vim.api.nvim_get_current_buf()
  local file = vim.fn.expand('%:p')
  local git_root_dir = '/' .. modules.find_git_dir():match('.(.*)/.git')
  local phpmd_cmd = git_root_dir .. '/vendor/bin/phpmd'
  local options = 'json ' .. git_root_dir .. '/.linters/phpmd.xml'

  local full_command = phpmd_cmd .. ' ' .. file .. ' ' .. options
  utils.runTerminalCommand(full_command, parsePhpmd)
end

vim.api.nvim_create_user_command("RunPhpmd", function ()
  runPhpmd()
end, {})
