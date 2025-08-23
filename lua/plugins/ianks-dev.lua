return {
  dir = "~/shopify-dotfiles/modules/ianks-dev",
  name = "ianks-dev",
  lazy = false,
  dependencies = { "vim-test/vim-test" },
  config = function() require("ianks-dev").setup() end,
}
