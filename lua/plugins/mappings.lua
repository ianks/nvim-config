local save_mapping = { function() vim.cmd("w") end, desc = "Save file" }

return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<leader>fs"] = { function() require("telescope.builtin").find_files() end, desc = "Find files" },
          ["<D-.>"] = { function() vim.lsp.buf.code_action() end, desc = "LSP Code Action" },
          ["<D-s>"] = save_mapping, -- Direct assignment in n mode
          ["<leader>tn"] = { function() vim.cmd("TestNearest") end, desc = "Test nearest" },
          ["<leader>tf"] = { function() vim.cmd("TestFile") end, desc = "Test file" },
          ["<leader>ts"] = { function() vim.cmd("TestSuite") end, desc = "Test suite" },
          ["K"] = { function() vim.lsp.buf.hover() end, desc = "Show hover documentation" },
        },
        i = {
          ["<D-s>"] = save_mapping, -- Use the variable in insert mode
        },
        v = { -- visual mode
          ["<D-s>"] = save_mapping, -- Use the variable in visual mode
        },
      },
    },
  },
}
