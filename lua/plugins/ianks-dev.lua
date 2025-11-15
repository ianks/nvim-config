-- ianks-dev: local custom dev utilities module
-- Now located at ~/.config/nvim/lua/ianks-dev/
return {
  "vim-test/vim-test",
  lazy = false,
  config = function()
    -- Setup ianks-dev utilities after vim-test is loaded
    require("ianks-dev").setup()
  end,
}
