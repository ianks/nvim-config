local M = {}

-- Store test pane ID
local test_pane_id = nil

-- Check if we're running inside tmux
local function in_tmux() return vim.env.TMUX ~= nil end

-- Execute tmux command with error handling
local function tmux_cmd(cmd)
  if not in_tmux() then error "Not running inside tmux session" end

  local result = vim.fn.system("tmux " .. cmd)
  if vim.v.shell_error ~= 0 then error("Tmux command failed: " .. result) end

  return result
end

-- Check if our test pane still exists
local function has_runner()
  if not test_pane_id then return false end

  local panes = tmux_cmd "list-panes -F '#{pane_id}'"
  return string.find(panes, test_pane_id, 1, true) ~= nil
end

-- Exit copy mode to ensure commands work properly
local function exit_copy_mode()
  if test_pane_id then
    -- Use send-keys with -q to quietly exit copy mode
    vim.fn.system("tmux send-keys -q -t " .. test_pane_id .. " q")
  end
end

-- Send raw keys to pane
local function send_keys(keys) tmux_cmd("send-keys -t " .. test_pane_id .. " " .. keys) end

-- Send text instantly with literal flag (no typing animation)
local function send_text(text) tmux_cmd("send-keys -t " .. test_pane_id .. " -l " .. vim.fn.shellescape(text)) end

M.get_or_create_test_pane = function()
  if not in_tmux() then error "ianks-dev: Not running inside tmux session" end

  -- Check if pane exists and is still valid
  if test_pane_id and has_runner() then return test_pane_id end

  -- Create new pane below with 30% height, same directory, using login shell to load full environment
  -- Pass NVIM_TEST_PANE environment variable so minimal starship theme loads immediately
  local result =
    tmux_cmd "split-window -v -p 30 -c '#{pane_current_path}' -e NVIM_TEST_PANE=1 -P -F '#{pane_id}' '$SHELL -l'"
  test_pane_id = result:gsub("\n", "")

  -- Wait a moment for shell to initialize with minimal prompt
  vim.wait(300)

  -- Clear the screen after environment setup (instant text)
  send_text "clear"
  send_keys "Enter"

  -- Return to the original pane
  tmux_cmd "last-pane"

  return test_pane_id
end

M.send_to_pane = function(pane_id, cmd)
  if not test_pane_id then M.get_or_create_test_pane() end

  -- Single tmux call: Ctrl-C to interrupt, clear screen, then send command
  -- Using table syntax for proper argument handling
  local result = vim.fn.system { "tmux", "send-keys", "-t", test_pane_id, "C-c", "C-m", "clear", "C-m" }

  if vim.v.shell_error == 0 then
    -- Send the actual command with -l flag for literal text
    vim.fn.system { "tmux", "send-keys", "-t", test_pane_id, "-l", cmd }
    -- Send Enter key separately (not literal)
    vim.fn.system { "tmux", "send-keys", "-t", test_pane_id, "C-m" }
  end

  if vim.v.shell_error ~= 0 then
    -- Fallback: recreate pane if it doesn't exist
    M.get_or_create_test_pane()
    vim.fn.system { "tmux", "send-keys", "-t", test_pane_id, "C-c", "C-m", "clear", "C-m" }
    vim.fn.system { "tmux", "send-keys", "-t", test_pane_id, "-l", cmd }
    vim.fn.system { "tmux", "send-keys", "-t", test_pane_id, "C-m" }
  end
end

M.clear_pane = function(pane_id)
  if not test_pane_id then
    return -- No pane to clear
  end

  -- Clear pane using table syntax for proper escaping
  vim.fn.system { "tmux", "send-keys", "-t", test_pane_id, "C-c", "C-m", "clear", "C-m" }
end

M.cleanup = function()
  if test_pane_id and has_runner() then tmux_cmd("kill-pane -t " .. test_pane_id) end
  test_pane_id = nil
end

return M
