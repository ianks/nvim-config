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
        clangd = vim.fn.executable "shadowenv" == 1 and {
          cmd = { "shadowenv", "exec", "--", "clangd", "--query-driver=/opt/homebrew/opt/llvm/bin/*" },
        } or {},
      },
    },
  },
}
