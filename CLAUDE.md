# 🤖 CLAUDE.md – Helper Prompt for LLM Agents

_Give this file to the language-model “assistant” that will work on this
repository. It explains the most important conventions, guard-rails, and context
needed to make productive, **safe** changes._

---

## 1. Big-Picture Overview

- **What this repo is**  
  A fully-featured **Neovim configuration** built on AstroNvim **v5**.  
  All user customisation lives under `lua/`, loaded by `init.lua` and managed
  through the **lazy.nvim** plugin manager.

- **Why you, the LLM, exist here**  
  • Add / update plugins  
  • Tweak key-mappings & options  
  • Maintain auxiliary tooling (tests, docs, CI)  
  • Keep everything conforming to the local style rules

---

## 2. Directory Landmarks

| Path                         | Purpose                                                |
| ---------------------------- | ------------------------------------------------------ |
| `init.lua`                   | Entry point – bootstrap AstroNvim & lazy.nvim          |
| `lua/lazy_setup.lua`         | lazy.nvim configuration & AstroNvim opts               |
| `lua/plugins/`               | **Plugin specifications** (one file per logical group) |
| `lua/plugins/*/`             | Helper modules / commands for a plugin                 |
| `lua/polish.lua`             | Final callback after plugins have loaded               |
| `README.md`                  | Human-facing overview                                  |
| **this `CLAUDE.md`**         | _You are here_ – agent helper prompt                   |
| `.stylua.toml / selene.toml` | Lua formatter & linter configs                         |
| `neovim.yml`                 | GitHub Actions CI                                      |

---

## 3. Key Conventions You **Must** Respect

1. **SEARCH/REPLACE workflow**  
   All edits are delivered as discrete _“SEARCH/REPLACE blocks”_ (see upstream
   prompt rules). Never edit read-only files unless the user adds them to the
   chat.

2. **Style & Static-analysis**  
   Run `stylua` and `selene` before committing. Follow existing indentation,
   naming, and table-style patterns.

3. **Plugin specification pattern**  
   Each plugin table may contain:

   ```lua
   return {
     "author/repo.nvim",
     event = "VeryLazy",
     version = false,
     opts = function(_, opts)  -- merge/override defaults
       -- …
     end,
   }
   ```

   _Do **not** mutate `opts` tables at the top level – always merge inside a
   function to allow user overrides._

4. **LSP, Treesitter, Mason, etc.**  
   Dedicated spec files live under `lua/plugins/`. Extend them by **adding
   items** instead of replacing the entire table.

5. **Slash-Commands via `avante.nvim`**  
   Custom prompts such as `/boot`, `/polish`, `/document`, `/vault` live
   in `lua/plugins/avante.lua`. Keep them deterministic: prompts go inside
   `[[ … ]]` multiline strings; callbacks must be idempotent.

6. **Testing helper tool**  
   The custom `<Leader>t` mappings rely on **vim-test**; programmatic execution
   is wrapped by `lua/plugins/avante/commands/dev_test.lua`.

7. **CI**  
   GitHub Actions runs `nvim --headless "+Lazy! sync"` plus lint/format checks.
   Ensure your changes keep CI green.

---

## 4. Typical Tasks & How to Perform Them

| Task                     | Steps for the LLM agent                                                |
| ------------------------ | ---------------------------------------------------------------------- |
| Add new plugin           | Create/modify file in `lua/plugins/…`, add lazy spec, run `:Lazy sync` |
| Change key-mapping       | Adjust `opts.mappings` in relevant plugin spec                         |
| Format / lint            | `stylua .` • `selene .` (repo root)                                    |
| Update docs              | Edit `README.md` or add file in `docs/`                                |
| Create helper Lua module | New file under `lua/…`; `require` it where needed                      |
| Remove plugin            | Delete spec & run `:Lazy clean`                                        |

---

## 5. Guard-Rails for Safe Code Changes

