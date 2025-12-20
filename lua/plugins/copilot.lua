-- Override copilot.lua to use system Node instead of shadowenv Node
return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      copilot_node_command = "/opt/homebrew/bin/node", -- Use system Node (latest)
    },
  },
}
