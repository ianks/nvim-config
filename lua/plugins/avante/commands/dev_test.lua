local Utils = require "avante.utils"
local Base = require "avante.llm_tools.base"
local Config = require "avante.config"
local Providers = require "avante.providers"

---@class AvanteLLMTool
local M = setmetatable({}, Base)

M.name = "dev_test"

M.get_description = function()
  local provider = Providers[Config.provider]
  if Config.provider:match "copilot" and provider.model and provider.model:match "gpt" then
    return [[Execute tests using the 'dev test' command. This tool allows running specific test files with standard minitest options like name filters (--name=/pattern/). Result is the stdout of the test execution.]]
  end

  return [[Execute tests using the 'dev test' command. This tool allows running specific test files with standard minitest options like name filters (--name=/pattern/). Result is the stdout of the test execution.]]
end

---@type AvanteLLMToolParam
M.param = {
  type = "table",
  fields = {
    {
      name = "filename",
      description = "Test file to run (e.g. 'test/integration/custom_spec.rb')",
      type = "string",
      optional = true,
    },
    {
      name = "options",
      description = "Minitest options (e.g. '--name=/tablerow/ --trace')",
      type = "string",
      optional = true,
    },
  },
}

---@type AvanteLLMToolReturn[]
M.returns = {
  {
    name = "stdout",
    description = "Output of the test execution",
    type = "string",
  },
  {
    name = "error",
    description = "Error message if the test execution was not successful",
    type = "string",
    optional = true,
  },
}

---@type AvanteLLMToolFunc<{ filename: string, options: string }>
function M.func(opts, on_log, on_complete, _)
  local filename = opts.filename or ""
  local options = opts.options or ""
  local command = string.format("/opt/dev/bin/dev test %s %s", filename, options)

  if on_log then on_log("Executing: " .. command) end

  ---@param output string
  ---@param exit_code integer
  ---@return string | boolean | nil result
  ---@return string | nil error
  local function handle_result(output, exit_code)
    if exit_code ~= 0 then
      if output then return output, "Error: " .. output .. "; Error code: " .. tostring(exit_code) end
      return "", "Error code: " .. tostring(exit_code)
    end
    return output or "", nil
  end

  if not on_complete then return false, "on_complete not provided" end

  Utils.shell_run_async(command, "zsh -c", function(output, exit_code)
    local result, err = handle_result(output, exit_code)
    -- Ensure we never return nil or false as the result
    if result == nil or result == false then result = "" end
    on_complete(result, err)
  end)
end

return M
