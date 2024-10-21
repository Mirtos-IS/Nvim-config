require("nvim-autopairs").setup {
  ignored_next_char = [=[[%w%%%'%[%"%.$&]]=],
  enable_check_bracket_line = false,
  map_c_h = true,
  map_c_w = true,
  fast_wrap = {
    map = '<M-e>'
  },
}

vim.notify = require("notify")

require 'colorizer'.setup({
{ "css", "javascript", "lua", "vim", "toml", "typescript", "conf", "vue", "templ" },
 user_default_options = {
    mode = "virtualtext"
  }
})

require('gitblame').setup({
  enabled = false,
  delay = 0
})

require('harpoon').setup({
  global_settings = {
    mark_branch = true,
  },
  menu = {
      width = math.floor(vim.api.nvim_win_get_width(0)/2),
  }

})

require('nvim-tmux-navigation').setup({})
