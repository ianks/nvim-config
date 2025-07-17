return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    -- Read the logo from file
    local logo_path = vim.fn.expand "~/.config/nvim/logo.txt"
    local logo_lines = {}

    -- Check if the file exists and read it
    if vim.fn.filereadable(logo_path) == 1 then
      logo_lines = vim.fn.readfile(logo_path)
    else
      -- Fallback to default if file doesn't exist
      logo_lines = {
        "AstroNvim",
        "Configuration Not Found",
      }
    end

    -- Set the dashboard header to our custom logo
    if not opts.dashboard then opts.dashboard = {} end
    if not opts.dashboard.preset then opts.dashboard.preset = {} end

    opts.dashboard.preset.header = table.concat(logo_lines, "\n")

    return opts
  end,
}
