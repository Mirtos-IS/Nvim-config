local blue = '#89B4FA'

local method = "#FAB387"
local functionColor = blue
local qualifier = "#F5C2E7"
local keyword = "#F5C2E7"

local function IsModified()
  return vim.fn.getbufinfo('%')[1].changed > 0
end

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
          if IsModified() then
            return {bg = '#FFAF00'}
          end
          return {bg = blue}
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

-- local method = "#dcdcaa"
-- local functionColor = "#4ec9b0"
-- local variable = "#5696c6"
-- local keyword = "#ce86c0"

--highlights
vim.g.termguicolors = true
vim.cmd.colorscheme('catppuccin-mocha')
vim.api.nvim_set_hl(0, 'Normal', {bg='#000000'})
vim.api.nvim_set_hl(0, 'NormalFloat', {bg='#000000'})
vim.api.nvim_set_hl(0, 'NormalNC', {bg='#000000'})
vim.api.nvim_set_hl(0, 'LineNr', {bg='none', fg='#757575'})
-- vim.api.nvim_set_hl(0, 'CursorLine', {bg='#202020', fg='none'})
vim.api.nvim_set_hl(0, 'EndOfBuffer', {bg='none', fg='#757575'})
vim.api.nvim_set_hl(0, 'Directory', {bg='none'})
vim.api.nvim_set_hl(0, 'NonText', {bg='none'})
vim.api.nvim_set_hl(0, 'FoldColumn', {bg='none'})
vim.api.nvim_set_hl(0, 'SignColumn', {bg='none', fg='none'})
vim.api.nvim_set_hl(0, 'folded', {fg='#ba8d1a', bg='none'})
vim.api.nvim_set_hl(0, 'WinSeparator', {bg='none', fg='#272727'})
-- vim.api.nvim_set_hl(0, 'FloatBorder', {bg = "#000000", fg='#1d99f3'})
vim.api.nvim_set_hl(0, "PmenuSel", {bg='#646464', blend=0})

--syntax highlight
vim.api.nvim_set_hl(0, "@parameter", {fg='#d8ddf2'})
vim.api.nvim_set_hl(0, "@variable", {fg='#d8ddf2'})
vim.api.nvim_set_hl(0, '@function.call', {fg=functionColor})
vim.api.nvim_set_hl(0, '@function', {fg=method})
vim.api.nvim_set_hl(0, '@method', {fg=method})
vim.api.nvim_set_hl(0, '@constructor', {fg=method})
vim.api.nvim_set_hl(0, '@variable.builtin', {fg=qualifier})
--
--lua only
vim.api.nvim_set_hl(0, '@function.call.lua', {fg=method})

-- php only
vim.api.nvim_set_hl(0, '@method.php', {fg=method})
vim.api.nvim_set_hl(0, '@method.call.php', {fg=method})

--some misc ones
vim.api.nvim_set_hl(0, 'ExtraWhiteSpace', {bg='darkred'})
vim.api.nvim_set_hl(0, 'YankHighlight', {bg='#267683'})
vim.api.nvim_set_hl(0, 'HighlightedyankRegion', {bg='white'})

--telescope
-- vim.api.nvim_set_hl(0, 'TelescopeBorder', {fg='#639ccf'})

-- vim.api.nvim_set_hl(0, "@operator", {fg='#CCCCCC'})
-- vim.api.nvim_set_hl(0, '@keyword', {fg=keyword})
-- vim.api.nvim_set_hl(0, '@keyword.return', {fg=keyword})
-- vim.api.nvim_set_hl(0, '@keyword.function', {fg=keyword})
-- vim.api.nvim_set_hl(0, '@include', {fg=qualifier})
-- vim.api.nvim_set_hl(0, '@type.qualifier', {fg=qualifier})
