local oldDir, newDir
require("fzf-lua").setup({
  winopts = {
    preview = {
      horizontal = 'right:50%',
    },
    on_close = function()
      if newDir == nil or newDir == oldDir then
        newDir = nil
        oldDir = nil
      else
        oldDir = newDir
      end
    end,
  },
  fzf_opts = {
    ["--layout"]         = "default",
  },
  files = {
    git_icons = false,
  },
  actions = {
    true,
    files = {
    git_icons = false,
      true,
      ["LEFT"] = function ()
        oldDir = oldDir or vim.fn.expand("%:p:h")
        newDir = vim.fn.fnamemodify(oldDir, ":p:h:h")
        require("fzf-lua").files({cwd = newDir})
      end
    },
  },
  grep = {
    actions = {
      ["LEFT"] = function ()
        oldDir = oldDir or vim.fn.expand("%:p:h")
        newDir = vim.fn.fnamemodify(oldDir, ":p:h:h")
        require("fzf-lua").live_grep({cwd = newDir})
      end
    }
  },
  previewers = {
    builtin = {
      extensions = {
        ["png"]       = { "viu", "-b" },
        ["jpg"]       = { "viu", "-b" },
      }
    }
  }
})
