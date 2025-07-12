# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is an AstroNvim v5+ configuration repository. AstroNvim is a Neovim configuration framework that provides a structured way to manage plugins, settings, and customizations.

## Development Commands

### Formatting
- `nix fmt` - Format all files using treefmt-nix (formats .nix, .lua, .json, .md, .yml, .toml files)
- `stylua .` - Format Lua files specifically using StyLua

### Linting
- Selene linter is configured via `selene.toml` but not currently installed
- Global vim usage and mixed table rules are allowed per selene configuration

### Development Environment
- `nix develop` - Enter development shell with formatting tools
- `nix flake check` - Run formatting checks

### Neovim Testing
- `nvim` - Launch Neovim with this configuration
- Configuration changes require restarting Neovim to take effect

## Architecture

### Core Structure
- `init.lua` - Bootstrap file that sets up Lazy.nvim and loads core modules
- `lua/lazy_setup.lua` - Lazy.nvim configuration and plugin specifications
- `lua/community.lua` - AstroCommunity module imports (currently disabled)
- `lua/polish.lua` - Final setup hooks (currently disabled)

### Plugin Configuration
- `lua/plugins/` - Individual plugin configurations
  - `astrocore.lua` - Core AstroNvim features and mappings (currently disabled)
  - `astrolsp.lua` - LSP configuration
  - `astroui.lua` - UI customizations
  - `mason.lua` - Mason tool installer configuration
  - `none-ls.lua` - null-ls (none-ls) configuration
  - `treesitter.lua` - Treesitter configuration
  - `user.lua` - User-specific plugin additions

### Key Configuration Notes
- Most plugin files are currently disabled with `if true then return {} end`
- Leader key is set to space, local leader to comma
- Configuration uses AstroNvim's structured approach with LazySpec format
- Icons are enabled (requires Nerd Font)

### Lazy.nvim Integration
- Uses Lazy.nvim for plugin management
- Plugins are loaded from three sources:
  1. AstroNvim core plugins
  2. AstroCommunity modules (via `community.lua`)
  3. User plugins (via `plugins/` directory)

## File Configuration
- `neovim.yml` - Lua language server configuration for Neovim globals
- `selene.toml` - Selene Lua linter configuration
- `flake.nix` - Nix flake for development environment and formatting tools
- `lazy-lock.json` - Lazy.nvim lockfile for plugin versions

## Activating Configuration
To activate disabled configuration files, remove the line `if true then return {} end` from:
- `lua/community.lua`
- `lua/polish.lua`
- `lua/plugins/astrocore.lua`
- Any other plugin files as needed