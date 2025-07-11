---@type LazySpec
return {
  "GeorgesAlkhouri/nvim-aider",
  optional = true,
  config = function()
    local api = require("nvim_aider").api
    local prompts = {
      boot = [[
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
]],
      polish = [[
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
]],
      document = [[
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
]],
      vault = [[
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
]],
    }

    local function send(text) api.send_to_terminal(text) end

    -- create user commands that forward the prompts to Aider
    vim.api.nvim_create_user_command("AiderBoot", function() send(prompts.boot) end, {})
    vim.api.nvim_create_user_command("AiderPolish", function() send(prompts.polish) end, {})
    vim.api.nvim_create_user_command("AiderDocument", function() send(prompts.document) end, {})
    vim.api.nvim_create_user_command("AiderVault", function() send(prompts.vault) end, {})
  end,
}
