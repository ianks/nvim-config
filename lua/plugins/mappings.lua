local save_mapping = { function() vim.cmd("w") end, desc = "Save file" }

return {
  {
    "AstroNvim/astrocore",
    dependencies = { "mrjones2014/smart-splits.nvim" },
    ---@type AstroCoreOpts
    opts = function(_, opts)
      local smart_splits = require("smart-splits")
      local avante_api = require("avante.api")

      local custom_mappings = {
        n = {
          ["<leader>fs"] = { function() require("telescope.builtin").find_files() end, desc = "Find files" },
          ["<D-.>"] = { function() vim.lsp.buf.code_action() end, desc = "LSP Code Action" },
          ["<D-s>"] = save_mapping,
          ["K"] = { function() vim.lsp.buf.hover() end, desc = "Show hover documentation" },

          ["<C-h>"] = { smart_splits.move_cursor_left, desc = "Move left" },
          ["<C-l>"] = {
            function()
              local right_winnr = vim.fn.winnr('l')

              if right_winnr ~= vim.fn.winnr() then
                local right_win_id = vim.fn.win_getid(right_winnr)
                local right_buf = vim.api.nvim_win_get_buf(right_win_id)
                local right_ft = vim.bo[right_buf].filetype

                if right_ft == "Avante" then
                  avante_api.focus()
                  return
                end
              end

              smart_splits.move_cursor_right()
            end,
            desc = "Move right (Focus Avante if adjacent)"
          },
          ["<C-j>"] = { smart_splits.move_cursor_down, desc = "Move down" },
          ["<C-k>"] = { smart_splits.move_cursor_up, desc = "Move up" },

          ["<leader>ca"] = {
            desc = "LSP Code actions",
            function() vim.lsp.buf.code_action() end,
          },
        },
        i = {
          ["<D-s>"] = save_mapping,

          ["<C-h>"] = { "<Left>", desc = "Move cursor left" },
          ["<C-l>"] = {
            function()
              -- First exit insert mode
              vim.cmd("stopinsert")

              -- Check if the window to the right is Avante
              local right_winnr = vim.fn.winnr('l')

              if right_winnr ~= vim.fn.winnr() then
                local right_win_id = vim.fn.win_getid(right_winnr)
                local right_buf = vim.api.nvim_win_get_buf(right_win_id)
                local right_ft = vim.bo[right_buf].filetype

                if right_ft == "Avante" then
                  avante_api.focus()
                  return
                end
              end

              -- If no Avante window detected, just press Right
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Right>", true, false, true), "n", false)
              vim.cmd("startinsert")
            end,
            desc = "Move right or focus Avante"
          },
          ["<C-j>"] = { "<Down>", desc = "Move cursor down" },
          ["<C-k>"] = { "<Up>", desc = "Move cursor up" },
        },
        v = {
          ["<D-s>"] = save_mapping,
        },
      }

      opts.mappings = vim.tbl_deep_extend("force", opts.mappings or {}, custom_mappings)

      return opts
    end,
  },
}
