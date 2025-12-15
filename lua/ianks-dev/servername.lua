local M = {}

local function store_servername()
  if vim.env.TMUX and vim.v.servername ~= "" then
    -- Store servername in tmux pane's user options
    vim.fn.system(string.format("tmux set-option -p @nvim_server '%s'", vim.v.servername))
  end
end

M.setup = function()
  local group = vim.api.nvim_create_augroup("IanksTmuxServername", { clear = true })

  -- Store immediately when module loads (for already-running nvim instances)
  store_servername()

  -- Also store on VimEnter for new nvim instances
  vim.api.nvim_create_autocmd("VimEnter", {
    group = group,
    callback = store_servername,
  })

  -- Clean up on exit
  vim.api.nvim_create_autocmd("VimLeavePre", {
    group = group,
    callback = function()
      if vim.env.TMUX then vim.fn.system "tmux set-option -up @nvim_server" end
    end,
  })
end

return M
