# nvim-minimax

Lean Neovim config focused on `mini.nvim`, with practical extras for LSP, formatting, Git, mini.files, and Copilot.

## What this config includes

- `mini.nvim` as the core UX layer (statusline, pickers, snippets, surround, key clues, etc.).
- LSP via `nvim-lspconfig` + `mason.nvim` + `mason-lspconfig.nvim`.
- Semantic token highlighting from LSP (no custom `@lsp.type.*` relinking).
- Tree-sitter parser management via `romus204/tree-sitter-manager.nvim`.
- Formatting via `conform.nvim`.
- Git workflow via `gitsigns.nvim` + `vim-fugitive`.
- File explorer via `mini.files` (`<Leader>ee`).
- GitHub Copilot via `copilot.lua` with inline suggestions enabled for all filetypes.
- Clipboard integrated with the OS via `vim.o.clipboard = 'unnamedplus'`.

## Requirements

- Neovim 0.11+ recommended.
- `git`.
- `tree-sitter` CLI (for parser installation).
- C compiler (`gcc`/`clang`) to build parsers.
- `ripgrep` (used by file/grep pickers).
- Clipboard provider for your platform:
  - Wayland: `wl-clipboard`
  - X11: `xclip` or `xsel`

## Install

```bash
git clone <your-repo-url> "$HOME/.config/nvim-minimax"
NVIM_APPNAME=nvim-minimax nvim
```

`lazy.nvim` bootstraps automatically on first launch.

## Validate

```bash
NVIM_APPNAME=nvim-minimax nvim --headless +qa
```

## Layout

- `init.lua`: bootstrap, lazy setup, plugin list.
- `plugin/10_options.lua`: Neovim options.
- `plugin/20_keymaps.lua`: custom keymaps.
- `plugin/30_mini.lua`: enabled `mini.nvim` modules.
- `plugin/40_plugins.lua`: non-mini plugins (LSP, formatting, Git, Copilot).
- `after/`: filetype/LSP/snippet overrides.
- `snippets/`: user snippets.

## Keymap quickstart

Leader is `<Space>`.

- **Buffer**: `<Leader>ba` alternate, `<Leader>bd` delete, `<Leader>bw` wipeout.
- **Explore/Edit**: `<Leader>ee` mini.files explorer, `<Leader>ei` edit `init.lua`.
- **Find**: `<Leader>ff` files, `<Leader>fg` live grep, `<Leader>fb` buffers, `<Leader>fr` resume picker.
- **Git**: `<Leader>gd` diff, `<Leader>ga` staged diff, `<Leader>gs` line blame, visual `<Leader>gs` stage hunk.
- **Language**: `<Leader>la` code actions, `<Leader>lr` rename, `<Leader>ld` diagnostic float, `<Leader>lf` format.

Useful defaults from this config:

- `<C-h/j/k/l>` window navigation.
- Insert completion: `<Tab>`/`<S-Tab>` navigate, `<CR>` accepts current completion item.
- Copilot: insert `<M-CR>` accepts current suggestion.

## Notes on clipboard

This config sets:

```lua
vim.o.clipboard = 'unnamedplus'
```

So normal yank/paste uses the system clipboard (`+` register) by default. Copying in Neovim should paste in other apps, and vice versa.

If clipboard does not work, run:

```vim
:checkhealth
```

and ensure your OS clipboard tool is installed.

## Plugin management

- `:Lazy` open plugin UI.
- `:Lazy sync` install missing plugins and update lockfile.
- `:Lazy update` update plugins.
