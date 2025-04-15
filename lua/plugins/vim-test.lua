---@type LazySpec
return {
  "vim-test/vim-test",
  cmd = { "TestNearest", "TestFile", "TestLast", "TestClass", "TestSuite", "TestVisit" },
  dependencies = {
    {
      "AstroNvim/astrocore",
      ---@param opts AstroCoreOpts
      opts = function(_, opts)
        local maps = assert(opts.mappings)

        local prefix = "<Leader>t"
        maps.n[prefix] = { desc = require("astroui").get_icon("VimTest", 1, true) .. "Testing" }

        maps.n[prefix .. "n"] = { ":TestNearest<CR>", desc = "Test Nearest" }
        maps.n[prefix .. "f"] = { ":TestFile<CR>", desc = "Test File" }
        maps.n[prefix .. "l"] = { ":TestLast<CR>", desc = "Test Last" }
        maps.n[prefix .. "c"] = { ":TestClass<CR>", desc = "Test Class" }
        maps.n[prefix .. "s"] = { ":TestSuite<CR>", desc = "Test Suite" }
        maps.n[prefix .. "v"] = { ":TestVisit<CR>", desc = "Test Visit" }

        -- Set the strategy to open results in a horizontal split
        if not opts.options then opts.options = {} end
        if not opts.options.g then opts.options.g = {} end

        -- Setup custom transformation - use a proper VimL function wrapper
        vim.cmd [[
          function! DevTestTransform(cmd) abort
            return 'nvim-test-runner '.shellescape(a:cmd)
          endfunction

          let g:test#custom_transformations = {'dev': function('DevTestTransform')}
          let g:test#transformation = 'dev'
        ]]

        -- Use the neovim_sticky strategy instead of neovim for better terminal management
        -- opts.options.g["test#strategy"] = "neovim_sticky"
        opts.options.g["test#strategy"] = "neovim"
        opts.options.g["test#preserve_screen"] = 0
        opts.options.g["test#neovim#term_position"] = "botright 15" -- Horizontal at bottom
        -- opts.options.g["test#neovim#start_normal"] = 1 -- Start in normal mode
        -- opts.options.g["test#neovim_sticky#kill_previous"] = 1 -- Kill previous test run
        -- opts.options.g["test#neovim_sticky#use_existing"] = 1 -- Reuse existing terminal buffers
      end,
    },
    { "AstroNvim/astroui", opts = { icons = { VimTest = "󰙨" } } },
  },
  event = { "VeryLazy" },
}
