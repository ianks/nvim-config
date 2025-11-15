-- Override heirline statusline to support focus dimming
return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    -- Editorial Warmth dimmed colors matching tmux theme
    local DIM_BG = "#272624"  -- bg_dim from theme.yml
    local DIM_FG = "#b2afa9"  -- text_dim from theme.yml

    -- Store original hl function if it exists
    local original_hl = opts.statusline and opts.statusline.hl

    -- Override the statusline hl to check focus state
    if opts.statusline then
      opts.statusline.hl = function(self)
        -- Check if window has focus
        if vim.g.window_has_focus == false then
          -- Return dimmed colors
          return {
            fg = DIM_FG,
            bg = DIM_BG,
          }
        end

        -- If focused, use original hl function or default
        if type(original_hl) == "function" then
          return original_hl(self)
        elseif type(original_hl) == "table" then
          return original_hl
        else
          -- Fallback to default AstroNvim statusline colors
          return { fg = "fg", bg = "bg" }
        end
      end

      -- Add update field to trigger refresh on focus events
      opts.statusline.update = {
        "FocusGained",
        "FocusLost",
      }
    end

    return opts
  end,
}
