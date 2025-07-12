return {
  "mrjones2014/smart-splits.nvim",
  lazy = false,
  keys = {
    -- Navigation (works in normal and terminal modes)
    {
      "<C-h>",
      function() require("smart-splits").move_cursor_left() end,
      desc = "Move to left split",
      mode = { "n", "t" },
    },
    {
      "<C-j>",
      function() require("smart-splits").move_cursor_down() end,
      desc = "Move to lower split",
      mode = { "n", "t" },
    },
    {
      "<C-k>",
      function() require("smart-splits").move_cursor_up() end,
      desc = "Move to upper split",
      mode = { "n", "t" },
    },
    {
      "<C-l>",
      function() require("smart-splits").move_cursor_right() end,
      desc = "Move to right split",
      mode = { "n", "t" },
    },

    -- Resizing
    { "<M-h>", function() require("smart-splits").resize_left() end, desc = "Resize split left" },
    { "<M-j>", function() require("smart-splits").resize_down() end, desc = "Resize split down" },
    { "<M-k>", function() require("smart-splits").resize_up() end, desc = "Resize split up" },
    { "<M-l>", function() require("smart-splits").resize_right() end, desc = "Resize split right" },
  },
  opts = {
    ignored_filetypes = { "nofile", "quickfix", "prompt" },
    ignored_buftypes = { "nofile" },
  },
}
