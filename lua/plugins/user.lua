-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  { "stevearc/dressing.nvim", enabled = false },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    enabled = false,
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        "              ⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀              ",
        "           ⢀⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⡀           ",
        "         ⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀         ",
        "       ⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄       ",
        "      ⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆      ",
        "     ⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠛⠛⠛⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄     ",
        "    ⢀⣿⣿⣿⣿⣿⣿⣿⠟⠋⠀⠀⣠⣴⠀⣠⣦⠀⠀⠙⠻⣿⣿⣿⣿⣿⣿⣿⡀    ",
        "    ⣼⣿⣿⣿⣿⣿⡟⠁⠀⠀⠀⢰⣿⡏⠀⣿⣿⡇⠀⠀⠀⠈⢻⣿⣿⣿⣿⣿⣧    ",
        "   ⢰⣿⣿⣿⣿⣿⠃⠀⠀⠀⠀⢸⣿⡇⠀⣿⣿⡇⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣆   ",
        "   ⣿⣿⣿⣿⣿⡿⠀⣠⣴⣦⣴⣿⣿⣷⣴⣿⣿⣷⣦⣴⣦⣄⠀⢿⣿⣿⣿⣿⣿⣿   ",
        "   ⣿⣿⣿⣿⣿⡇⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⢸⣿⣿⣿⣿⣿⣿   ",
        "   ⣿⣿⣿⣿⣿⠁⠈⠉⢹⣿⣿⡏⠉⠉⠉⠉⢹⣿⣿⡏⠉⠉⠁⠈⣿⣿⣿⣿⣿⣿   ",
        "   ⣿⣿⣿⣿⣿⠀⠀⠀⢸⣿⣿⡇⠀⣿⣿⠀⢸⣿⣿⡇⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿   ",
        "   ⣿⣿⣿⣿⣿⡆⠀⠀⣸⣿⣿⣧⣀⣿⣿⣀⣼⣿⣿⣇⠀⠀⠀⢰⣿⣿⣿⣿⣿⣿   ",
        "   ⣿⣿⣿⣿⣿⡇⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⠀⢀⣿⡿⢿⣿⣿⣿⣿   ",
        "   ⣿⣿⣿⣿⣿⡿⠀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⢸⡏⢸⣿⣿⣿⣿⣿   ",
        "    ⢿⣿⣿⣿⣿⣧⠀⢿⣿⣿⣿⣿⡿⠿⣿⣿⣿⣿⣿⡿⠀⣼⠟⢠⣿⣿⣿⣿⡿    ",
        "    ⠘⣿⣿⣿⣿⣿⣷⣄⠙⠻⣿⣿⣷⣶⣿⣿⣿⠟⠋⣠⣾⠏⣰⣿⣿⣿⣿⣿⠃    ",
        "     ⠈⢿⣿⣿⣿⣿⣿⣷⣤⣀⣀⣀⣀⣀⣀⣀⣀⣠⣾⣿⠁⣼⣿⣿⣿⣿⡿⠁     ",
        "       ⠈⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⢁⣼⣿⣿⣿⠟⠁       ",
        "          ⠉⠛⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⠉⠁⠀⣰⠏          ",
        "             ⠉⠉⠛⠛⠛⠛⠛⠛⠉⠉⠀⠀⠀⠀⢠⠞            ",
        "               ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⠃             ",
        "                ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠃              ",
        "                  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠜                ",
        "                    ⠀⠀⠀⠀⠀⠀⠀⠀⠈                  ",
      }
      return opts
    end,
  },

  -- AstroNvim v5 dashboard (Snacks)
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      local header = {
        "              ⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀              ",
        "           ⢀⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⡀           ",
        "         ⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀         ",
        "       ⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄       ",
        "      ⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆      ",
        "     ⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠛⠛⠛⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄     ",
        "    ⢀⣿⣿⣿⣿⣿⣿⣿⠟⠋⠀⠀⣠⣴⠀⣠⣦⠀⠀⠙⠻⣿⣿⣿⣿⣿⣿⣿⡀    ",
      }
      opts.dashboard = vim.tbl_deep_extend("force", opts.dashboard or {}, { header = header })
    end,
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = true },

  -- Configure toggleterm with custom mappings
  {
    "akinsho/toggleterm.nvim",
    opts = function(_, opts)
      -- Override the default mappings
      opts.mappings = {
        n = {
          ["<leader>tt"] = { "ToggleTerm", desc = "Toggle terminal" },
        },
        t = {
          ["<leader>tt"] = { "ToggleTerm", desc = "Toggle terminal" },
        },
        i = {
          ["<leader>tt"] = { "ToggleTerm", desc = "Toggle terminal" },
        },
      }
      -- Prevent toggleterm from interfering with vim-test windows
      opts.open_mapping = [[<leader>tt]]
      opts.direction = "float" -- Use float by default to avoid conflict with test terminal
      return opts
    end,
  },
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = true,
  },
  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
}
