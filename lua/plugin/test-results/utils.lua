local ns = vim.api.nvim_create_namespace('linter')
local buf, win

local M = {}

M.group = vim.api.nvim_create_augroup('test-results', {clear = true})
M.bufnr = vim.api.nvim_get_current_buf()
M.tests = {}

function M.markFail(key, begin_line,end_line, description, rule, source)
  M.tests[key] = {
    name = rule,
    description = description,
    begin_line = begin_line - 1,
    end_line = end_line,
    source = source
  }
end

function M.runTerminalCommand(command, parser)
  vim.fn.jobstart(command, {
    stodout_buffered = true,
    on_stdout = function (_, data)
      if not data then
        return
      end
      parser(data)
    end,
    on_exit = function ()
      local failed = {}
      if type(next(M.tests)) == nil then
        return
      end
      for _, test in ipairs(M.tests) do
        table.insert(failed, {
          bufnr = M.bufnr,
          lnum = test.begin_line,
          end_lnum = test.end_line,
          message = test.name,
          severity = vim.diagnostic.severity.WARNING,
          col = 0,
          source = test.source
        })
      end
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
  for _, test in ipairs(M.tests) do
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

return M
