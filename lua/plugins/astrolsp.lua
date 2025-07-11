-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

-- Function to check if shadowenv exists and use it if available
---@param cmd string The command to execute
---@return table The command array with or without shadowenv
local function maybe_shadowenv_exec(cmd)
  local exists = vim.fn.executable "shadowenv" == 1

  if exists then
    return { "shadowenv", "exec", "--", cmd }
  else
    return { cmd }
  end
end

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  opts = {
    config = {
      ruby_lsp = {
        cmd = maybe_shadowenv_exec "ruby-lsp",
        filetypes = { "ruby" },
        -- root directory detection for detecting the project root
        root_dir = require("lspconfig.util").root_pattern("dev.yml", "Gemfile.lock", "Gemfile"),
      },
      -- rust_analyzer = {
      --   cmd = maybe_shadowenv_exec "ra-multiplex",
      --   settings = {
      --     ["rust-analyzer"] = {
      --       cargo = {
      --         targetDir = "target/astrolsp",
      --       },
      --     },
      --   },
      --   root_dir = require("lspconfig.util").root_pattern("dev.yml", "Cargo.lock", "Cargo.toml"),
      -- },
      clangd = {
        cmd = (function()
          local cmd = maybe_shadowenv_exec "clangd"
          -- Use query-driver to find system includes, including Homebrew's
          table.insert(cmd, "--query-driver=/opt/homebrew/opt/llvm/bin/*")
          return cmd
        end)(),
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
        root_dir = require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
      },
    },
    formatting = {
      format_on_save = {
        enabled = true,
        ignore_filetypes = {
          "c",
          "cpp",
        },
      },
      timeout_ms = 1000,
    },
  },
}
