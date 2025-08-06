return {
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "rust", "toml" })
      end
    end,
  },
  {
    "AstroNvim/astrolsp",
    optional = true,
    opts = function(_, opts)
      -- Add rust_analyzer to the servers list to ensure it's set up
      opts.servers = opts.servers or {}
      vim.list_extend(opts.servers, { "rust_analyzer" })

      -- Configure rust_analyzer
      opts.config = opts.config or {}
      
      -- Try to connect to ra-multiplex first
      local cmd = nil
      local lspMux = nil
      local ok, result = pcall(vim.lsp.rpc.connect, "127.0.0.1", 27631)
      if ok and result then
        cmd = result
        lspMux = {
          version = "1",
          method = "connect",
          server = "rust-analyzer",
        }
      else
        -- Fallback notification will be shown when LSP attaches
        vim.schedule(function()
          require("astrocore").notify("ra-multiplex not available, using standard rust-analyzer", vim.log.levels.WARN)
        end)
      end
      
      opts.config.rust_analyzer = {
        cmd = cmd, -- Will be nil if ra-multiplex is not available, falling back to default
        settings = {
          ["rust-analyzer"] = {
            lspMux = lspMux, -- Will be nil if not using ra-multiplex
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              runBuildScripts = true,
            },
            checkOnSave = {
              allFeatures = true,
              command = "clippy",
              extraArgs = { "--no-deps" },
            },
            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
            inlayHints = {
              bindingModeHints = {
                enable = false,
              },
              chainingHints = {
                enable = true,
              },
              closingBraceHints = {
                enable = true,
                minLines = 25,
              },
              closureReturnTypeHints = {
                enable = "never",
              },
              lifetimeElisionHints = {
                enable = "never",
                useParameterNames = false,
              },
              maxLength = 25,
              parameterHints = {
                enable = true,
              },
              reborrowHints = {
                enable = "never",
              },
              renderColons = true,
              typeHints = {
                enable = true,
                hideClosureInitialization = false,
                hideNamedConstructor = false,
              },
            },
            lens = {
              enable = true,
            },
            rust = {
              analyzerTargetDir = true,
            },
          },
        },
      }

      return opts
    end,
  },
}