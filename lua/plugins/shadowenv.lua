return {
  {
    "Shopify/shadowenv.vim",
    lazy = false,
    enabled = vim.fn.executable "shadowenv" == 1,
  },
  {
    "AstroNvim/astrolsp",
    optional = true,
    opts = {
      config = {
        -- Only override the command if shadowenv exists
        rust_analyzer = vim.fn.executable "shadowenv" == 1 and {
          cmd = { "shadowenv", "exec", "--", "rust-analyzer" },
        } or {},
        clangd = vim.fn.executable "shadowenv" == 1 and {
          cmd = { "shadowenv", "exec", "--", "clangd", "--query-driver=/opt/homebrew/opt/llvm/bin/*" },
        } or {},
      },
    },
  },
}
