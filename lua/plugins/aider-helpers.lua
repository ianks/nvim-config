-- Aider AI comment helpers configuration
return {
  {
    "nvim-lua/plenary.nvim", -- Use a common dependency as a hook for our config
    config = function()
      -- Quick AI! comment helpers for use with aider watch mode

      -- Add AI! code generation comment
      vim.api.nvim_create_user_command("AICode", function(opts)
        local line = vim.api.nvim_get_current_line()
        local comment_char = vim.bo.commentstring:match "^(.-)%%s" or "//"
        vim.api.nvim_set_current_line(line .. " " .. comment_char .. " " .. opts.args .. " AI!")
      end, { nargs = "*", desc = "Add AI! code comment for aider" })

      -- Add AI? question comment
      vim.api.nvim_create_user_command("AIAsk", function(opts)
        local line = vim.api.nvim_get_current_line()
        local comment_char = vim.bo.commentstring:match "^(.-)%%s" or "//"
        vim.api.nvim_set_current_line(line .. " " .. comment_char .. " " .. opts.args .. " AI?")
      end, { nargs = "*", desc = "Add AI? question comment for aider" })
    end,
  },
}
