---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    features = {
      codelens = true,
      inlay_hints = false,
      -- semantic_tokens = true,
    },
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true,
        ignore_filetypes = { "c", "cpp", "yaml" }, -- Your preference
      },
      timeout_ms = 1000, -- default format timeout
    },
    servers = {
      "ruby_lsp",
    },
    ---@diagnostic disable: missing-fields
    config = {
      clangd = { capabilities = { offsetEncoding = "utf-8" } },
    },
    handlers = {},
    -- Configure buffer local auto commands to add when attaching a language server
    autocmds = {
      lsp_codelens_refresh = {
        cond = "textDocument/codeLens",
        {
          event = { "InsertLeave", "BufEnter" },
          desc = "Refresh codelens (buffer)",
          callback = function(args)
            if require("astrolsp").config.features.codelens then vim.lsp.codelens.refresh { bufnr = args.buf } end
          end,
        },
      },
    },
    mappings = {
      n = {
        -- a `cond` key can provided as the string of a server capability to be required to attach, or a function with `client` and `bufnr` parameters from the `on_attach` that returns a boolean
        gD = {
          function() vim.lsp.buf.declaration() end,
          desc = "Declaration of current symbol",
          cond = "textDocument/declaration",
        },
        gd = {
          function()
            local clients = vim.lsp.get_clients { bufnr = 0 }
            local has_definition = false
            for _, client in ipairs(clients) do
              if client.server_capabilities.definitionProvider then
                has_definition = true
                break
              end
            end

            if has_definition then
              vim.lsp.buf.definition()
            else
              vim.cmd "normal! g<C-]>"
            end
          end,
          desc = "Go to definition (LSP or tags)",
        },
        ["<C-.>"] = {
          function() vim.lsp.buf.code_action() end,
          desc = "Code action",
          cond = "textDocument/codeAction",
        },
      },
    },
  },
}
