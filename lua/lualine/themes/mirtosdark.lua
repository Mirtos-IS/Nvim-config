local colors = {
  gray     = '#181825',
  lightred = '#D16969',
  blue     = '#89B4FA',
  pink     = '#C586C0',
  black    = '#181825',
  white    = '#D4D4D4',
  green    = '#608B4E',
  yellow   = '#FFAF00',
}

return {
  normal = {
    a = { fg = colors.black, bg = colors.blue, gui = 'bold' },
    b = { fg = colors.yellow, bg = colors.black },
    c = { fg = colors.white, bg = colors.black },
  },
  visual = {
    a = { fg = colors.black, bg = colors.pink, gui = 'bold' },
    b = { fg = colors.pink, bg = colors.black },
  },
  inactive = {
    a = { fg = colors.white, bg = colors.gray, gui = 'bold' },
    b = { fg = colors.green, bg = colors.black },
  },
  replace = {
    a = { fg = colors.black, bg = colors.lightred, gui = 'bold' },
    b = { fg = colors.lightred, bg = colors.black },
    c = { fg = colors.white, bg = colors.black },
  },
  insert = {
    a = { fg = colors.black, bg = colors.yellow, gui = 'bold' },
    b = { fg = colors.yellow, bg = colors.black },
    c = { fg = colors.white, bg = colors.black },
  },
  command = {
    a = { fg = colors.black, bg = colors.green, gui = 'bold' },
    b = { fg = colors.green, bg = colors.black },
    c = { fg = colors.white, bg = colors.black },
  },
}
