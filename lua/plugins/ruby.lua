local function maybe_shadowenv_exec(...)
  local args = { ... } -- capture all arguments
  local root = require("lspconfig.util").root_pattern("dev.yml", "Gemfile.lock", "Gemfile")
  if vim.fn.executable "shadowenv" == 1 then
    return vim.list_extend({ "shadowenv", "exec", "--dir", root, "--" }, args)
  end
  return args
end

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
      -- opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "ruby-lsp" })
    end,
  },
  -- Ruby LSP configuration is now in astrolsp.lua
  -- {
  --   "AstroNvim/astrolsp",
  --   optional = true,
  --   opts = function(_, opts)
  --     -- Add ruby_lsp to the servers list to ensure it's set up
  --     opts.servers = opts.servers or {}
  --     vim.list_extend(opts.servers, { "ruby_lsp" })
  --
  --     -- Configure ruby_lsp
  --     opts.config = opts.config or {}
  --     opts.config.ruby_lsp = {
  --       cmd = maybe_shadowenv_exec "ruby-lsp",
  --       -- cmd = { "ruby-lsp" },
  --       filetypes = { "ruby", "eruby" },
  --       root_dir = require("lspconfig.util").root_pattern("dev.yml", "Gemfile.lock", "Gemfile"),
  --       init_options = {
  --         formatter = "auto",
  --       },
  --       -- root directory detection for detecting the project root
  --       -- root_dir = require("lspconfig.util").root_pattern("dev.yml", "Gemfile.lock", "Gemfile"),
  --     }
  --
  --     return opts
  --   end,
  -- },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = { "suketa/nvim-dap-ruby", config = true },
  },
}
