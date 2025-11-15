local M = {}

M.setup = function()
  -- Initialize test runner with hardcoded settings
  require("ianks-dev.test-runner").setup()

  -- Set up focus dimming for tmux pane switching
  require("ianks-dev.focus-dimming").setup()

  -- Set up autocmd to clean up test pane on exit
  vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
      require("ianks-dev.tmux").cleanup()
    end,
  })
end

return M