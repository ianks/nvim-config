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
      -- Add ruby_lsp and sorbet to the servers list to ensure they're set up
      opts.servers = opts.servers or {}
      vim.list_extend(opts.servers, { "ruby_lsp", "sorbet" })

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
        filetypes = { "ruby", "eruby", "rake" },
        root_dir = require("lspconfig.util").root_pattern("dev.yml", "Gemfile.lock", "Gemfile"),
        init_options = {
          enabledFeatures = {
            codeActions = true,
            codeLens = true,
            completion = true,
            definition = true,
            diagnostics = true,
            documentHighlights = true,
            documentLink = true,
            documentSymbols = true,
            foldingRanges = true,
            formatting = true,
            hover = true,
            inlayHint = true,
            onTypeFormatting = true,
            selectionRanges = true,
            semanticHighlighting = true,
            signatureHelp = true,
            typeHierarchy = true,
            workspaceSymbol = true,
          },
          featuresConfiguration = {
            inlayHint = {
              implicitHashValue = true,
              implicitRescue = true,
            },
          },
          indexing = {
            excludedPatterns = {},
            includedPatterns = {},
            excludedGems = {},
            excludedMagicComments = {},
          },
          formatter = "auto",
          linters = { "rubocop" },
          experimentalFeaturesEnabled = false,
        },
        settings = {
          rubyLsp = {
            enabledFeatures = {
              codeActions = true,
              codeLens = true,
              completion = true,
              definition = true,
              diagnostics = true,
              documentHighlights = true,
              documentLink = true,
              documentSymbols = true,
              foldingRanges = true,
              formatting = true,
              hover = true,
              inlayHint = true,
              onTypeFormatting = true,
              selectionRanges = true,
              semanticHighlighting = true,
              signatureHelp = true,
              typeHierarchy = true,
              workspaceSymbol = true,
              typeCheck = true,
            },
            featuresConfiguration = {
              inlayHint = {
                implicitHashValue = true,
                implicitRescue = true,
              },
            },
            indexing = {
              excludedPatterns = {},
              includedPatterns = {},
              excludedGems = {},
              excludedMagicComments = {},
            },
            formatter = "auto",
            linters = { "rubocop" },
            experimentalFeaturesEnabled = false,
          },
        },
        capabilities = {
          general = {
            positionEncodings = { "utf-16" },
          },
        },
      }

      -- Configure sorbet
      opts.config.sorbet = {
        cmd = vim.fn.executable "shadowenv" == 1
            and {
              "shadowenv",
              "exec",
              "--",
              "srb",
              "tc",
              "--lsp",
            }
          or { "srb", "tc", "--lsp" },
        filetypes = { "ruby", "eruby", "rake" },
        root_dir = require("lspconfig.util").root_pattern("sorbet/config"),
        init_options = {
          highlightUntyped = "everywhere", -- or "nowhere" or "everywhere-but-tests"
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
