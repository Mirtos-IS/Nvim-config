local ts_utils = require'nvim-treesitter.ts_utils'
local notify = require('notify').notify
local bufnr
local ns = vim.api.nvim_create_namespace('go-test')
local tests = {}

local source = 'go-test'

---@param test_name string
local function findTestByName(test_name)
  local lines = vim.api.nvim_buf_line_count(bufnr)
  for i = 0, lines, 1 do
    local line = vim.fn.getline(i)
    if line ~= nil and line:find('func ' .. test_name) ~= nil then
      return i
    end
  end
end

local function addTestResult(result)
  table.insert(tests, {
    name = result.Test,
    status = result.Action,
    description = result.Output,
    source = source,
    begin_line = findTestByName(result.Test) - 1
  })
end

local function markSuccess(line)
  vim.api.nvim_buf_set_extmark(bufnr, ns, line, 0, {
    virt_text = { { "✓" } },
  })
end

local function hasFailTest()
  for _, test in pairs(tests) do
    if test.status == "fail" then
      return true
    end
  end
  return false
end

local function notifyResults()
  if hasFailTest() then
    notify('Some Problems Were Found')
    return
  end
  notify('No Problem Found')
end

local function parser(data)
  for _, line in ipairs(data) do
    if line == "" then
      goto continue
    end

    local result = vim.fn.json_decode(line)
    for _, r in pairs(result) do
        addTestResult(r)
    end

    ::continue::
  end
end

local function runTest(command)
  vim.fn.jobstart(command, {
    on_stdout = function (_, data)
      if not data then
        return
      end
      parser(data)
    end,
    on_exit = function ()
      vim.diagnostic.reset(ns, bufnr)
      vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

      local failed = {}
      for _, test in pairs(tests) do
        if test.status == 'pass' then
          markSuccess(test.begin_line)
          goto continue
        end

        table.insert(failed, {
          bufnr = bufnr,
          lnum = test.begin_line,
          col = 1,
          message = test.description,
          severity = vim.diagnostic.severity.WARNING,
          user_data = test.description,
          source = test.source
        })

        ::continue::
      end
      notifyResults()
      vim.diagnostic.set(ns, bufnr, failed, {underline = false, signs = false})
    end
  })
end

local function getCurrentFunctionName()
  local current_node = ts_utils.get_node_at_cursor()
  if not current_node then
    return ""
  end

  local expr = current_node

  while expr do
      if expr:type() == 'function_declaration' then
          break
      end
      expr = expr:parent()
  end

  if not expr then return "" end

  return vim.treesitter.get_node_text(expr:child(1),0)
end

---@param withFile ?boolean
local function runGoTest(withFile)
  withFile = withFile or false
  tests = {}

  local file = vim.fn.expand('%:p')
  local go_test_command = '~/.config/nvim/scripts/go-test'

  local full_command = go_test_command .. ' ' .. file
  if withFile then
    local functionName = getCurrentFunctionName()
    if string.len(functionName) < 4 then
      notify('no function was found')
      return
    end
    full_command = full_command .. ' ' .. functionName
  end
  return runTest(full_command)
end

local function isGoFile()
  local file_name = vim.fn.expand('%:t')
  local is_go_file = string.find(file_name, '_test.go') ~= nil

  if is_go_file then
    return true
  end
    notify('This is not a go test file')
    return false
end

vim.api.nvim_create_user_command("RunGoTest", function ()
  bufnr = vim.api.nvim_get_current_buf()
  if isGoFile() then
    runGoTest()
  end
end, {})

vim.api.nvim_create_user_command("RunGoTestOnFunc", function ()
  bufnr = vim.api.nvim_get_current_buf()
  if isGoFile() then
    runGoTest(true)
  end
end, {})

