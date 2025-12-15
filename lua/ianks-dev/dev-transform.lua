local M = {}

-- Check if dev.yml exists in project root
M.has_dev_yml = function()
  local dev_yml = vim.fn.findfile("dev.yml", ".;")
  return dev_yml ~= ""
end

-- Transform function for dev test - ONLY for Ruby
M.transform = function(cmd)
  -- Only transform if dev.yml exists
  if not M.has_dev_yml() then return cmd end

  -- Only transform Ruby test commands
  -- Check for common Ruby test patterns
  if
    cmd:match "rake test"
    or cmd:match "rails test"
    or cmd:match "rspec"
    or cmd:match "minitest"
    or cmd:match "cucumber"
    or cmd:match "ruby %-Itest"
    or cmd:match "ruby %-Ispec"
    or cmd:match "bundle exec rake test"
    or cmd:match "bundle exec rails test"
    or cmd:match "bundle exec rspec"
    or cmd:match "bin/rake test"
    or cmd:match "bin/rails test"
    or cmd:match "bin/rspec"
    or cmd:match "zeus"
    or cmd:match "spring"
  then
    local result = "dev test"

    -- Handle rake test with TEST= format
    local test_file = cmd:match 'TEST="([^"]+)"'
    if test_file then
      result = result .. " " .. test_file

      -- Also extract test name from TESTOPTS if present
      local test_name = cmd:match "TESTOPTS=\"[^\"]*%-%-name='([^']+)'\""
      if test_name then
        -- Convert the test name format for dev test
        test_name = test_name:gsub("\\#", "#") -- Unescape hash symbols
        result = result .. ' --name="' .. test_name .. '"'
      end

      return result
    end

    -- Handle direct file paths (rspec, rails test without TEST=)
    test_file = cmd:match "([%w%p/]+_test%.rb)"
    if not test_file then test_file = cmd:match "([%w%p/]+_spec%.rb)" end
    if not test_file then test_file = cmd:match "(test/[%w%p/]+%.rb)" end
    if not test_file then test_file = cmd:match "(spec/[%w%p/]+%.rb)" end

    if test_file then
      result = result .. " " .. test_file

      -- Extract line number if present (e.g., file.rb:42)
      local line_num = cmd:match(test_file .. ":(%d+)")
      if line_num then result = result .. ":" .. line_num end

      return result
    end
  end

  -- Return unmodified command if not a Ruby test
  return cmd
end

return M
