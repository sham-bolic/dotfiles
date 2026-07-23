# Shortcuts Reference

Centralized cheat sheet for every custom keybinding across this dotfiles setup.
Leader key in Neovim is **Space**.

## Neovim - Core (`keys.lua` / `vim_config.lua`)

| Key | Mode | Action |
|---|---|---|
| `<Esc>` | Normal | Save file (`:w`) |
| `<C-a>` | Normal | Select all (`ggVG`) |
| `p` over a visual selection | Visual | Paste without clobbering clipboard (keeps yanked text) |

Core options worth remembering: `relativenumber` is on (use `5j` / `8k` style relative jumps), `scrolloff=16` keeps the cursor away from screen edges, `undofile` gives persistent undo across sessions, clipboard is shared with the system (`unnamedplus`).

## Neovim - Find / Files (snacks.nvim, oil.nvim)

| Key | Action |
|---|---|
| `<leader>e` | Open file browser (Oil) |
| `<leader>f` | Find files (Snacks picker) |
| `<leader>s` | Search text / grep (Snacks picker) |
| `<leader>b` | List open buffers (Snacks picker) |
| `gd` | Goto LSP definition (Snacks picker) |

## Neovim - Git (neogit, diffview, gitsigns)

| Key | Action |
|---|---|
| `<leader>g` | Open Neogit (status/commit UI) |
| `<leader>gd` | Open repo-wide diff view (Diffview) |
| `<leader>gD` | Close diff view |
| `<leader>gp` | Preview hunk under cursor (gitsigns) |
| `<leader>gx` | Toggle deleted lines shown inline (gitsigns) |
| `]h` | Jump to next git hunk |
| `[h` | Jump to previous git hunk |

`current_line_blame` is enabled, so gitsigns shows an inline blame virtual-text automatically.

## Neovim - LSP (nvim-lspconfig, mason)

| Key | Mode | Action |
|---|---|---|
| `K` | Normal | Hover docs |
| `gr` | Normal | List references |
| `gi` | Normal | Goto implementation |
| `<leader>rn` | Normal | Rename symbol |
| `<leader>ca` | Normal/Visual | Code action |
| `]d` | Normal | Next diagnostic |
| `[d` | Normal | Previous diagnostic |

LSP servers installed via mason: `lua_ls`, `ts_ls`, `pyright`, `ruff` (plus `nixd`, installed via nixpkgs outside mason). Format-on-save is enabled (conform.nvim) using `stylua` (Lua), `prettier` (JS/TS/JSON), `ruff_format` (Python), `alejandra` (Nix).

## Neovim - Completion (blink.cmp)

Uses the `default` blink.cmp keymap preset:

| Key | Action |
|---|---|
| `<C-space>` | Open/trigger completion menu |
| `<C-n>` / `<Down>` | Next completion item |
| `<C-p>` / `<Up>` | Previous completion item |
| `<C-y>` / `<Tab>` | Accept selected item |
| `<C-e>` | Cancel completion |
| `<C-k>` | Toggle signature help |

Sources: LSP, path, snippets, buffer.

## Neovim - Closing Plugin Windows

No single universal key closes every plugin window - each one has its own convention:

