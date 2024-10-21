require("custom_plugins.test-results.php")

vim.o.commentstring="// %s"
--test maping
vim.opt.iskeyword:append('$,@,#')

vim.keymap.set('n', '<leader>tf', '<cmd>SailTestCurrentMethod v<CR>', {silent=true})
vim.keymap.set('n', '<leader>ta', '<cmd>SailRunTest v<CR>', {silent=true})

vim.keymap.set('n', '<leader>st', '<cmd>SailTinker<CR>', {silent=true})
