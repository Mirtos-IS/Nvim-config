require("scope").setup()

local theme = require("lualine.themes.mirtosdark")
require("lualine").setup{
  options = {
    theme = theme,
    globalstatus = true,
  },

  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', {'filename', symbols = {modified = ''}}, 'diagnostics'},
    lualine_c = {"require'nvim-treesitter'.statusline({separator = ' > ', type_patterns = {'function', 'method'}, indication = 60})"},
    lualine_x = {'filetype'},
    lualine_y = {"os.date('%H:%M')"},
    lualine_z = {'location', function() return "lines :" ..  vim.api.nvim_buf_line_count(0) end}
  },
  tabline = {
    lualine_a = {{
      'buffers',
      buffers_color = {
        active = function ()
          if vim.api.nvim_call_function("IsModified", {}) > 0 then
            return {bg = '#FFAF00'}
          end
          return {bg = '#428CD6'}
        end
      },
      symbols = {
        alternate_file = '',
      }
    }},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {'tabs'},
  }
}

--highlights
vim.cmd("set termguicolors")
vim.cmd("colorscheme codedark")
vim.api.nvim_set_hl(0, 'Normal', {bg='#000000'})
vim.api.nvim_set_hl(0, 'LineNr', {bg='none', fg='#757575'})
vim.api.nvim_set_hl(0, 'CursorLine', {bg='#101010', fg='none'})
vim.api.nvim_set_hl(0, 'EndOfBuffer', {bg='none', fg='#757575'})
vim.api.nvim_set_hl(0, 'Directory', {bg='none'})
vim.api.nvim_set_hl(0, 'NonText', {bg='none'})
vim.api.nvim_set_hl(0, 'FoldColumn', {bg='none'})
vim.api.nvim_set_hl(0, 'SignColumn', {bg='none', fg='none'})
vim.api.nvim_set_hl(0, 'folded', {fg='#ba8d1a', bg='none'})
vim.api.nvim_set_hl(0, 'WinSeparator', {bg='none', fg='#272727'})
vim.api.nvim_set_hl(0, 'FloatBorder', {fg='#1d99f3'})
vim.api.nvim_set_hl(0, "PmenuSel", {bg='#646464', blend=0})
vim.api.nvim_set_hl(0, '@keyword', {fg='#ce86c0'})
vim.api.nvim_set_hl(0, '@keyword.function', {fg='#ce86c0'})
vim.api.nvim_set_hl(0, '@include', {fg='#5696c6'})
vim.api.nvim_set_hl(0, '@type.qualifier', {fg='#5696c6'})
vim.api.nvim_set_hl(0, '@function.call', {fg='#4ec9b0'})
vim.api.nvim_set_hl(0, '@constructor', {fg='#dcdcaa'})
vim.api.nvim_set_hl(0, '@variable.builtin', {fg='#5696c6'})

--lua only
vim.api.nvim_set_hl(0, '@function.call.lua', {fg='#dcdcaa'})

--some misc ones
vim.api.nvim_set_hl(0, 'ExtraWhiteSpace', {bg='darkred'})
vim.api.nvim_set_hl(0, 'YankHighlight', {bg='#267683'})
vim.api.nvim_set_hl(0, 'HighlightedyankRegion', {bg='white'})

--telescope
vim.api.nvim_set_hl(0, 'TelescopeBorder', {fg='#639ccf'})
