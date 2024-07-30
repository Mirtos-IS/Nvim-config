vim.o.makeprg = 'make all && ./platfighter'

vim.api.nvim_create_autocmd('QuickFixCmdPre', {
  pattern = '*',
  callback = function ()
    vim.cmd('cd /home/mirtos/GitRepos/platfighter/src/')
  end
})
