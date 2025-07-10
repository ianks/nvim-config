-- Mason configuration updated for AstroNvim v5
---@type LazySpec
return {
  -- Disable legacy helpers that are now handled by mason-tool-installer
  { "williamboman/mason-lspconfig.nvim", enabled = false },
  { "jay-babu/mason-null-ls.nvim", enabled = false },
  { "jay-babu/mason-nvim-dap.nvim", enabled = false },

  -- Unified installer/auto-updater
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "VeryLazy",
    opts = {
      ensure_installed = {
        -- LSP servers
        "lua-language-server",
        "ruby-lsp",
        -- Formatters / linters
        "stylua",
        "rubocop",
        -- Debuggers
      },
      auto_update = true,
      run_on_start = true,
    },
  },
}
