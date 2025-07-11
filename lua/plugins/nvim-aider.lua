---@type LazySpec
return {
  "GeorgesAlkhouri/nvim-aider",
  cmd = "Aider",
  keys = {
    { "<leader>a/", "<cmd>Aider toggle<cr>", desc = "Aider: toggle terminal" },
    { "<leader>as", "<cmd>Aider send<cr>", desc = "Aider: send (prompt)", mode = { "n", "v" } },
    { "<leader>ac", "<cmd>Aider command<cr>", desc = "Aider: command menu" },
    { "<leader>ab", "<cmd>Aider buffer<cr>", desc = "Aider: send buffer" },
    { "<leader>a+", "<cmd>Aider add<cr>", desc = "Aider: add file" },
    { "<leader>a-", "<cmd>Aider drop<cr>", desc = "Aider: drop file" },
    { "<leader>ar", "<cmd>Aider add readonly<cr>", desc = "Aider: add read-only file" },
    { "<leader>aR", "<cmd>Aider reset<cr>", desc = "Aider: reset session" },
  },
  -- override defaults: enable auto-reload when Aider changes files
  opts = { auto_reload = true },
  dependencies = {
    "folke/snacks.nvim", -- required
  },
  config = true, -- use plugin defaults
}
