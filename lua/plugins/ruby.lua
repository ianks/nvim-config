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
    "williamboman/mason.nvim",
    opts = function(_, opts)
      -- Remove ruby-lsp from ensure_installed to prevent Mason from auto-installing it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "ruby-lsp" })
    end,
  },
  {
    "AstroNvim/astrolsp",
    optional = true,
    opts = function(_, opts)
      -- Add ruby_lsp to the servers list to ensure it's set up
      opts.servers = opts.servers or {}
      vim.list_extend(opts.servers, { "ruby_lsp" })

      -- Configure ruby_lsp
      opts.config = opts.config or {}
      opts.config.ruby_lsp = {
        cmd = vim.fn.executable "shadowenv" == 1
            and {
              "shadowenv",
              "exec",
              "--",
              -- "env",
              -- "RUBYOPT=-EUTF-8:UTF-8",
              "ruby-lsp",
            }
          or { "ruby-lsp" },
        filetypes = { "ruby", "eruby" },
        root_dir = require("lspconfig.util").root_pattern("dev.yml", "Gemfile.lock", "Gemfile"),
        init_options = {
          formatter = "auto",
        },
        capabilities = {
          general = {
            positionEncodings = { "utf-16" },
          },
        },
      }

      return opts
    end,
  },
}
