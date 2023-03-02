local buf, win

--checklist
function Open_win(win_h, win_w, style)
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
    style = style or '',
    width = win_width,
    height = win_height,
    anchor = 'NW',
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


--todolist

function ViewList()
  Open_win(20, 80, 'minimal')
  ViewTodoList()
end

function ToggleTodolist()
  if win==nil then
    vim.api.nvim_command(':lua ViewList()')
  else
    vim.api.nvim_command(':up')
    vim.api.nvim_command(':lua CloseView()')
    win=nil
  end
end

function ViewTodoList()
  vim.api.nvim_buf_set_option(buf, "modifiable", true)
  vim.api.nvim_command("e ~/.config/nvim/lua/plugin/todolist/todolist.md")
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
end
