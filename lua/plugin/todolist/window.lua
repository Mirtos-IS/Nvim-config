local buf, win

function Open_win()
  buf = vim.api.nvim_create_buf(false, false)

  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  local width = vim.api.nvim_get_option("columns")
  local height = vim.api.nvim_get_option("lines")

  local win_height = math.ceil(height * 0.6 - 4)
  local win_width = math.ceil(width * 0.6)

  local row = math.ceil((height - win_height) / 2 - 1)
  local col = math.ceil((width - win_width) / 2)

  local opts = {
    style = 'minimal',
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col,
    focusable = false,
    border = "rounded",
}

win = vim.api.nvim_open_win(buf, true, opts)
vim.api.nvim_win_set_option(win, "winhighlight", 'Normal:Normal,FloatBorder:FloatBorder')
end

function View()
  vim.api.nvim_buf_set_option(buf, "modifiable", true)
  vim.api.nvim_command("e ~/.config/nvim/lua/plugin/todolist/checklist.md")
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
end


function ViewItems()
  Open_win()
  View()
end

function CloseView()
  vim.api.nvim_win_close(win, true)
end

function ToggleChecklist()
  if win==nil then
    vim.api.nvim_command(':lua ViewItems()')
  else
    vim.api.nvim_command(':up')
    vim.api.nvim_command(':lua CloseView()')
    win=nil
  end
end
