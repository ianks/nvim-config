---@type LazySpec
return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  opts = {
    provider = os.getenv("GROQ_API_KEY") and "groq_reasoning" or "claude",
    cursor_applying_provider = os.getenv("GROQ_API_KEY") and "groq_cursor_applying" or nil,
    behaviour = {
      enable_cursor_planning_mode = true,
    },
    vendors = {
      groq_reasoning = {
        __inherited_from = 'openai',
        api_key_name = 'GROQ_API_KEY',
        endpoint = 'https://api.groq.com/openai/v1/',
        model = 'qwen-qwq-32b',
        max_completion_tokens = 16384,
      },
      groq_cursor_applying = {
        __inherited_from = 'openai',
        api_key_name = 'GROQ_API_KEY',
        endpoint = 'https://api.groq.com/openai/v1/',
        model = 'llama-3.3-70b-versatile',
        max_completion_tokens = 32768, -- increased to prevent generation from stopping halfway
      },
    },
    rag_service = {
      enabled = true,
      host_mount = os.getenv("HOME") .. "/src",
      provider = "openai",
      llm_model = "gpt-3.5-turbo",
      embed_model = "text-embedding-3-large",
      endpoint = os.getenv("OPENAI_API_BASE") or "https://api.openai.com/v1",
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
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
