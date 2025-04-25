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

          -- Buffer navigation (changed from Alt to Ctrl)
          ["<C-h>"] = { function() vim.cmd("bprevious") end, desc = "Previous buffer" },
          ["<C-l>"] = { function() vim.cmd("bnext") end, desc = "Next buffer" },
          ["<C-j>"] = { function() vim.cmd("bfirst") end, desc = "First buffer" },
          ["<C-k>"] = { function() vim.cmd("blast") end, desc = "Last buffer" },

          -- Disable default close buffer mapping
          ["<leader>ca"] = {
            desc = "LSP Code actions",
            function()
              vim.lsp.buf.code_action()
            end,
          },

          -- -- Tab navigation (changed from Ctrl to Alt)
          -- ["<A-h>"] = { function() vim.cmd("tabprevious") end, desc = "Previous tab" },
          -- ["<A-l>"] = { function() vim.cmd("tabnext") end, desc = "Next tab" },
          -- ["<A-j>"] = { function() vim.cmd("tabfirst") end, desc = "First tab" },
          -- ["<A-k>"] = { function() vim.cmd("tablast") end, desc = "Last tab" },
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
