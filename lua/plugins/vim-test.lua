return {
  "vim-test/vim-test",
  cmd = { "TestNearest", "TestFile", "TestLast", "TestClass", "TestSuite", "TestVisit" },
  keys = {
    { "<leader>t", desc = "󰙨 Testing" },
    { "<leader>tn", "<cmd>TestNearest<CR>", desc = "Test Nearest" },
    { "<leader>tf", "<cmd>TestFile<CR>", desc = "Test File" },
    { "<leader>tl", "<cmd>TestLast<CR>", desc = "Test Last" },
    { "<leader>tc", "<cmd>TestClass<CR>", desc = "Test Class" },
    { "<leader>ts", "<cmd>TestSuite<CR>", desc = "Test Suite" },
    { "<leader>tv", "<cmd>TestVisit<CR>", desc = "Test Visit" },
  },
  init = function()
    vim.g["test#strategy"] = "neovim"
    vim.g["test#neovim#term_position"] = "botright 15"
    vim.g["test#neovim#start_normal"] = 1
  end,
}
