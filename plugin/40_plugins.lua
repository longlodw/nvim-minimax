-- ┌─────────────────────────┐
-- │ Plugins outside of MINI │
-- └─────────────────────────┘
--
-- This file contains installation and configuration of plugins outside of MINI.
-- They significantly improve user experience in a way not yet possible with MINI.
-- These are mostly plugins that provide programming language specific behavior.
--
-- Use this file to install and configure other such plugins.

-- Make concise helpers for loading config in two stages
local now_if_args, later = Config.now_if_args, Config.later

-- Semantic tokens =============================================================

-- Prefer semantic syntax highlighting from attached language servers.
-- Tree-sitter highlighting is managed separately via 'tree-sitter-manager.nvim'.
--
-- Troubleshooting:
-- - Run `:checkhealth vim.lsp` to verify LSP is configured correctly.
-- - Use `:Inspect` on a symbol to verify `@lsp.*` highlight groups are active.
now_if_args(function()
  local enable_semantic_tokens = function(ev)
    vim.lsp.semantic_tokens.enable(true, { bufnr = ev.buf })
  end
  Config.new_autocmd('LspAttach', nil, enable_semantic_tokens, 'Enable semantic tokens')
end)

-- Tree-sitter parser management ===============================================

-- Manage Tree-sitter parsers with 'romus204/tree-sitter-manager.nvim'.
-- Use `:TSManager` to install/update/remove parsers.
later(function()
  require('tree-sitter-manager').setup({
    ensure_installed = { 'lua', 'vim', 'vimdoc', 'markdown' },
    auto_install = true,
    highlight = true,
  })
end)

-- Language servers ===========================================================

-- Language Server Protocol (LSP) is a set of conventions that power creation of
-- language specific tools. It requires two parts:
-- - Server - program that performs language specific computations.
-- - Client - program that asks server for computations and shows results.
--
-- Here Neovim itself is a client (see `:h vim.lsp`). Language servers need to
-- be installed separately based on your OS, CLI tools, and preferences.
--
-- Neovim's team collects commonly used configurations for most language servers
-- inside 'neovim/nvim-lspconfig' plugin.
--
-- This config uses Mason for server installation and mason-lspconfig for wiring.
--
-- Add it now if file (and not 'mini.starter') is shown after startup.
--
-- Troubleshooting:
-- - Run `:checkhealth vim.lsp` to see potential issues.
now_if_args(function()
  require('mason').setup()
  require('mason-lspconfig').setup({
    -- Install these language servers automatically.
    -- Add more server names from `:help lspconfig-all` as needed.
    ensure_installed = { 'lua_ls' },
    -- Automatically enable installed servers using 'nvim-lspconfig'.
    automatic_enable = true,
  })
end)

-- Formatting =================================================================

-- Programs dedicated to text formatting (a.k.a. formatters) are very useful.
-- Neovim has built-in tools for text formatting (see `:h gq` and `:h 'formatprg'`).
-- They can be used to configure external programs, but it might become tedious.
--
-- The 'stevearc/conform.nvim' plugin is a good and maintained solution for easier
-- formatting setup.
later(function()
  -- See also:
  -- - `:h Conform`
  -- - `:h conform-options`
  -- - `:h conform-formatters`
  require('conform').setup({
    default_format_opts = {
      -- Allow formatting from LSP server if no dedicated formatter is available
      lsp_format = 'fallback',
    },
    -- Map of filetype to formatters
    -- Make sure that necessary CLI tool is available
    -- formatters_by_ft = { lua = { 'stylua' } },
  })
end)

-- File explorer ===============================================================

-- 'stevearc/oil.nvim' provides an editable file explorer in a floating window
-- or split and can replace default netrw behavior.
later(function()
  require('oil').setup({
    default_file_explorer = true,
  })
end)

-- AI completion ===============================================================

-- 'zbirenbaum/copilot.lua' provides inline GitHub Copilot suggestions.
-- Enable support for all filetypes, including markdown, yaml, and gitcommit.
later(function()
  require('copilot').setup({
    panel = {
      enabled = false,
    },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      hide_during_completion = true,
      keymap = {
        accept = '<C-y>',
        accept_word = '<M-w>',
        accept_line = false,
      },
    },
    filetypes = {
      ['*'] = true,
      ['.'] = true,
      markdown = true,
      yaml = true,
      gitcommit = true,
      gitrebase = true,
      hgcommit = true,
      svn = true,
      cvs = true,
      help = true,
    },
  })

  vim.keymap.set('i', '<M-CR>', function() require('copilot.suggestion').accept() end,
    { desc = 'Copilot accept suggestion' })
end)

-- Git integrations ============================================================

-- 'lewis6991/gitsigns.nvim' provides per-line Git signs, hunk actions, and
-- optional inline current-line blame text.
later(function()
  require('gitsigns').setup({
    current_line_blame = true,
  })
end)

-- Snippets ===================================================================

-- Although 'mini.snippets' provides functionality to manage snippet files, it
-- deliberately doesn't come with those.
--
-- The 'rafamadriz/friendly-snippets' is currently the largest collection of
-- snippet files. They are organized in 'snippets/' directory (mostly) per language.
-- 'mini.snippets' is designed to work with it as seamlessly as possible.
-- See `:h MiniSnippets.gen_loader.from_lang()`.
-- Plugin is declared in 'init.lua' and loaded by lazy.nvim.

-- Honorable mentions =========================================================

-- Beautiful, usable, well maintained color schemes outside of 'mini.nvim' and
-- have full support of its highlight groups. Use if you don't like 'tokyonight'
-- enabled in 'plugin/30_mini.lua'.
-- Config.now(function()
--  -- Install only those that you need
--  add({
--    'https://github.com/sainnhe/everforest',
--    'https://github.com/Shatur/neovim-ayu',
--    'https://github.com/ellisonleao/gruvbox.nvim',
--  })
--
--   -- Enable only one
--   vim.cmd('color everforest')
-- end)
