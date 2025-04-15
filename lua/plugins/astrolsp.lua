-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  opts = {
    config = {
      ruby_lsp = {
        cmd = { "shadowenv", "exec", "--", "ruby-lsp" },
        filetypes = { "ruby" },
        -- root directory detection for detecting the project root
        root_dir = require("lspconfig.util").root_pattern "dev.yml",
      },
      rust_analyzer = {
        cmd = { "shadowenv", "exec", "--", "rust-analyzer" },
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              extraEnv = { CARGO_TARGET_DIR = "target/astrolsp" },
              extraArgs = {},
            },
          },
        },
        root_dir = require("lspconfig.util").root_pattern "dev.yml",
      },
    },
    formatting = {
      format_on_save = { enabled = true },
      timeout_ms = 1000,
    },
  },
}
