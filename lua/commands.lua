--autocommands
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  callback = function ()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end
})

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = {'*.lua', '*.vue', '*.js', '*.vim', '*.blade.php'},
  callback = function ()
    vim.opt_local.tabstop=2
    vim.opt_local.softtabstop=2
    vim.opt_local.shiftwidth=2
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
    require('telescope.builtin').nvim_files(require('telescope.themes').get_dropdown({winblend = 50}))
end
, {})

vim.api.nvim_create_user_command('Trim', function ()
  vim.cmd('%s/\\s\\+$//e')
end
, {})
