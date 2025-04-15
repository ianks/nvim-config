-- This is a custom override of the bash command
local Path = require "plenary.path"
local Utils = require "avante.utils"
local Helpers = require "avante.llm_tools.helpers"
local Base = require "avante.llm_tools.base"
local Config = require "avante.config"
local Providers = require "avante.providers"

-- Get the original bash module
local OriginalBash = require "plugins.avante.commands.bash"

---@class AvanteLLMTool
local M = setmetatable({}, Base)

-- Copy all properties from the original bash module
for k, v in pairs(OriginalBash) do
  M[k] = v
end

-- Override the func method to add your custom behavior
---@type AvanteLLMToolFunc<{ rel_path: string, command: string }>
function M.func(opts, on_log, on_complete, session_ctx)
  local abs_path = Helpers.get_abs_path(opts.rel_path)
  if not Helpers.has_permission_to_access(abs_path) then return false, "No permission to access path: " .. abs_path end
  if not Path:new(abs_path):exists() then return false, "Path not found: " .. abs_path end
  
  -- Add your custom logic here
  if on_log then on_log("CUSTOM BASH COMMAND: " .. opts.command) end
  
  ---change cwd to abs_path
  ---@param output string
  ---@param exit_code integer
  ---@return string | boolean | nil result
  ---@return string | nil error
  local function handle_result(output, exit_code)
    if exit_code ~= 0 then
      if output then return false, "Error: " .. output .. "; Error code: " .. tostring(exit_code) end
      return false, "Error code: " .. tostring(exit_code)
    end
    return output, nil
  end
  
  if not on_complete then return false, "on_complete not provided" end
  
  -- Custom confirmation message
  Helpers.confirm(
    "CUSTOM CONFIRMATION: Are you sure you want to run the command: `" .. opts.command .. "` in the directory: " .. abs_path,
    function(ok, reason)
      if not ok then
        on_complete(false, "User declined, reason: " .. (reason and reason or "unknown"))
        return
      end
      Utils.shell_run_async(opts.command, "zsh -c", function(output, exit_code)
        local result, err = handle_result(output, exit_code)
        on_complete(result, err)
      end, abs_path)
    end,
    { focus = true },
    session_ctx
  )
end

return M
