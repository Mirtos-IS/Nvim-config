local modules = require('lualine.components.branch.git_branch')
local startWin
local blameWin
local sessionPath = "~/.config/nvim/sessions/"

local function getSessionName()
  return pcall(function()
    local dir =  modules.find_git_dir()
    if dir == nil then
      return
    end

    local gitDir = dir:match('.(.*)/.git')
    local projectName = gitDir:gsub('.*/', "")

    local currentBranch = modules.get_branch()

    return "." .. projectName .. "-" .. currentBranch .. ".vim"
  end)
end
--autocommands
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  callback = function ()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end
})

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = {'*.lua', '*.vue', '*.js', '*.vim', '*.blade.php', '*.rkt', "*.html", "*.css"},
  callback = function ()
    vim.opt_local.tabstop=2
    vim.opt_local.softtabstop=2
    vim.opt_local.shiftwidth=2
  end
})

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = 'COMMIT_EDITMSG',
  callback = function ()
    vim.keymap.set({'n', 'i'}, '<C-S>', '<cmd>wq<CR>', {silent=true, buffer=true})
  end
})

vim.api.nvim_create_autocmd('WinEnter', {
  pattern = '*',
  callback = function ()
    local ui = vim.api.nvim_list_uis()[1]
    local width = ui.width
    if vim.api.nvim_win_get_config(0).zindex == nil then
      if width > 140 then
        vim.o.winwidth = math.floor(width/2)
      else
        vim.o.winwidth = math.floor(width * 2/3)
      end
      vim.cmd('wincmd =')
    end

  end
})

vim.api.nvim_create_autocmd('WinClosed', {
  pattern = '*',
  callback = function ()
    if startWin == nil then
      return
    end
    vim.api.nvim_win_set_option(startWin, "cursorbind", false)
    vim.api.nvim_win_set_option(startWin, "scrollbind", false)
    startWin = nil
  end
})

vim.api.nvim_create_autocmd('FocusGained', {
  pattern = '*',
  callback = function ()
    local ui = vim.api.nvim_list_uis()[1]
    local width = ui.width
    if vim.api.nvim_win_get_config(0).zindex == nil then
      if width > 140 then
        vim.o.winwidth = math.floor(width/2)
      else
        vim.o.winwidth = math.floor(width * 2/3)
      end
    vim.cmd('wincmd =')
    end

  end
})

vim.api.nvim_create_autocmd('VimLeavePre', {
  pattern = '*',
  callback = function ()
    pcall(function()
      vim.cmd("SaveSession")
    end)
  end
})

vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  callback = function ()
    vim.highlight.on_yank {higroup="YankHighlight", timeout=70}
  end
})

vim.api.nvim_create_autocmd('InsertEnter', {
  pattern = '*',
  callback = function ()
    vim.fn.clearmatches()
  end
})

vim.api.nvim_create_autocmd('InsertLeave', {
  pattern = '*',
  callback = function ()
    vim.fn.matchadd('ExtraWhiteSpace', '\\s\\+$')
  end
})

--user commands
vim.api.nvim_create_user_command('MyConfig', function ()
    require('telescope.builtin').nvim_files(require('telescope.themes').get_dropdown({winblend = 50}))
end
, {})

vim.api.nvim_create_user_command('Trim', function ()
  vim.cmd('%s/\\s\\+$//e')
end
, {})

vim.api.nvim_create_user_command('GoRun', function ()
  local filename = vim.fn.expand('%:t')
  vim.cmd(string.format("TermExec cmd='go run %s'", filename))
end
, {})

vim.api.nvim_create_user_command('GBlame', function ()
  if blameWin == nil then
    startWin = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_option(0, "cursorbind", true)
    vim.api.nvim_win_set_option(0, "scrollbind", true)
    vim.cmd "normal! zz"
    vim.cmd("Git blame")
    blameWin = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_option(0, "cursorbind", true)
    vim.api.nvim_win_set_option(0, "scrollbind", true)
    vim.cmd "normal! zz"
    vim.cmd("wincmd l")
  else
    startWin = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_option(startWin, "cursorbind", false)
    vim.api.nvim_win_set_option(startWin, "scrollbind", false)
    vim.api.nvim_win_close(blameWin, false)
    blameWin = nil
  end
end, {})

vim.api.nvim_create_user_command('SaveSession', function()
  pcall(function()
      local ok, filename = getSessionName()
      if ok == false then
        return
      end
      vim.cmd("silent mksession! " .. sessionPath .. filename)
  end)
end, {})

vim.api.nvim_create_user_command('LoadSession', function()
  pcall(function()
    local ok, filename = getSessionName()
    if ok == false then
      return
    end
    vim.cmd("silent so " .. sessionPath .. filename)
  end)
end, {})
