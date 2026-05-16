# nvim-config

My personal Neovim configuration for Neovim 0.12+.

Plugins are managed with Neovim's built-in package manager via `vim.pack.add`, so there is no LazyVim or lazy.nvim dependency.

## Layout

- `lua/config/options.lua` for editor options
- `lua/config/keymaps.lua` for keymaps
- `lua/config/autocmds.lua` for autocmds
- `lua/config/plugins.lua` for plugin installation
- `lua/plugins/*.lua` for plugin setup by area

## Requirements

- Neovim 0.12+
- Git
- ripgrep

## Notes

- LSP is configured with built-in `vim.lsp` plus `nvim-lspconfig`
- Formatting uses `conform.nvim`
- UI, editor, and LSP behavior are split into small Lua modules