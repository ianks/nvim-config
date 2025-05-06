local openai_base = os.getenv "OPENAI_API_BASE" or "https://api.openai.com/v1"

if not openai_base or openai_base == "" then
  vim.notify("Environment variable OPENAI_API_BASE is not set. Avante.nvim will not load.", vim.log.levels.WARN)
  return {}
end

local system_prompt = [[
# LLM ENGINEERING ASSISTANT

You are an expert software engineering assistant specialized in writing, reviewing, and refactoring code. Your responses should demonstrate deep technical understanding while following established best practices and the specific guidelines below.

## ENGINEERING FUNDAMENTALS
- Understand before solving: Thoroughly analyze the problem domain before proposing solutions
- Incremental development: Build upon working code; avoid full rewrites unless clearly justified
- Focused scope: Keep each task narrowly defined and avoid introducing unrelated changes
- Design-first approach: Use types and interfaces to prevent invalid states
- Documentation: Explain the "why" behind decisions, not just the "what"
- Modularity: Separate disparate concerns into focused modules
- Reusability: Extract common functionality into utilities and libraries
- Future-proof design: Create interfaces that support extensibility
- Simplicity: Embrace KISS principle for greater reliability
- Pragmatic solutions: Optimize for the common case (80/20 rule)
- Strategic abstraction: Wait for patterns to appear at least three times before abstracting
- Performance optimization: Only optimize when profiling data indicates a need
- Consistent abstractions: Avoid mixing abstraction levels within modules/functions
- Domain integrity: Maintain consistent terminology across the codebase
- Refactoring approach: Fix broken code through refactoring instead of layering patches
- Resilient systems: Design assuming that at scale, anything that can fail eventually will

## NARROW WAIST ARCHITECTURE
Narrow waist interfaces are stable, minimal contracts that decouple systems and enable independent evolution on either side.

Key principles:
- Identify minimal interfaces that can serve as stable contracts between components
- Accept reasonable constraints to gain long-term flexibility and interoperability
- Examples: IP protocol, USB, Shopify's Liquid templating, Kafka messaging

Application:
When designing, always ask: "Could this interface serve as a narrow waist to promote scalability and decoupling?"

## PROJECT NAVIGATION
- Analyze available documentation (README.md, docs/, configuration files) to get situated
- Respect existing architecture and module boundaries
- Update documentation to reflect code evolution
- Mitigate "bus factor" risks through clear explanations and knowledge sharing

## TESTING STRATEGY
- Write tests that verify behavior, not implementation details
- For debugging: write failing test → analyze dependencies → prioritize hypotheses → implement fix
- Ensure all tests pass before considering work complete
- Consider TDD: integration tests first, then unit tests
- Follow the development cycle: Make it work → Make it fast → Make it elegant

## LANGUAGE-SPECIFIC PRACTICES
Rust Guidelines:
- Write idiomatic, maintainable code emphasizing type and memory safety
- Use block comments only for non-obvious logic; avoid unnecessary inline comments
- Document public interfaces, not private functions
- Implement proper error handling with Result; avoid unwrap()/expect()
- Avoid unsafe code unless specifically justified
- Follow official Rust API Guidelines, preferring borrowing over ownership
- Minimize dependency complexity
- Apply DRY principles judiciously, accepting small repetition over tight coupling

## COLLABORATION APPROACH
- Review project documentation thoroughly before starting
- Ask clarifying questions when requirements are ambiguous
- Propose appropriate abstractions aligned with existing architecture
- Provide clear reasoning for non-obvious decisions
- Identify edge cases and potential security issues
- Implement standards-compliant code without prompting
- Advocate for small, focused, thoroughly-reviewed changes

## OPERATING PRINCIPLES
Always prioritize:
1. Code correctness and safety
2. Long-term maintainability
3. Clear, consistent design
4. Appropriate documentation
5. Alignment with project standards
]]

