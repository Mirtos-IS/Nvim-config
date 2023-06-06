local modules = require('lualine.components.branch.git_branch')

local function git_dir()
  local dir =  modules.find_git_dir()
  local gitDir = "/" .. dir:match('.(.*)/.git')
  local currentDir = vim.fn.expand('%:p')
  return currentDir:gsub(gitDir, "")
end

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
    lualine_b = {'branch', function() return git_dir() end, 'diagnostics'},
    lualine_c = {},
    lualine_x = {'diff', 'filetype'},
    lualine_y = {"os.date('%H:%M')"},
    lualine_z = {function () return 'C %c' end, function() return "L %l:%L " end}
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

--highlights
vim.g.termguicolors = true
require("catppuccin").setup({
  custom_highlights = function ()
    return {
      ['Normal'] = {bg='#000000'},
      ['NormalFloat'] = {bg='#000000'},
      ['NormalNC'] = {bg='#000000'},
      ['LineNr'] = {bg='none', fg='#757575'},
      ['CursorLine'] = {bg='#2a2b3c', fg='none'},
      ['EndOfBuffer'] = {bg='none', fg='#757575'},
      ['Directory'] = {bg='none'},
      ['NonText'] = {bg='none'},
      ['FoldColumn'] = {bg='none'},
      ['SignColumn'] = {bg='none', fg='none'},
      ['folded'] = {fg='#ba8d1a', bg='none'},
      ['WinSeparator'] = {bg='none', fg='#272727'},
      ['TreesitterContextLineNumber'] = {bg='#2a2b3c'},
      ['TreesitterContext'] = {bg='#2a2b3c'},
      ['PmenuSel'] = {bg='#646464', blend=0},

      --syntax highlight
      ['@parameter'] = {fg='#d1d7f0'},
      ['@variable'] = {fg='#d1d7f0'},
      ['@function.call'] = {fg=functionColor},
      ['@function'] = {fg=method},
      ['@method'] = {fg=method},
      ['@method.call'] = {fg=method},
      ['@method.call.php'] = {fg=method},
      ['@constructor'] = {fg=method},
      ['@variable.builtin'] = {fg=qualifier},

      --lua only
      ['@function.call.lua'] = {fg=method},

      --some misc ones
      ['ExtraWhiteSpace'] = {bg='darkred'},
      ['YankHighlight'] = {bg='#267683'},
      ['HighlightedyankRegion'] = {bg='white'},

      ['@keyword'] = {fg=keyword}
    }
  end
  -- color_override = {
  --   mirtoscin = {
  --     text = "#d8ddf2"
  --   }
  -- }
})
vim.cmd.colorscheme('catppuccin-mocha')
-- vim.api.nvim_set_hl(0, 'Normal', {bg='#000000'})
-- vim.api.nvim_set_hl(0, 'NormalFloat', {bg='#000000'})
-- vim.api.nvim_set_hl(0, 'NormalNC', {bg='#000000'})
-- vim.api.nvim_set_hl(0, 'LineNr', {bg='none', fg='#757575'})
-- vim.api.nvim_set_hl(0, 'CursorLine', {bg='#2a2b3c', fg='none'})
-- vim.api.nvim_set_hl(0, 'EndOfBuffer', {bg='none', fg='#757575'})
-- vim.api.nvim_set_hl(0, 'Directory', {bg='none'})
-- vim.api.nvim_set_hl(0, 'NonText', {bg='none'})
-- vim.api.nvim_set_hl(0, 'FoldColumn', {bg='none'})
-- vim.api.nvim_set_hl(0, 'SignColumn', {bg='none', fg='none'})
-- vim.api.nvim_set_hl(0, 'folded', {fg='#ba8d1a', bg='none'})
-- vim.api.nvim_set_hl(0, 'WinSeparator', {bg='none', fg='#272727'})
-- vim.api.nvim_set_hl(0, 'TreesitterContextLineNumber', {bg='#2a2b3c'})
-- vim.api.nvim_set_hl(0, 'TreesitterContext', {bg='#2a2b3c'})
-- -- vim.api.nvim_set_hl(0, 'FloatBorder', {bg = "#000000", fg='#1d99f3'})
-- vim.api.nvim_set_hl(0, "PmenuSel", {bg='#646464', blend=0})
--
-- --syntax highlight
-- vim.api.nvim_set_hl(0, "@parameter", {fg='#d8ddf2'})
-- vim.api.nvim_set_hl(0, "@variable", {fg='#d8ddf2'})
-- vim.api.nvim_set_hl(0, '@function.call', {fg=functionColor})
-- vim.api.nvim_set_hl(0, '@function', {fg=method})
-- vim.api.nvim_set_hl(0, '@method', {fg=method})
-- vim.api.nvim_set_hl(0, '@constructor', {fg=method})
-- vim.api.nvim_set_hl(0, '@variable.builtin', {fg=qualifier})
-- --
-- --lua only
-- vim.api.nvim_set_hl(0, '@function.call.lua', {fg=method})
-- -- vim.api.nvim_set_hl(0, '@lsp.type.method', {fg=method})
--
-- -- php only
-- vim.api.nvim_set_hl(0, '@method.php', {fg=method})
-- vim.api.nvim_set_hl(0, '@method.call.php', {fg=method})
--
-- --js only
-- vim.api.nvim_set_hl(0, '@method.call.javascript', {fg=method})
--
-- --some misc ones
-- vim.api.nvim_set_hl(0, 'ExtraWhiteSpace', {bg='darkred'})
-- vim.api.nvim_set_hl(0, 'YankHighlight', {bg='#267683'})
-- vim.api.nvim_set_hl(0, 'HighlightedyankRegion', {bg='white'})
--
-- --telescope
-- -- vim.api.nvim_set_hl(0, 'TelescopeBorder', {fg='#639ccf'})
--
-- -- vim.api.nvim_set_hl(0, "@operator", {fg='#CCCCCC'})
-- vim.api.nvim_set_hl(0, '@keyword', {fg=keyword})
-- -- vim.api.nvim_set_hl(0, '@keyword.return', {fg=keyword})
-- -- vim.api.nvim_set_hl(0, '@keyword.function', {fg=keyword})
-- -- vim.api.nvim_set_hl(0, '@include', {fg=qualifier})
-- -- vim.api.nvim_set_hl(0, '@type.qualifier', {fg=qualifier})
