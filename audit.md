# Neovim Config Audit

**Full plugin inventory:** base16, lualine, noice, nvim-notify, which-key, tiny-glimmer, harpoon, nvim-tree, vim-tmux-navigator, telescope (+frecency, fzf), vim-abolish, tabular, snacks-nvim, indent-blankline, colorizer, web-devicons, illuminate, todo-comments, ~~render-markdown~~ **markview**, trouble, ~~spectre~~ **grug-far**, oil, vim-dirdiff, lazygit, fugitive, ~~gitgutter~~ **gitsigns**, diffview, resolve, luasnip, copilot, codecompanion, blink-cmp, treesitter, lsplens, lspsaga, lspconfig, nvim-lint, conform, vim-commentary, ts-context-commentstring, debugprint, nvim-vtsls, csvview.

---

## Done

### grug-far.nvim (replaces nvim-spectre)
- `base/_plugins.nix` — swapped `nvim-spectre` for `grug-far-nvim`
- `base/__config/lua/nvim-spectre.lua` — replaced config; keymap stays on `,as`; visual mode pre-fills search with word under cursor

### rsvp.nvim (custom derivation)
- `flake.nix` — added `plugin-rsvp-nvim` input (github:kivanceski/rsvp.nvim)
- `src/packages/vimPlugins/rsvp-nvim.nix` — custom derivation
- `base/_plugins.nix` — added `rsvp-nvim`
- `base/__config/lua/nvim-rsvp.lua` — new config; 250 WPM, 1 context word, `,R` to start (normal = whole buffer, visual = selection)

### markview.nvim (replaces render-markdown-nvim)
- `base/_plugins.nix` — swapped `render-markdown-nvim` for `markview-nvim`
- `base/__config/lua/nvim-render-markdown.lua` — replaced config; starts disabled, toggle stays on `,m`
- `hybrid_modes = {}` — fully rendered in normal mode (no raw-text flash on current line); insert mode shows raw for editing

### nvim-ufo + promise-async
- `base/_plugins.nix` — added `nvim-ufo`, `promise-async`
- `base/__config/lua/nvim-ufo.lua` — new config; providers: LSP → treesitter fallback; virtual text shows folded line count; `K` now peeks fold first, falls back to Lspsaga hover
- `base/__config/lua/nvim-treesitter.lua` — removed fold setup (ufo owns it now)
- `base/__config/lua/nvim-lspsaga.lua` — removed `K` binding (moved to ufo)

| Key | Action |
|-----|--------|
| `zR` | Open all folds |
| `zM` | Close all folds |
| `zr` | Open folds except kinds |
| `zm` | Close folds by level |
| `K` | Peek fold (or hover doc if not on a fold) |
| `za` | Toggle fold under cursor (built-in) |
| `zo` / `zc` | Open / close fold (built-in) |

### flash.nvim
- `light/_plugins.nix` — added `flash-nvim`
- `light/__config/lua/nvim-flash.lua` — new config file

| Key | Mode | Action |
|-----|------|--------|
| `s` | n, x, o | Jump anywhere on screen |
| `S` | n, x, o | Treesitter-aware selection |
| `r` | o | Remote action (operate on distant text without moving) |
| `R` | o, x | Treesitter search across buffer |

### gitsigns.nvim (replaces vim-gitgutter)
- `base/_plugins.nix` — swapped `vim-gitgutter` for `gitsigns-nvim`
- `base/__config/lua/nvim-gitsigns.lua` — new config file

Keymaps added under `,g` group:

| Key   | Action |
|-------|--------|
| `]h` / `[h` | Next / prev hunk |
| `,gs` | Stage hunk (also works in visual for partial staging) |
| `,gu` | Undo stage hunk |
| `,gr` | Reset hunk (also works in visual) |
| `,gS` | Stage entire buffer |
| `,gR` | Reset entire buffer |
| `,gp` | Preview hunk inline |
| `,gb` | Full blame for current line (float) |
| `,gB` | Toggle per-line blame (virtual text at EOL) |
| `,gd` | Diff this file against index |