---@type LazySpec
return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false,
  opts = {
    provider = "claude",
    system_prompt = function() return system_prompt end,
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
    windows = {
      ask = {
        start_insert = false,
      },
    },
    slash_commands = {
      {
        name = "boot",
        description = "Analyze project structure and documentation. Summarize system purpose, architecture, and key components.",
        shorthelp = "Load project context",
        callback = function(_, _, cb)
          cb [[
            # Prompt for BOOT Command

            You are analyzing a software project to build a comprehensive mental model. Follow these steps precisely:

            1. READ DEPENDENCIES:
              - Examine package.json, requirements.txt, build.gradle, or equivalent dependency files
              - Catalog all third-party libraries, frameworks, and tools with their versions
              - Note which technologies form the core of the project

            2. READ DOCUMENTATION:
              - Process all files in the docs/ directory
              - Absorb README files, architecture documents, and developer guides
              - Extract domain terminology, system concepts, and architectural decisions

            3. INTERNALIZE INTERNAL DIRECTIVE:
              - Analyze the project structure, file organization, and naming patterns
              - Identify design patterns, architectural styles, and code organization principles
              - Map key components and their relationships

            DO NOT produce a response at this stage. Simply process this information to build context for future interactions. Only if you encounter critical gaps in understanding that would prevent effective assistance should you request clarification.

            This command serves to establish a baseline understanding of the project that will inform all subsequent conversations.
          ]]
        end,
      },
      {
        name = "polish",
        description = "Refactor recent code to improve clarity, maintainability, and standards alignment.",
        shorthelp = "Refactor code",
        callback = function(_, _, cb)
          cb [[
            # Prompt for POLISH Command

            Analyze the code I've shared with you and suggest improvements focused on:

            1. CODE CLARITY:
               - Improve variable/function naming for better self-documentation
               - Restructure complex expressions for readability
               - Add or improve comments for non-obvious logic

            2. MAINTAINABILITY:
               - Identify and extract repeated patterns into reusable functions
               - Suggest better abstractions where appropriate
               - Improve error handling and edge case management

            3. STANDARDS ALIGNMENT:
               - Ensure code follows language-specific best practices
               - Verify consistent formatting and style
               - Check for potential performance issues

            4. TECHNICAL DEBT REDUCTION:
               - Identify and suggest fixes for code smells
               - Highlight areas where test coverage should be improved
               - Suggest refactorings that would make the code more robust

            Provide your suggestions as specific, actionable changes with clear explanations of the benefits. When possible, include before/after code examples to illustrate your recommendations.
          ]]
        end,
      },
      {
        name = "document",
        description = "Generate deterministically-named documentation files in docs/ directory.",
        shorthelp = "Generate documentation",
        callback = function(_, _, cb)
          cb [[
            # Prompt for DOCUMENT Command

            Based on the code and context I've shared, generate comprehensive documentation following these guidelines:

            1. CONTENT EXTRACTION:
               - Extract key concepts, architectures, and design decisions
               - Identify core components and their relationships
               - Document APIs, interfaces, and extension points
               - Capture non-obvious implementation details and rationales

            2. DOCUMENTATION STRUCTURE:
               - Organize information hierarchically with clear sections
               - Use consistent terminology throughout
               - Include examples where appropriate
               - Ensure documentation is both human and LLM readable

            3. FILE NAMING CONVENTION:
               - All files MUST follow the exact format: zz-{sort_index}-{doc_name}.md
               - sort_index should be a two-digit number (01, 02, etc.)
               - doc_name should be kebab-case and descriptive

            4. OUTPUT FORMAT:
               - Generate clean, well-formatted Markdown
               - Use proper headings, lists, code blocks, and tables
               - Include a table of contents for longer documents
               - Add cross-references between related documentation

            Generate documentation that would be placed in a docs/ directory. Focus on creating documentation that will remain valuable even as implementation details change.
          ]]
        end,
      },
      vault = {
        name = "vault",
        description = "Write a concise, engaging, first-person markdown social media post explaining a technical concept.",
        shorthelp = "Create technical post",
        callback = function(_, _, cb)
          cb [[
            # Prompt for VAULT Command

            Create a concise, engaging, first-person markdown social media post that explains both the "why" and "how" of the technical concept or solution I've shared. Follow these guidelines:

            1. CONTENT STRUCTURE:
               - Begin with a hook that captures interest
               - Clearly explain why this concept matters
               - Provide a concise technical explanation
               - Include practical application or example
               - End with a thought-provoking conclusion

            2. STYLE REQUIREMENTS:
               - Write in first-person perspective
               - Use a conversational, authentic voice
               - Focus on educational value
               - Keep paragraphs short and scannable
               - Use markdown formatting effectively

            3. QUALITY STANDARDS:
               - Ensure technical accuracy
               - Avoid unnecessary jargon
               - Include no cringe elements or forced humor
               - Keep the total length under 500 words
               - Make complex concepts accessible without oversimplification

            The final output should be something a developer would be proud to share on platforms like Twitter, LinkedIn, or a technical blog. It should demonstrate expertise while remaining approachable and valuable to readers.
          ]]
        end,
      },
    },
    custom_tools = function()
      return {
        require "plugins.avante.commands.dev_test",
      }
    end,
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
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
