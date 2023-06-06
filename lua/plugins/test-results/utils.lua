local notify = require('notify').notify
local buf, win
local ns = vim.api.nvim_create_namespace('linter')

local M = {}

M.group = vim.api.nvim_create_augroup('test-results', {clear = true})
M.bufnr = vim.api.nvim_get_current_buf()
M.tests = {}

---@param index integer
---@param begin_line integer
---@param end_line integer
---@param column integer
---@param description string
---@param rule string
---@param source string
function M.markFail(index, begin_line, end_line, column, description, rule, source)
  local key = source .. '-' .. tostring(index)
  M.tests[key] = {
    name = rule,
    description = description,
    begin_line = begin_line - 1,
    end_line = end_line,
    source = source,
    column = column,
  }
end

local function hasFailedTest(source)
  for _, failed_test in pairs(M.tests) do
    if failed_test.source == source then
      return true
    end
  end
  return false
end

local function notifyResults(source)
  for _, failed_test in pairs(M.tests) do
    if failed_test.source == source then
      notify('Some Problems Were Found')
      return
    end
  end
  notify('No Problem Found')
end

function M.cleanTest(source)
  for i, failed_test in pairs(M.tests) do
    if failed_test.source == source then
      M.tests[i] = nil
    end
  end
end

function M.runLinter(command, Linter)
  vim.fn.jobstart(command, {
    on_stdout = function (_, data)
      if not data then
        return
      end
      Linter.parser(data)
    end,
    on_exit = function ()
      vim.api.nvim_buf_clear_namespace(M.bufnr, ns, 0, -1)
      vim.diagnostic.reset(ns, M.bufnr)

      local failed = {}
      if hasFailedTest(Linter.source) == false then
        notify('No Problem detected')
        return true
      end
      for _, test in pairs(M.tests) do
        table.insert(failed, {
          bufnr = M.bufnr,
          lnum = test.begin_line,
          end_lnum = test.end_line,
          message = test.name,
          severity = vim.diagnostic.severity.WARNING,
          col = test.column,
          user_data = test.description,
          source = test.source
        })
      end
      notifyResults(Linter.source)
      vim.diagnostic.set(ns, M.bufnr, failed, {underline = false, signs = false})
    end
  })
end

function M.open_win(win_h, win_w)
  buf = vim.api.nvim_create_buf(false, false)

  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  local ui = vim.api.nvim_list_uis()[1]
  local height = ui.height
  local width = ui.width

  local win_height = win_h or math.ceil(height * 0.6 - 3)
  local win_width = win_w or math.ceil(width * 0.6)

  local row = math.ceil((height/2 - win_height/2))
  local col = math.ceil((width/2 - win_width/2))

  local opts = {
    relative = "editor",
    width = win_width,
    height = win_height,
    style = 'minimal',
    row = row,
    col = col,
    focusable = false,
    border = "rounded",
}

  win = vim.api.nvim_open_win(buf, true, opts)
  vim.api.nvim_win_set_option(win, "winhighlight", 'Normal:Normal,FloatBorder:FloatBorder')
  vim.keymap.set('n', '<ESC>', ':q!<CR>', {silent = true, buffer = buf})
end



vim.api.nvim_create_user_command("GetLineDiag", function ()
  local output = {}
  local line = vim.fn.line "." -1
  for _, test in pairs(M.tests) do
    if test.begin_line == line then
      table.insert(output, {text = test.description})
    end
  end
  if output[1] == nil then
    return
  end

  M.open_win()
  for i, value in ipairs(output) do
    vim.api.nvim_buf_set_lines(buf, i-1, -1, false, {value.text})
  end
end, {})

vim.api.nvim_create_user_command("ClearLinterDiag", function ()
  vim.api.nvim_buf_clear_namespace(M.bufnr, ns, 0, -1)
  vim.diagnostic.reset(ns, M.bufnr)
end, {})

function M.dump(o)
  if type(o) == 'table' then
    local s = '{ '
    for k,v in pairs(o) do
      if type(k) ~= 'number' then k = '"'..k..'"' end
      s = s .. '['..k..'] = ' .. M.dump(v) .. ','
    end
    return s .. '} '
  else
    return tostring(o)
  end
end

function M.isPhpFile()
  local file_name = vim.fn.expand('%:t')
  local is_php_file = string.find(file_name, '.*.php') ~= nil

  if is_php_file then
    return true
  end
    notify('This is not a php file')
    return false
end

return M
