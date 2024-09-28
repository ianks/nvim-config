return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          -- -- File mappings
          ["<leader>fs"] = { function() require("telescope.builtin").find_files() end, desc = "Find files" },
        },
      },
    },
  },
}
