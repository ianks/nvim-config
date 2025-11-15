local M = {}

-- Editorial Warmth dimmed colors matching tmux theme
local DIM_BG = "#272624"  -- bg_dim from theme.yml
local DIM_FG = "#b2afa9"  -- text_dim from theme.yml

M.setup = function()
  -- Initialize global focus state (true = has focus)
  vim.g.window_has_focus = true

  -- Create augroup for focus events
  local group = vim.api.nvim_create_augroup("IanksFocusDimming", { clear = true })

  -- Dim window when focus is lost (switching to another tmux pane)
  vim.api.nvim_create_autocmd("FocusLost", {
    group = group,
    callback = function()
      vim.g.window_has_focus = false
      vim.wo.winhighlight = "Normal:NormalDim,NormalNC:NormalDim"
    end,
  })

  -- Restore normal colors when focus is gained
  vim.api.nvim_create_autocmd("FocusGained", {
    group = group,
    callback = function()
      vim.g.window_has_focus = true
      vim.wo.winhighlight = ""
    end,
  })

  -- Define dimmed highlight groups
  local function set_dim_highlights()
    vim.api.nvim_set_hl(0, "NormalDim", {
      fg = DIM_FG,
      bg = DIM_BG,
    })
  end

  -- Apply on colorscheme change
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = group,
    callback = set_dim_highlights,
  })

  -- Set the highlight groups immediately on setup
  set_dim_highlights()
end

return M
