-- Simplified Mason config for AstroNvim v5
---@type LazySpec
return {
  "williamboman/mason.nvim",
  opts = function(_, opts)
    -- include/merge any packages you need here
    opts.ensure_installed = {
      -- LSPs
      "lua-language-server",
      "ruby-lsp",
      -- Formatters / linters
      "stylua",
      "rubocop",
    }
  end,
}
