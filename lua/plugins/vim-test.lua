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
        vim.cmd([[
          function! DevTestTransform(cmd) abort
            return 'nvim-test-runner '.shellescape(a:cmd)
          endfunction

          let g:test#custom_transformations = {'dev': function('DevTestTransform')}
          let g:test#transformation = 'dev'
        ]])

        opts.options.g["test#strategy"] = "neovim"
        opts.options.g["test#neovim#term_position"] = "botright 10" -- Horizontal at bottom
        opts.options.g["test#neovim#start_normal"] = 1 -- Start in normal mode
      end,
    },
    { "AstroNvim/astroui", opts = { icons = { VimTest = "󰙨" } } },
  },
  event = { "VeryLazy" },
  config = function()
    -- -- Create a custom autocmd group for test terminal windows
    -- local test_group = vim.api.nvim_create_augroup("VimTestTerminals", { clear = true })

    -- -- Add key mappings for easy exit when in a vim-test terminal
    -- vim.api.nvim_create_autocmd("TermOpen", {
    --   group = test_group,
    --   callback = function()
    --     local bufnr = vim.api.nvim_get_current_buf()
    --     local buf_name = vim.api.nvim_buf_get_name(bufnr)

    --     if buf_name:match("term://") then
    --       vim.defer_fn(function()
    --         if not vim.api.nvim_buf_is_valid(bufnr) then return end

    --         -- Check first few lines for test output
    --         local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 10, false)
    --         for _, line in ipairs(lines) do
    --           if line:match("[Rr]unning") and (line:match("test") or line:match("spec")) then
    --             -- Set key mappings for easy exit
    --             vim.keymap.set("n", "q", ":close<CR>", { buffer = bufnr, noremap = true, silent = true })
    --             vim.keymap.set("n", "<Esc>", ":close<CR>", { buffer = bufnr, noremap = true, silent = true })

    --             -- Mark buffer to avoid conflicts with ToggleTerm
    --             vim.b[bufnr].is_test_terminal = true
    --             break
    --           end
    --         end
    --       end, 100)
    --     end
    --   end
    -- })
  end
}