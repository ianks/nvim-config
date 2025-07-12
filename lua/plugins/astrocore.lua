-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 },
      autopairs = true,
      cmp = true,
      diagnostics_mode = 3,
      highlighturl = true,
      notifications = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true,
        number = true,
        wrap = false,
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- Use Snacks.nvim picker (v5's replacement for Telescope)
        ["<leader>fs"] = { "<cmd>Snacks.picker.files()<cr>", desc = "Find files" },
        ["<D-s>"] = { "<cmd>w<cr>", desc = "Save file" },
      },
      i = { ["<D-s>"] = { "<cmd>w<cr>", desc = "Save file" } },
      v = { ["<D-s>"] = { "<cmd>w<cr>", desc = "Save file" } },
    },
  },
}
