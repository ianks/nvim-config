return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      {
        "<C-`>",
        function() require("toggleterm").toggle() end,
        desc = "Toggle terminal",
        mode = { "n", "t" },
      },
    },
    opts = {
      direction = "float",
      float_opts = {
        border = "curved",
      },
    },
  },
}