| Plugin | How to close |
|---|---|
| Oil (`<leader>e`) | `<C-c>` closes the file browser back to your previous buffer |
| Snacks picker (`<leader>f`, `<leader>s`, `<leader>b`) | `<Esc>` closes the picker |
| Neogit (`<leader>g`) | `q` closes the status buffer |
| Diffview (`<leader>gd`) | `<leader>gD` (already mapped) or `:DiffviewClose` |
| which-key popup | `<Esc>`, or it auto-dismisses after you complete/abandon the key sequence |
| render-markdown view | `<leader>m` toggles it off (it's a rendering mode, not a separate window) |

General fallback for an unrecognized plugin window/split: `q` (most read-only/list buffers), `<Esc>` (pickers/prompts), or `<C-w>c` (force-close the current window).

## Neovim - Treesitter Textobjects

| Key | Mode | Selects/Moves |
|---|---|---|
| `af` / `if` | Visual/Op-pending | Function outer/inner |
| `ac` / `ic` | Visual/Op-pending | Class outer/inner |
| `aa` / `ia` | Visual/Op-pending | Argument (parameter) outer/inner |
| `]f` / `[f` | Normal/Visual/Op-pending | Next/previous function start |
| `]c` / `[c` | Normal/Visual/Op-pending | Next/previous class start |
| `<leader>a` | Normal | Swap current argument with next |
| `<leader>A` | Normal | Swap current argument with previous |

## Neovim - Markdown Preview (render-markdown.nvim)

| Key | Action |
|---|---|
| `<leader>m` | Toggle rendered markdown view (in `.md` files) |

Markdown files render inline automatically on open (styled headers, list bullets, checkboxes, bordered code blocks) - no browser needed. Toggle with `<leader>m` when you need the raw text (e.g. to edit a table cleanly).

## Neovim - UI

- `which-key.nvim` is active - hold `<leader>` (or any prefix key) and pause to see a popup of every available binding under that prefix. This is the fastest way to discover bindings not listed here.
- Statusline is `lualine.nvim` (rose-pine theme): shows mode, git branch/diff, filename, diagnostics, filetype, cursor location, and scroll progress.
- Colorscheme: `rose-pine` (moon variant), with transparency enabled on macOS.

## Neovim - Built-in Vim Basics (not remapped, but essential)

| Key | Action |
|---|---|
| `i` / `a` | Insert before/after cursor |
| `o` / `O` | Open new line below/above |
| `dd` / `yy` / `p` | Delete/yank/paste line |
| `x` | Delete character |
| `u` / `<C-r>` | Undo / redo |
| `/` / `?` | Search forward/backward |
| `n` / `N` | Repeat search forward/backward |
| `:%s/foo/bar/g` | Substitute across file |
| `gg` / `G` | Go to top/bottom of file |
| `<C-o>` / `<C-i>` | Jump back/forward in jumplist |
| `zz` | Center cursor line on screen |
| `.` | Repeat last change |
| `ci"` / `ci(` / `cit` | Change inside quotes/parens/tag |
| `<C-w>` + `hjkl` | Move between splits |
| `:vsp` / `:sp` | Vertical/horizontal split |

## WezTerm

No custom keybindings are configured in `wezterm.lua` - it only sets appearance (rose-pine-moon theme, Hack Nerd Font, opacity/blur, resize-only decorations). WezTerm's **default** keys apply, the most useful:

| Key | Action |
|---|---|
| `Cmd+T` | New tab |
| `Cmd+W` | Close pane/tab |
| `Cmd+D` | Split pane vertically (right) |
| `Cmd+Shift+D` | Split pane horizontally (down) |
| `Cmd+[` / `Cmd+]` | Previous/next tab |
| `Cmd+1..9` | Jump to tab N |
| `Cmd+Enter` | Toggle pane zoom |
| `Cmd+K` | Clear scrollback |
| `Cmd+F` | Search scrollback |
| `Cmd+Shift+Space` (hold) | Enter quick-select / copy mode (varies by config default) |

If you want custom WezTerm bindings, they'd go in `config.keys = { ... }` in `wezterm.lua` - none defined yet.

## Claude Code (CLI)

Not configured via a custom `keybindings.json` in this dotfiles repo (none exists) - these are Claude Code's built-in defaults:

| Key | Action |
|---|---|
| `Esc` | Interrupt/cancel current turn |
| `Esc` `Esc` | Jump back to edit a previous message |
| `Ctrl+C` | Cancel input / exit |
| `Ctrl+R` | Toggle verbose/expanded output |
| `Shift+Tab` | Cycle permission mode (e.g. auto-accept edits) |
| `!<command>` | Run a shell command directly in the session |
| `/<skill>` | Invoke a slash command / skill |
| `Up` / `Down` | Navigate input history |

Useful slash commands configured/available in this setup: `/code-review`, `/security-review`, `/loop`, `/schedule`, `/review`, `/run`, `/init`.

## Raycast

`raycast.rayconfig` in this repo is Raycast's exported (binary/encrypted) settings blob - hotkeys aren't human-readable from it. Raycast hotkeys live in the app itself: **Raycast Preferences -> Hotkey** for the global trigger (commonly `Cmd+Space` or `Option+Space`), and per-extension hotkeys under **Preferences -> Extensions**. Check there directly rather than this file if you need to look one up or change one.