---

## Plugins you're likely missing

### 1. flash.nvim — the biggest QoL gap
Fast screen-space navigation: type `s` then 2 chars and jump anywhere visible. Also enhances `/` search with jump labels. Replaced leap.nvim/hop.nvim in most modern configs.

### 2. gitsigns.nvim — replace vim-gitgutter
vim-gitgutter is the older tool; gitsigns is the current standard. Key extras: stage/reset individual hunks directly from the buffer, inline git blame (virtual text), word-diff in hunks. Far better integrated with the Neovim API.

### 3. nvim-ts-autotag — critical for the web variant
Auto-closes and auto-renames HTML/JSX/TSX tags using treesitter. Given the `web` variant with vtsls, this is a clear gap.

### 4. nvim-surround
Add/change/delete surrounding brackets, quotes, tags. `ys`, `cs`, `ds`. vim-abolish and tabular are present but nothing for surrounds. Works with treesitter text objects.

### 5. fidget.nvim
Shows LSP progress (indexing, loading) as unobtrusive virtual text in the bottom-right. Without it, LSP just silently works or silently hangs — you never know which.

### 6. inc-rename.nvim
LSP rename with a live-preview input float. The noice config already has `inc_rename = false` in presets, meaning it's anticipated. Worth enabling: see all rename changes before confirming.

### 7. yanky.nvim or neoclip.nvim
Yank history with telescope integration. `p` cycles through previous yanks. Incredibly useful when you've overwritten your clipboard.

---

## Plugins worth replacing

### vim-gitgutter → gitsigns.nvim
(covered above)

### nvim-spectre → grug-far.nvim
spectre has had a messy history (broken regex modes, awkward UX). grug-far is a newer project with a cleaner UI, actual undo support, and no dependency on sed/rg quirks. Direct replacement.

### vim-commentary → ts-comments.nvim
`nvim-ts-context-commentstring` is already present to fix JSX comment strings with vim-commentary — that's a known workaround. ts-comments.nvim (folke, 2024) handles this natively via treesitter with zero config. Removes the two-plugin dance.

---

## Underutilized: snacks-nvim

`snacks.lua` is just `require("snacks").setup({})`. Snacks is a plugin collection — with default empty config only `bigfile` is auto-enabled. There's a lot of unused value here:

| Snacks module     | Replaces                              |
|-------------------|---------------------------------------|
| `snacks.words`    | vim-illuminate (both currently active)|
| `snacks.indent`   | indent-blankline-nvim (both active)   |
| `snacks.lazygit`  | lazygit-nvim                          |
| `snacks.notifier` | nvim-notify                           |
| `snacks.dashboard`| nothing (no dashboard currently)      |
| `snacks.terminal` | no float terminal currently           |
| `snacks.picker`   | could supplement telescope            |
| `snacks.input`    | improves `vim.ui.input` (rename dialogs, etc.) |

At minimum: enable `snacks.words` and `snacks.indent` to consolidate, and `snacks.notifier` to drop nvim-notify. `snacks.dashboard` is low-effort and pleasant — shows recent files on startup.

---

## Priority order

1. **gitsigns** — replaces gitgutter, meaningful new capabilities
2. **nvim-ts-autotag** — pure win for web dev, zero config
3. **flash.nvim** — changes how you navigate entirely
4. **ts-comments.nvim** — removes the commentary + context-commentstring hack
5. **snacks.nvim proper config** — consolidation + free features
6. **fidget.nvim** — once you have it you can't go back
7. **nvim-surround** — fills an obvious gap
8. **grug-far** — when spectre annoys you enough
9. **inc-rename** — noice config is already waiting for it
10. **yanky/neoclip** — nice-to-have, not urgent
