local colors = {
  gray       = '#7f849c',
  lightred   = '#D16969',
  blue       = '#89B4FA',
  pink       = '#C586C0',
  lightPink  = '#F5C2E7',
  black      = '#181825',
  white      = '#D4D4D4',
  green      = '#a6da95',
  yellow     = '#FFAF00',
  orange     = '#FAB387',
  lavander   = '#B4BEFE',
}

local method = colors.orange
local functionColor = colors.blue
local qualifier = colors.lightPink
local keyword = colors.lightPink

require("scope").setup()

--highlights
vim.g.termguicolors = true
require("catppuccin").setup({
  integrations = {
    fzf = false,
    harpoon = false
  },
  custom_highlights = function ()
    return {
      ['Normal'] = {bg='none'},
      ['NormalFloat'] = {bg='none'},
      ['NormalNC'] = {bg='none'},
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
      ['NotifyBackground'] = {bg='#000000', blend=0},

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

      --vue/html only
      ['@punctuation.special'] = {fg='#d1d7f0'},

      --some misc ones
      ['ExtraWhiteSpace'] = {bg='darkred'},
      ['YankHighlight'] = {bg='#267683'},
      ['HighlightedyankRegion'] = {bg='white'},

      ['@keyword'] = {fg=keyword}
    }
  end
})
vim.cmd.colorscheme('catppuccin-mocha')

vim.api.nvim_set_hl(0, 'StatuslineModeNormal', { fg = colors.black, bg = colors.green, bold=true })
vim.api.nvim_set_hl(0, 'StatuslineModeInsert', { fg = colors.black, bg = colors.yellow, bold=true })
vim.api.nvim_set_hl(0, 'StatuslineModeVisual', { fg = colors.black, bg = colors.pink, bold=true })
vim.api.nvim_set_hl(0, 'StatuslineModeReplace', { fg = colors.black, bg = colors.lightred, bold=true })
vim.api.nvim_set_hl(0, 'StatuslineModeCommand', { fg = colors.black, bg = colors.blue, bold=true })

-- vim.api.nvim_set_hl(0, 'StatuslineModeNormalInactive', { fg = colors.green, bg = colors.black, bold=true })
-- vim.api.nvim_set_hl(0, 'StatuslineModeInsertInactive', { fg = colors.yellow, bg = colors.black, bold=true })
-- vim.api.nvim_set_hl(0, 'StatuslineModeVisualInactive', { fg = colors.pink, bg = colors.black, bold=true })
-- vim.api.nvim_set_hl(0, 'StatuslineModeReplaceInactive', { fg = colors.lightred, bg = colors.black, bold=true })
-- vim.api.nvim_set_hl(0, 'StatuslineModeCommandInactive', { fg = colors.blue, bg = colors.black, bold=true })

vim.api.nvim_set_hl(0, 'StatuslineMain', { fg = colors.black, bg = colors.green, bold=true })
vim.api.nvim_set_hl(0, 'StatuslineSecond', { fg = colors.green, bg = colors.black, bold=true })
vim.api.nvim_set_hl(0, 'StatuslineThird', { fg = colors.orange, bg = colors.black, bold=true })

vim.api.nvim_set_hl(0, 'StatuslineInactive', { fg = colors.gray, bg = colors.black, bold=true })

vim.api.nvim_set_hl(0, 'StatuslineSeparator', { fg = colors.white, bg = colors.black, bold=true })

local function modeColor(current_mode)
  local higroup = "%#StatuslineModeCommand#"
  if current_mode == "n" then
    higroup = "%#StatuslineModeNormal#"
  elseif current_mode == "i" or current_mode == "ic" then
    higroup = "%#StatuslineModeInsert#"
  elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
    higroup = "%#StatuslineModeVisual#"
  elseif current_mode == "R" or current_mode == "Rv" then
    higroup = "%#StatuslineModeReplace#"
  elseif current_mode == "s" or current_mode == "S" or current_mode == "␓" then
    higroup = "%#StatuslineModeSelect#"
  elseif current_mode == "c" then
    higroup = "%#StatuslineModeCommand#"
  end
  return higroup
end

