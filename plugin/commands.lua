local startWin
local blameWin

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = "*",
  callback = function ()
    vim.o.formatoptions = 'jcrql'
  end
})

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = {'*.lua', '*.vue', '*.js', '*.vim', '*.blade.php', '*.rkt', "*.html", "*.css", "*.templ"},
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
    require('fzf-lua').files({cwd = "~/.config/nvim"})
end
, {})

vim.api.nvim_create_user_command('Trim', function ()
  vim.cmd('%s/\\s\\+$//e')
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
