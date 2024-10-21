vim.g.netrw_winsize = 10
vim.g.netrw_liststyle = 0
vim.g.netrw_keepdir = 0
vim.g.netrw_sizestyle = "H"

vim.g.netrw_localcopydircmd = "cp -r"
vim.g.netrw_localmkdir = "mkdir -p"
vim.g.netrw_localrmdir = "rm -r"

function Netrw_maps()
  if vim.bo.filetype ~= "netrw" then
    return
  end
  local opts = {silent=true, buffer=true}
  vim.keymap.set('', 'e', 'j', opts)
  vim.keymap.set('', 'o', 'k', opts)
  vim.keymap.set('', 'a', 'l', opts)
  vim.keymap.set('', 'n', 'h', opts)
  vim.keymap.set('', 'h', 'n', opts)
  vim.keymap.set('', 'H', 'N', opts)

  vim.keymap.set('', 'l', 'o', opts)

  vim.keymap.set('', '<leader>q', ':bd<cr>', opts)
end