-- local function modeColorInactive()
--   local current_mode = vim.api.nvim_get_mode().mode
--
--   local higroup = "%#StatuslineModeCommandInactive#"
--   if current_mode == "n" then
--     higroup = "%#StatuslineModeNormalInactive#"
--   elseif current_mode == "i" or current_mode == "ic" then
--     higroup = "%#StatuslineModeInsertInactive#"
--   elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
--     higroup = "%#StatuslineModeVisualInactive#"
--   elseif current_mode == "R" or current_mode == "Rv" then
--     higroup = "%#StatuslineModeReplaceInactive#"
--   elseif current_mode == "s" or current_mode == "S" or current_mode == "␓" then
--     higroup = "%#StatuslineModeSelectInactive#"
--   elseif current_mode == "c" then
--     higroup = "%#StatuslineModeCommandInactive#"
--   end
--   return higroup
-- end

local function getMode()
  local modes = {
    ["n"] = "NORMAL",
    ["no"] = "NORMAL",
    ["i"] = "INSERT",
    ["ic"] = "INSERT",
    ["v"] = "VISUAL",
    ["V"] = "V-LINE",
    [""] = "V-BLOCK",
    ["s"] = "SELECT",
    ["S"] = "S-LINE",
    ["␓"] = "S-BLOCK",
    ["R"] = "REPLACE",
    ["Rv"] = "V-REPLACE",
    ["c"] = "COMMAND",
    ["cv"] = "VIM EX",
    ["ce"] = "EX",
    ["r"] = "PROMPT",
    ["rm"] = "MOAR",
    ["r?"] = "CONFIRM",
    ["!"] = "SHELL",
    ["t"] = "TERMINAL",
    ["niI"] = "INS-NOR",
  }
  local current_mode = vim.api.nvim_get_mode().mode
  local value = ""


  if modes[current_mode] == nil then
    value = "UNKNOWN"
  else
    value = modes[current_mode]
  end
  return modeColor(current_mode) .. ' ' .. value .. ' '
end


-- local arrowLeft = '🭮'
-- local arrowRight = '🭬'

local function separatorLeft()
  return '%#StatuslineSeparator#' .. '| '
end

local function separatorRight()
  return '%#StatuslineSeparator#' .. '| '
end

local function shouldHide(winnr)
  local is_floating = '' ~= vim.api.nvim_win_get_config(winnr).relative

  return is_floating
end

local function buffers()
  local tabnr = vim.api.nvim_get_current_tabpage()
  local openBuffers = ''

  for _, winnr in ipairs(vim.api.nvim_tabpage_list_wins(tabnr)) do
    if not shouldHide(winnr) then
      local bufnr = vim.api.nvim_win_get_buf(winnr)
      local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ':t')

      if openBuffers ~= '' then
        openBuffers = openBuffers .. separatorRight()
      end

      if winnr == vim.api.nvim_get_current_win() then
        openBuffers = openBuffers .. '%#StatuslineSecond#' .. filename .. ' '
      else
        openBuffers = openBuffers .. '%#StatuslineInactive#' .. filename .. ' '
      end
    end
  end

  return openBuffers
end

local function getColumn()
  local isVisualMode = vim.fn.mode():find("[Vv]")
  if not isVisualMode then return "%c" end
  local wc = vim.fn.wordcount()
  return wc.visual_chars
end

function Statusline()
  local set_color_main = "%#StatuslineMain#"
  local set_color_sec = "%#StatuslineSecond#"
  local set_color_third = "%#StatuslineThird#"
  local branch = getMode()
  local file_name = buffers()

  local modified = "%m"
  local align_right = "%="
  local filetype = " %{&filetype} " .. separatorLeft()
  local date = os.date('%H:%M') .. " "
  local column = " Col ".. getColumn()
  local linecol = " L %l:%L "

  return string.format(
    "%s%s %s%s %s%s%s%s%s%s%s%s",
    branch,
    set_color_sec,
    file_name,
    modified,
    align_right,
    set_color_third,
    filetype,
    set_color_sec,
    date,
    set_color_main,
    column,
    linecol
  )
end

vim.o.statusline = '%!v:lua.Statusline()'
