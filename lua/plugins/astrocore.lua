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
        signcolumn = "yes:1", -- Consistent 1-char sign column
        foldcolumn = "0", -- No fold column for maximum space
        cmdheight = 1, -- Minimal command line height
        laststatus = 3, -- Global statusline (less visual clutter)
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- Use Snacks.nvim picker (v5's replacement for Telescope)
        ["<leader>fs"] = { function() require("snacks.picker").files() end, desc = "Find files" },
        ["<D-s>"] = { "<cmd>w<cr>", desc = "Save file" },

        -- Buffer navigation with Alt+Shift+hjkl (from Cmd+hjkl via Ghostty/tmux)
        ["<M-S-h>"] = { "<cmd>bprevious<cr>", desc = "Previous buffer" },
        ["<M-S-l>"] = { "<cmd>bnext<cr>", desc = "Next buffer" },
        ["<M-S-j>"] = { "<cmd>bnext<cr>", desc = "Next buffer (alt)" },
        ["<M-S-k>"] = { "<cmd>bprevious<cr>", desc = "Previous buffer (alt)" },

        -- Aider AI comment helpers
        ["<leader>a"] = { desc = "󰚩 Aider" },
        ["<leader>a!"] = {
          function()
            local line = vim.api.nvim_get_current_line()
            local comment_char = vim.bo.commentstring:match "^(.-)%%s" or "//"
            vim.api.nvim_set_current_line(line .. " " .. comment_char .. " AI!")
          end,
          desc = "Add AI! to line",
        },
        ["<leader>a?"] = {
          function()
            local line = vim.api.nvim_get_current_line()
            local comment_char = vim.bo.commentstring:match "^(.-)%%s" or "//"
            vim.api.nvim_set_current_line(line .. " " .. comment_char .. " AI?")
          end,
          desc = "Add AI? to line",
        },
        ["<leader>ac"] = { ":AICode ", desc = "Add AI! code request" },
        ["<leader>aq"] = { ":AIAsk ", desc = "Add AI? question" },

        -- vim-test keybindings (using tmux via vimux)
        ["<leader>t"] = { desc = "󰙨 Testing" },
        ["<leader>tn"] = { "<cmd>TestNearest<CR>", desc = "Test Nearest" },
        ["<leader>tf"] = { "<cmd>TestFile<CR>", desc = "Test File" },
        ["<leader>tl"] = { "<cmd>TestLast<CR>", desc = "Test Last" },
        ["<leader>tc"] = { "<cmd>TestClass<CR>", desc = "Test Class" },
        ["<leader>ts"] = { "<cmd>TestSuite<CR>", desc = "Test Suite" },
        ["<leader>tv"] = { "<cmd>TestVisit<CR>", desc = "Test Visit" },
      },
      i = {
        ["<D-s>"] = { "<cmd>w<cr>", desc = "Save file" },
        -- Buffer navigation in insert mode
        ["<M-S-h>"] = { "<esc><cmd>bprevious<cr>", desc = "Previous buffer" },
        ["<M-S-l>"] = { "<esc><cmd>bnext<cr>", desc = "Next buffer" },
      },
      v = { ["<D-s>"] = { "<cmd>w<cr>", desc = "Save file" } },
    },
  },
}
