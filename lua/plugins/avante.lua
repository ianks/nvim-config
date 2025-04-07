local openai_base = os.getenv "OPENAI_API_BASE"

if not openai_base or openai_base == "" then
  vim.notify("Environment variable OPENAI_API_BASE is not set. Avante.nvim will not load.", vim.log.levels.WARN)
  return {}
end

---@type LazySpec
return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  opts = {
    provider = "claude",
    behavior = {
      enable_cursor_planning_mode = true,
      enable_claude_text_editor_tool_mode = true,
    },
    claude = {
      endpoint = os.getenv "ANTHROPIC_API_BASE",
      model = "claude-3-7-sonnet-20250219",
      timeout = 30000, -- Timeout in milliseconds
      temperature = 0,
      max_tokens = 20480,
    },
    openai = {
      endpoint = os.getenv "OPENAI_API_BASE",
      model = "gpt-4o",
      timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
      temperature = 0,
      max_tokens = 16384, -- Increase this to include reasoning tokens (for reasoning models)
      reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
    },
    rag_service = {
      enabled = false,
      host_mount = os.getenv "HOME" .. "/src",
      provider = "openai",
      llm_model = "gpt-3.5-turbo",
      embed_model = "text-embedding-3-large",
      endpoint = openai_base,
    },
    custom_tools = {
      {
        name = "run_dev_tests", -- Unique name for the tool
        description = "Execute tests using the 'dev test' command. This tool allows running specific test files with standard minitest options like name filters (--name=/pattern/). Result is the stdout of the test execution.",
        param = { -- Input parameters
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
        },
        returns = { -- Expected return values
          {
            name = "result",
            description = "Result of the test execution",
            type = "string",
          },
          {
            name = "error",
            description = "Error message if the test execution was not successful",
            type = "string",
            optional = true,
          },
        },
        func = function(params, on_log, on_complete) -- Custom function to execute
          local filename = params.filename or ""
          local options = params.options or ""
          local command = string.format("dev test %s %s", filename, options)
          on_log("Executing: " .. command)
          local result = vim.fn.system(command)
          return result
        end,
      },
    },
  },
  build = "make BUILD_FROM_SOURCE=true",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-telescope/telescope.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-tree/nvim-web-devicons",
    "zbirenbaum/copilot.lua",
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          use_absolute_path = true,
        },
      },
    },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
