-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  {
    "andweeb/presence.nvim",
    enabled = false, -- disable Presence completely
  },
  {
    -- LSP signature help (shown only after an LSP attaches)
    "ray-x/lsp_signature.nvim",
    event = "LspAttach",
    commit = "d9c39937e4e0977357530e988aa8940078bb231f", -- pin to latest good commit so git checkout never fails
    opts = {
      bind = true,
      hint_enable = false, -- no virtual text clutter
      handler_opts = { border = "rounded" }, -- nice rounded floating window
    },
  },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options

  -- AstroNvim v5 dashboard (Snacks)
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    opts = function(_, opts)
      local header = {
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
      opts.dashboard = vim.tbl_deep_extend("force", opts.dashboard or {}, {
        preset = {
          -- snacks expects a single multiline string, not an array
          header = table.concat(header, "\n"),
        },
      })
      -- enable Snacks' picker (replaces Telescope)
      opts.picker = vim.tbl_deep_extend("force", opts.picker or {}, { enabled = true })

      opts.bigfile = { enabled = true }
      opts.explorer = { enabled = true }
      opts.indent = { enabled = true }
      opts.input = { enabled = true }
      opts.notifier = { enabled = true, timeout = 3000 }
      opts.quickfile = { enabled = true }
      opts.scope = { enabled = true }
      opts.scroll = { enabled = true }
      opts.statuscolumn = { enabled = true }
      opts.words = { enabled = true }
    end,
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = true },

  {
    "akinsho/toggleterm.nvim",
    keys = { -- proper lazy-key mapping
      { "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
    },
    opts = { direction = "float" }, -- keep your float preference
  },
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    event = "VeryLazy", -- load when first used
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

  -- ❶ Defer all Mason helpers ──────────────────────────────────────────────
  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim", -- exact repo used by core
    event = "VeryLazy",
  },

  -- ❷ Load neoconf only when really needed
  {
    "folke/neoconf.nvim",
    event = "VeryLazy",
  },

  -- ❸ Lazy-load completion stack
  {
    "Saghen/blink.cmp",
    event = "InsertEnter", -- was eager via astrolsp
    opts = function(_, opts) -- keep the Tab integration already present
      opts.keymap = opts.keymap or {}
      opts.keymap["<Tab>"] = {
        "snippet_forward",
        function()
          if vim.g.ai_accept then return vim.g.ai_accept() end
        end,
        "fallback",
      }
      opts.keymap["<S-Tab>"] = { "snippet_backward", "fallback" }
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter", -- move from BufReadPost
    build = ":Copilot auth",
    opts = { suggestion = { keymap = { accept = false } } },
  },

  -- Override "<Leader>fo" so it lists recent files for the *current* directory only
  {
    "AstroNvim/astrocore",
    ---@param opts AstroCoreOpts
    opts = function(_, opts)
      local maps = assert(opts.mappings)

      -- 1) Find file by name
      maps.n["<leader>ff"] = {
        function()
          -- use git‐tracked files when inside a repo
          local root = vim.fn.systemlist(("git -C %s rev-parse --show-toplevel"):format(vim.fn.getcwd()))[1]
          if root and root ~= "" then
            require("snacks").picker.git_files()
          else
            require("snacks").picker.files()
          end
        end,
        desc = "Find file",
      }

      -- 2) Find by content (live grep)
      maps.n["<leader>fs"] = {
        function()
          local root = vim.fn.systemlist(("git -C %s rev-parse --show-toplevel"):format(vim.fn.getcwd()))[1]
          local cwd = (root and root ~= "") and root or vim.fn.getcwd()
          require("snacks").picker.grep { cwd = cwd }
        end,
        desc = "Search content",
      }

      -- provide a global AI-accept function for completion engines
      opts.options = opts.options or {}
      opts.options.g = opts.options.g or {}
      opts.options.g.ai_accept = function()
        local ok, suggestion = pcall(require, "copilot.suggestion")
        if ok and suggestion.is_visible() then
          suggestion.accept()
          return true
        end
      end
    end,
  },

  -- Disable Telescope since we're using Snacks' picker
  { "nvim-telescope/telescope.nvim", enabled = false },
}
