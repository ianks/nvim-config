return {
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "ruby" })
      end
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "ruby-lsp", "syntax_tree" })
    end,
  },
  {
    "AstroNvim/astrolsp",
    optional = true,
    opts = function(_, opts)
      -- Add ruby-lsp to servers list
      opts.servers = opts.servers or {}
      table.insert(opts.servers, "ruby_lsp")

      -- Configure ruby-lsp
      opts.config = require("astrocore").extend_tbl(opts.config or {}, {
        ruby_lsp = vim.fn.executable "shadowenv" == 1 and {
          cmd = { "shadowenv", "exec", "--", "ruby-lsp" },
          filetypes = { "ruby" },
          root_dir = function(fname)
            local util = require "lspconfig.util"
            return util.root_pattern("Gemfile", ".git", ".shadowenv.d")(fname)
          end,
          init_options = {
            formatter = "syntax_tree",
            linters = {},
            enabledFeatures = {
              formatting = true,
            },
          },
          settings = {},
        } or {
          filetypes = { "ruby" },
          root_dir = function(fname)
            local util = require "lspconfig.util"
            return util.root_pattern("Gemfile", ".git")(fname)
          end,
          init_options = {
            formatter = "syntax_tree",
            linters = {},
            enabledFeatures = {
              formatting = true,
            },
          },
          settings = {},
        },
      })

      return opts
    end,
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = { "suketa/nvim-dap-ruby", config = true },
  },
}
