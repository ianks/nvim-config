return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    -- Filesystem only (no git at all for speed)
    default_source = "filesystem",

    -- Performance: disable git entirely
    enable_git_status = false,

    -- Performance: don't auto-refresh on every write
    enable_refresh_on_write = false,

    -- Performance: disable file watchers (can be slow in huge repos)
    use_popups_for_input = false, -- Faster input dialogs

    enable_diagnostics = true,
    close_if_last_window = true,
    popup_border_style = "rounded",

    -- Floating window configuration
    window = {
      position = "float", -- Floating window instead of sidebar
      width = 80,
      height = 30,
      mappings = {
        -- Source navigation with arrow keys (intuitive)
        ["<Left>"] = "prev_source",
        ["<Right>"] = "next_source",

        -- Node navigation with vim keys
        ["<space>"] = "none",
        ["l"] = "open",
        ["h"] = "close_node",
        ["<cr>"] = "open",

        -- Splits and tabs
        ["v"] = "open_vsplit",
        ["s"] = "open_split",
        ["t"] = "open_tabnew",

        -- Tree operations
        ["C"] = "close_all_nodes",
        ["z"] = "close_all_nodes",
        ["R"] = "refresh",

        -- File operations
        ["a"] = "add",
        ["d"] = "delete",
        ["r"] = "rename",
        ["y"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",

        -- Utility
        ["q"] = "close_window",
        ["?"] = "show_help",
      },
    },

    -- Source selector configuration (order matters!)
    source_selector = {
      winbar = true, -- Show tabs at top
      statusline = false,
      sources = {
        { source = "filesystem", display_name = " 󰉓 Files " },
        { source = "buffers", display_name = " 󰈚 Buffers " },
      },
      content_layout = "center",
      tabs_layout = "equal",
      separator = { left = "▏", right = "▕" },
    },

    default_component_configs = {
      indent = {
        with_expanders = true,
        expander_collapsed = "",
        expander_expanded = "",
      },
    },

    -- Filesystem source configuration (git completely disabled for speed)
    filesystem = {
      -- CRITICAL: Disable git entirely in filesystem view
      enable_git_status = false,

      window = {
        mappings = {
          -- Filesystem-specific navigation
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
        },
      },

      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },

      -- Performance: disable file watching in huge monorepos
      use_libuv_file_watcher = false,

      hijack_netrw_behavior = "open_current",
      group_empty_dirs = true,

      -- Performance: NO git checking at all
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = false,
        respect_gitignore = false, -- No git operations

        hide_by_name = {
          "node_modules",
          ".git",
          ".cache",
          "__pycache__",
        },
        never_show = {
          ".DS_Store",
          "thumbs.db",
        },
      },
    },

    -- Buffers source configuration
    buffers = {
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },
      window = {
        mappings = {
          ["bd"] = "buffer_delete",
        },
      },
    },
  },
}
