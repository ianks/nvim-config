-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- Language packs (these handle LSP, treesitter, mason tools automatically)
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.toml" },

  -- Copilot - Integrates into completion menu with cmp/blink
  { import = "astrocommunity.completion.copilot-lua-cmp" },

  -- Theme
  { import = "astrocommunity.colorscheme.catppuccin" },

  -- AI Coding Agent
  { import = "astrocommunity.completion.avante-nvim" },

  -- Useful motion plugins
  { import = "astrocommunity.motion.nvim-surround" },
  { import = "astrocommunity.motion.mini-move" },
}
