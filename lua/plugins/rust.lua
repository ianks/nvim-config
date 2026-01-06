-- Global Rust performance overrides for large monorepos (500+ dependencies)
-- The AstroCommunity rust pack provides the base rustaceanvim configuration
-- This file overrides settings for better performance in large workspaces
--
-- For project-specific settings, create a rust-analyzer.json file in your project root
-- See: https://rust-analyzer.github.io/manual.html#configuration

return {
  {
    "mrcjkb/rustaceanvim",
    optional = true,
    -- Format on save for Rust (rustaceanvim bypasses AstroLSP's format_on_save)
    init = function()
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.rs",
        callback = function()
          vim.lsp.buf.format { async = false }
        end,
      })
    end,
    opts = function(_, opts)
      opts.server = opts.server or {}

      -- Disable ra-multiplex - spawn rust-analyzer directly with shell env
      opts.server.ra_multiplex = { enable = false }

      -- Wrap the existing settings function (if any) to add our overrides
      local base_settings_fn = opts.server.settings

      opts.server.settings = function(project_root, default_settings)
        -- Get base settings from community pack or defaults
        local base = default_settings or {}
        if type(base_settings_fn) == "function" then
          base = base_settings_fn(project_root, default_settings) or base
        elseif type(base_settings_fn) == "table" then
          base = base_settings_fn
        end

        -- Merge our overrides
        return vim.tbl_deep_extend("force", base, {
          ["rust-analyzer"] = {
            checkOnSave = true,
            diagnostics = {
              enable = true,
              disabled = {}, -- Show ALL warnings including dead_code
            },
            check = {
              workspace = true,
              command = "clippy",
            },
            cachePriming = { enable = true },
            cargo = {
              buildScripts = { rebuildOnSave = false },
            },
            files = { watcher = "client" },
          },
        })
      end

      return opts
    end,
  },
}
