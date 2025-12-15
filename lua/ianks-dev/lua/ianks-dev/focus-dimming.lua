-- focus-dimming.lua - Dim Neovim window highlights when losing focus to another tmux pane
-- Applies dimmed highlight groups (DimCursorLine, DimVisual, etc.) to inactive windows
-- allowing the Editorial Warmth theme to feel consistently dimmed across panes

local M = {}

-- Dimmed highlight mapping for inactive windows
-- Maps active highlight groups to their dimmed variants (defined in Editorial colorscheme)
local DIM_HIGHLIGHTS = {
  -- Main window appearance (most important!)
  "Normal:DimNormal",
  "NormalFloat:DimNormalFloat",

  -- UI elements
  "LineNr:DimLineNr",
  "SignColumn:DimSignColumn",
  "EndOfBuffer:DimEndOfBuffer",
  "VertSplit:DimVertSplit",
  "Folded:DimFolded",
  "StatusLineNC:DimStatusLineNC",

  -- Cursor and selection
  "CursorLine:DimCursorLine",
  "CursorLineNr:DimCursorLineNr",
  "Visual:DimVisual",
  "Search:DimSearch",
  "IncSearch:DimIncSearch",
}

M.setup = function()
  -- Create augroup for focus events
  local group = vim.api.nvim_create_augroup("NeovimFocusDimming", { clear = true })

  -- On window enter (focus gained), restore bright highlights
  vim.api.nvim_create_autocmd("WinEnter", {
    group = group,
    callback = function()
      -- Clear winhighlight to restore default (bright) highlights
      vim.opt_local.winhighlight = ""
    end,
  })

  -- On window leave (focus lost), apply dimmed highlights
  vim.api.nvim_create_autocmd("WinLeave", {
    group = group,
    callback = function()
      -- Build the winhighlight string from our dim mapping
      local winhighlight = table.concat(DIM_HIGHLIGHTS, ",")
      vim.opt_local.winhighlight = winhighlight
    end,
  })

  -- On tmux pane focus lost (switching to another tmux pane), dim ALL windows
  vim.api.nvim_create_autocmd("FocusLost", {
    group = group,
    callback = function()
      -- Dim all windows when entire nvim pane loses focus
      local winhighlight = table.concat(DIM_HIGHLIGHTS, ",")
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        vim.api.nvim_win_set_option(win, "winhighlight", winhighlight)
      end
    end,
  })

  -- On tmux pane focus gained (switching back to nvim pane), restore current window
  vim.api.nvim_create_autocmd("FocusGained", {
    group = group,
    callback = function()
      -- Restore highlights for current window only
      -- Other windows remain dimmed (handled by WinEnter/WinLeave)
      vim.opt_local.winhighlight = ""
    end,
  })
end

return M
