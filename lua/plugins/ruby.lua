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
    "AstroNvim/astrolsp",
    optional = true,
    opts = function(_, opts)
      -- Add ruby_lsp and sorbet to the servers list to ensure they're set up
      opts.servers = opts.servers or {}
      vim.list_extend(opts.servers, { "ruby_lsp", "sorbet" })

      -- Configure ruby_lsp
      opts.config = opts.config or {}
      opts.config.ruby_lsp = {
        cmd = {
          -- "ra-multiplex",
          -- "client",
          -- "--server-path",
          "/opt/homebrew/bin/shadowenv",
          -- "--",
          "exec",
          "--",
          "ruby-lsp",
        },
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
          offsetEncoding = "utf-16",
        },
      }

      -- Configure sorbet
      opts.config.sorbet = {
        cmd = {
          -- "ra-multiplex",
          -- "client",
          -- "--server-path",
          "/opt/homebrew/bin/shadowenv",
          -- "--",
          "exec",
          "--",
          "srb",
          "tc",
          "--lsp",
        },
        filetypes = { "ruby", "eruby", "rake" },
        root_dir = require("lspconfig.util").root_pattern "sorbet/config",
        init_options = {
          highlightUntyped = "nowhere", -- reduces diagnostic noise
        },
      }

      return opts
    end,
  },
}
