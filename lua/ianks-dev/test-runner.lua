local M = {}
local tmux = require("ianks-dev.tmux")
local dev_transform = require("ianks-dev.dev-transform")

-- Custom vim-test strategy with proper error handling
M.strategy = function(cmd)
  local success, err = pcall(function()
    local pane = tmux.get_or_create_test_pane()
    -- Clear is now integrated into send_to_pane for optimal performance
    tmux.send_to_pane(pane, cmd)
  end)
  
  if not success then
    vim.notify("ianks-dev test runner error: " .. err, vim.log.levels.ERROR)
  end
end

M.setup = function()
  -- Register custom strategy with vim-test
  vim.g["test#custom_strategies"] = {
    ianks = M.strategy
  }
  vim.g["test#strategy"] = "ianks"
  
  -- Register dev transformation for Ruby tests
  vim.g["test#custom_transformations"] = {
    shopify_dev = dev_transform.transform
  }
  
  -- Enable the transformation
  vim.g["test#transformation"] = "shopify_dev"
end

return M