- **Small, focused commits** – atomic feature / fix.
- **No hard-coded OS paths** – use `vim.fn.stdpath`.
- **Lazy loading** – prefer `event`, `ft`, `cmd` to keep startup fast.
- **Check `vim.fn.has("nvim-0.10")`** when using bleeding-edge APIs.
- **Avoid global namespace pollution** – localise everything.

---

## 6. Quick Reference – Frequently Used APIs

```lua
local core = require "astrocore"          -- Core module for options & mappings
local map  = core.set.mappings

-- Example: add <Leader>bb to list buffers
map.n["<leader>bb"] = { "<cmd>Telescope buffers<cr>", desc = "Switch buffer" }
```

---

## 7. When in Doubt, Ask

If you aren’t 100 % certain which file to touch, **stop and ask** the user to
add that file’s content to the chat. Better safe than sorry.

---

## 8. Reference Links

| Tool / Library | Documentation / Homepage                   |
| -------------- | ------------------------------------------ |
| AstroNvim      | https://github.com/AstroNvim/AstroNvim     |
| avante.nvim    | https://github.com/yetone/avante.nvim      |
| lazy.nvim      | https://github.com/folke/lazy.nvim         |
| Neovim         | https://neovim.io/doc                      |
| Treesitter     | https://tree-sitter.github.io/tree-sitter/ |
| mason.nvim     | https://github.com/williamboman/mason.nvim |
| stylua         | https://github.com/JohnnyMorganz/StyLua    |
| selene         | https://github.com/Kampfkarren/selene      |
| vim-test       | https://github.com/vim-test/vim-test       |

---

## 9. Repo-specific Gotchas & Tips

- **`lua/polish.lua`** – Disabled by the guard line

  ```lua
  if true then return end
  ```

  Remove that line to activate the file’s post-setup logic (custom file-types, etc.).

- **`lua/lazy_setup.lua` import order** – Loads specs in this sequence:
  1. `astronvim.plugins` (core)
  2. `community` (AstroCommunity)
  3. `plugins` (your custom specs)  
     Add/override plugins in `lua/plugins/` – they are merged last.

- **Lint / Format rules** – Already configured:
  - `stylua.toml` → 2-space indent, 120-column width.
  - `selene.toml` → `std = "neovim"`, common Astro globals allowed.  
    Always run:

  ```bash
  stylua .
  selene .
  ```

- **Avante integration** – `lua/plugins/avante.lua` installs **avante.nvim** with
  slash-commands (`/boot`, `/polish`, `/document`, `/vault`) and registers the
  custom tool **`dev_test`** (`lua/plugins/avante/commands/dev_test.lua`).
  Keep these deterministic and idempotent when editing.

- **`init.lua` bootstrap** – Strictly bootstraps **lazy.nvim**. Heavy logic
  belongs in modules; touch this file only when necessary.

---

## 10. Cheat-Sheets for the Core Tools

### AstroNvim

- Layered distribution that **wraps lazy.nvim** with sane defaults
- Entry points: `init.lua` → `lua/lazy_setup.lua` (imports)
- Override defaults by **adding** specs; _never_ edit Astro’s own modules
- Key commands: `:AstroUpdate`, `:Lazy sync`, `:AstroReload`

### lazy.nvim

- Declarative plugin manager – every spec is just a Lua table
- Load-triggers: `event`, `ft`, `cmd`, `keys`, `lazy = true`
- Pin versions with `version = "*"`; opt-out with `version = false`
- Diagnostics: `:Lazy health`, UI: `:Lazy`

### avante.nvim

- Sidebar assistant that embeds LLM interactions into Neovim
- Slash commands live in `lua/plugins/avante.lua` (see `slash_commands`)
- Config keys: `behavior`, `windows`, provider-specific tables (`claude`, `openai`)
- Useful commands: `:AvanteToggle`, `/boot`, `/polish`, `/document`, `/vault`

### vim-test

- Universal wrapper around language-specific test runners
- Mappings prefixed under `<Leader>t` (see `lua/plugins/vim-test.lua`)
- Core commands: `:TestNearest`, `:TestFile`, `:TestLast`, `:TestSuite`

---

_Happy hacking!_ 🌟
