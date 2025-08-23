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

    -- Navigation with Hyper+hjkl (Ctrl+Alt) - works in normal and terminal modes
    -- This matches what tmux sends when vim is detected
    map(
      { "n", "t" },
      "<C-M-h>",
      function() require("smart-splits").move_cursor_left() end,
      { desc = "Move to left split (Hyper+h)" }
    )
    map(
      { "n", "t" },
      "<C-M-j>",
      function() require("smart-splits").move_cursor_down() end,
      { desc = "Move to lower split (Hyper+j)" }
    )
    map(
      { "n", "t" },
      "<C-M-k>",
      function() require("smart-splits").move_cursor_up() end,
      { desc = "Move to upper split (Hyper+k)" }
    )
    map(
      { "n", "t" },
      "<C-M-l>",
      function() require("smart-splits").move_cursor_right() end,
      { desc = "Move to right split (Hyper+l)" }
    )

    -- Resizing with Hyper+Arrows - Ctrl+Alt+Arrow keys
    map(
      "n",
      "<C-M-Left>",
      function() require("smart-splits").resize_left() end,
      { desc = "Resize split left (Hyper+←)" }
    )
    map(
      "n",
      "<C-M-Down>",
      function() require("smart-splits").resize_down() end,
      { desc = "Resize split down (Hyper+↓)" }
    )
    map("n", "<C-M-Up>", function() require("smart-splits").resize_up() end, { desc = "Resize split up (Hyper+↑)" })
    map(
      "n",
      "<C-M-Right>",
      function() require("smart-splits").resize_right() end,
      { desc = "Resize split right (Hyper+→)" }
    )
  end,
}
