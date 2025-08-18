return {
  "mrjones2014/smart-splits.nvim",
  lazy = false, -- IMPORTANT: Required for tmux integration
  priority = 1000, -- Load early for tmux integration
  config = function()
    -- Setup smart-splits
    require("smart-splits").setup {
      ignored_filetypes = { "nofile", "quickfix", "prompt" },
      ignored_buftypes = { "nofile" },
      -- Cursor follows focused window when moving
      cursor_follows_swapped_bufs = true,
      -- Resize mode options
      resize_mode = {
        -- Quit resize mode with ESC
        quit_key = "ESC",
        -- Resize keys
        resize_keys = { "h", "j", "k", "l" },
        -- Set to false to show notifications
        silent = true,
      },
      -- Multiplexer integration (auto-detected, but we can specify tmux)
      -- The plugin will automatically detect tmux via TMUX env variable
      default_amount = 3,
      -- Disable multiplexer navigation when zoomed
      disable_multiplexer_nav_when_zoomed = true,
    }

    -- Set up keymaps after plugin loads
    local map = vim.keymap.set

    -- Navigation with Option+hjkl (works in normal and terminal modes)
    map(
      { "n", "t" },
      "<M-h>",
      function() require("smart-splits").move_cursor_left() end,
      { desc = "Move to left split" }
    )
    map(
      { "n", "t" },
      "<M-j>",
      function() require("smart-splits").move_cursor_down() end,
      { desc = "Move to lower split" }
    )
    map(
      { "n", "t" },
      "<M-k>",
      function() require("smart-splits").move_cursor_up() end,
      { desc = "Move to upper split" }
    )
    map(
      { "n", "t" },
      "<M-l>",
      function() require("smart-splits").move_cursor_right() end,
      { desc = "Move to right split" }
    )

    -- Resizing with Alt+HJKL (uppercase) - from Cmd+Shift+hjkl
    map("n", "<M-H>", function() require("smart-splits").resize_left() end, { desc = "Resize split left" })
    map("n", "<M-J>", function() require("smart-splits").resize_down() end, { desc = "Resize split down" })
    map("n", "<M-K>", function() require("smart-splits").resize_up() end, { desc = "Resize split up" })
    map("n", "<M-L>", function() require("smart-splits").resize_right() end, { desc = "Resize split right" })

    -- Also keep Option+Shift+hjkl as fallback
    map("n", "<M-S-h>", function() require("smart-splits").resize_left() end, { desc = "Resize split left" })
    map("n", "<M-S-j>", function() require("smart-splits").resize_down() end, { desc = "Resize split down" })
    map("n", "<M-S-k>", function() require("smart-splits").resize_up() end, { desc = "Resize split up" })
    map("n", "<M-S-l>", function() require("smart-splits").resize_right() end, { desc = "Resize split right" })
  end,
}
