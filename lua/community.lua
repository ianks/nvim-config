-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- Language packs (these handle LSP, treesitter, mason tools automatically)
  { import = "astrocommunity.pack.ruby" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.toml" },

  -- AI Integration Recipe - CRITICAL for proper Tab handling with Blink.cmp
  { import = "astrocommunity.recipes.ai" },

  -- Copilot - Provides tight LSP integration
  { import = "astrocommunity.completion.copilot-lua" },

  -- Theme
  { import = "astrocommunity.colorscheme.catppuccin" },

  -- Useful motion plugins
  { import = "astrocommunity.motion.nvim-surround" },
  { import = "astrocommunity.motion.mini-move" },
}
