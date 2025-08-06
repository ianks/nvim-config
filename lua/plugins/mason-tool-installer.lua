return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  opts = function(_, opts)
    opts.ensure_installed = opts.ensure_installed or {}

    -- Remove ruby-lsp if it exists in the ensure_installed list
    opts.ensure_installed = vim.tbl_filter(function(tool)
      if type(tool) == "string" then
        return tool ~= "ruby-lsp"
      elseif type(tool) == "table" then
        return tool[1] ~= "ruby-lsp"
      end
      return true
    end, opts.ensure_installed)

    -- Add Rust tools
    vim.list_extend(opts.ensure_installed, {
      "rust-analyzer",
      "codelldb", -- Rust debugger
    })

    return opts
  end,
}
