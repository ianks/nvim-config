-- ianks-dev Neovim plugin - Development utilities and Editorial Warmth enhancements
-- Provides focus-aware dimming for inactive windows and test runner integration

local M = {}

M.setup = function()
  -- Initialize test runner with hardcoded settings
  require("ianks-dev.test-runner").setup()

  -- Set up focus dimming for tmux pane switching with dimmed highlight groups
  require("ianks-dev.focus-dimming").setup()

  -- Set up autocmd to clean up test pane on exit
  vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
      require("ianks-dev.tmux").cleanup()
    end,
  })
end

return M
