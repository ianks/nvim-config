local save_mapping = { function() vim.cmd "w" end, desc = "Save file" }

return {
  {
    "AstroNvim/astrocore",
    dependencies = { "mrjones2014/smart-splits.nvim" },
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<leader>fs"] = { function() require("telescope.builtin").find_files() end, desc = "Find files" },
          ["<D-.>"] = { function() vim.lsp.buf.code_action() end, desc = "LSP Code Action" },
          ["<D-s>"] = save_mapping,
          ["K"] = { function() vim.lsp.buf.hover() end, desc = "Show hover documentation" },

          ["<C-h>"] = { function() require("smart-splits").move_cursor_left() end, desc = "Move left" },
          ["<C-j>"] = { function() require("smart-splits").move_cursor_down() end, desc = "Move down" },
          ["<C-k>"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move up" },
          ["<C-l>"] = { function() require("smart-splits").move_cursor_right() end, desc = "Move right" },

          ["<leader>ca"] = {
            desc = "LSP Code actions",
            function() vim.lsp.buf.code_action() end,
          },
        },
        i = {

          ["<D-s>"] = save_mapping,

          ["<C-h>"] = { function() require("smart-splits").move_cursor_left() end, desc = "Move left" },
          ["<C-j>"] = { function() require("smart-splits").move_cursor_down() end, desc = "Move down" },
          ["<C-k>"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move up" },
          ["<C-l>"] = { function() require("smart-splits").move_cursor_right() end, desc = "Move right" },
        },
        v = {
          ["<D-s>"] = save_mapping,
        },
      },
    },
  },
}
