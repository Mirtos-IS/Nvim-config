local bufnr = -1
local win = -1
local job_id

vim.api.nvim_create_user_command("SailRunTest", function()
  local file_name = vim.fn.expand('%:t')
  local is_php_test = string.find(file_name, '.*Test.php')
  if is_php_test == nil then
    print('This is not a php file')
    return
  end
  local file_dir = GetTestFileDir()
  OpenTerminal()
  UseCommands(file_dir)
  vim.cmd('wincmd k')
end,{})

function OpenTerminal()
  local is_open = vim.fn.bufwinnr(bufnr)
  if is_open < 0 then
    if bufnr > -1 then
      vim.api.nvim_buf_delete(bufnr, {force=true})
    end
    vim.cmd('split | term')
    vim.cmd('sleep 500m')
    bufnr = vim.api.nvim_get_current_buf()
    win = vim.api.nvim_get_current_win()
    job_id = vim.b.terminal_job_id
    vim.api.nvim_chan_send(job_id, 'cd $WORK\n')
    vim.o.bl = false
  end
  vim.api.nvim_chan_send(job_id, 'reset\n')
end

function UseCommands(file_dir)
  local cmd = 'sail test '
  vim.api.nvim_chan_send(job_id, cmd..file_dir..'\n')
end

function GetTestFileDir()
  local file_full_dir = vim.fn.expand('%:p')
  local file_test_dir = string.gsub(file_full_dir, '.*tests', 'tests')
  return file_test_dir
end

vim.api.nvim_create_user_command("SailCloseTest",function()
  if win > 0 then
    CloseTerminal()
    return
  end
  print('No terminal opened')
end,{})

function CloseTerminal()
  vim.api.nvim_win_close(win, true)
  vim.api.nvim_buf_delete(bufnr, {force=true})
  bufnr = -1
  win = -1
end
