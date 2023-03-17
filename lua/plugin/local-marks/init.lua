local Path = require("plenary.path")
local mark_path = "/home/mirtos/.config/nvim/lua/plugin/local-marks/marks/marks.json"
local M = {}

function M.setup(config)
  config = config or {}
end

function M.save()
    M.refresh_projects_b4update()

    Path:new(mark_path):write(vim.fn.json_encode(mark_config), "w")
end
