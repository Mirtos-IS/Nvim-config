local Job = require("plenary.job")
local M = {}

function M.get_project_dir()
  return M.get_root_dir() .. '-' .. M.get_current_git_branch()
end
function M.get_root_dir()
  return M.get_os_command_output({"git",  "rev-parse",  "--show-toplevel"})[1]
end

function M.get_current_git_branch()
  return M.get_os_command_output({"git", "branch", "--show-current"})[1]
end

function M.get_os_command_output(cmd, cwd)
    local command = table.remove(cmd, 1)
    local stderr = {}
    local stdout, ret = Job
        :new({
            command = command,
            args = cmd,
            cwd = cwd,
            on_stderr = function(_, data)
                table.insert(stderr, data)
            end,
        })
        :sync()
    return stdout, ret, stderr
end

return M
