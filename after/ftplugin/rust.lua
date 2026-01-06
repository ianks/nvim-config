-- Override AstroNvim's code action mapping for Rust files
-- Uses rustaceanvim's grouped code actions instead of vim.lsp.buf.code_action()
local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set("n", "<leader>la", function()
  vim.cmd.RustLsp("codeAction")
end, { buffer = bufnr, desc = "Code Action (Rust)" })

vim.keymap.set("n", "gra", function()
  vim.cmd.RustLsp("codeAction")
end, { buffer = bufnr, desc = "Code Action (Rust)" })

vim.keymap.set("n", "<C-.>", function()
  vim.cmd.RustLsp("codeAction")
end, { buffer = bufnr, desc = "Code Action (Rust)" })

-- Override hover to include actions
vim.keymap.set("n", "K", function()
  vim.cmd.RustLsp({ "hover", "actions" })
end, { buffer = bufnr, desc = "Hover (with actions)" })
