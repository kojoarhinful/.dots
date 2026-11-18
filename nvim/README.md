## Neovim

The config I used when I tried Neovim for two or three months. I moved to
Helix afterwards, so this is kept for reference and is not actively maintained.

### What the pieces do

- **lazy.nvim** - plugin manager. Clones itself on first launch.
- **mason.nvim** - installs and manages external tools such as language servers.
  `mason-lspconfig.nvim` connects those servers to Neovim's LSP client.
- **nvim-lspconfig** - default configs for each language server.
- **blink.cmp** - completion menu.
- **conform.nvim** - formatting. Run it with `Space cf`.
- **telescope.nvim** - fuzzy finder (`Space ff` files, `Space fg` grep, etc.).
- **nvim-treesitter** - syntax highlighting.
- **nvim-autopairs** - closes brackets automatically.
- **undotree** - visual undo history.
- **vitesse.nvim** - colorscheme.
- **supermaven-nvim** - inline AI suggestions.

### Requirements

- Neovim 0.11+ (the config uses `vim.lsp.enable`)
- Lazy.nvim clones plugins
- Mason installs `clangd`, `rust_analyzer`, `gopls`, and `ts_ls` on first launch

### The keymaps I actually use

**`Space t`** opens a terminal in a 21-line split at the bottom.
**`Space tt`** opens a terminal in the current window.

**`Space u`** toggles the undo tree, so you can see and jump through the file's
undo history instead of pressing `u` repeatedly.

**`Space e`** toggles netrw. It opens the explorer in the current file's
directory with the cursor on that file. Pressing `Space e` again closes it and
takes you back to the file at the same position. See `lua/configs/netrw.lua`.

### Notes

- `supermaven-nvim` and `blink.cmp` both use `Tab`, so they can conflict.
- `Space fp` looks for projects in `~/space`. Change that path in
  `lua/configs/keymaps.lua` (`cwd = vim.fn.expand("~/space")`).
