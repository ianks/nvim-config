local save_mapping = { function() vim.cmd("w") end, desc = "Save file" }

return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          -- Telescope habits
          ["<leader>fs"] = { function() require("telescope.builtin").find_files() end, desc = "Find files" },

          -- VSCode habits
          ["<D-.>"] = { function() vim.lsp.buf.code_action() end, desc = "LSP Code Action" },
          ["<D-s>"] = save_mapping, -- Direct assignment in n mode
          
          ["K"] = { function() vim.lsp.buf.hover() end, desc = "Show hover documentation" },

          -- Tab navigation
          ["<C-h>"] = { function() vim.cmd("tabprevious") end, desc = "Previous tab" },
          ["<C-l>"] = { function() vim.cmd("tabnext") end, desc = "Next tab" },
          ["<C-j>"] = { function() vim.cmd("tabfirst") end, desc = "First tab" },
          ["<C-k>"] = { function() vim.cmd("tablast") end, desc = "Last tab" },
          
          -- Buffer navigation
          ["<A-h>"] = { function() vim.cmd("bprevious") end, desc = "Previous buffer" },
          ["<A-l>"] = { function() vim.cmd("bnext") end, desc = "Next buffer" },
          ["<A-j>"] = { function() vim.cmd("bfirst") end, desc = "First buffer" },
          ["<A-k>"] = { function() vim.cmd("blast") end, desc = "Last buffer" },
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
