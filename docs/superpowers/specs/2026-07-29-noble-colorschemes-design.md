# Noble: two aristocratic gold colorschemes

Date: 2026-07-29

Two sibling themes — gold text on dark indigo, gold text on rich brown — delivered for
Neovim, Alacritty and Yazi, wired into the existing `super + F9` theme switcher.

## Aesthetic decisions

Four decisions, settled during brainstorming, that everything else follows from:

1. **Near-monochrome.** Hue is locked to the gold family. Tokens separate by lightness and
   by `bold`/`italic`, never by hue. Only diagnostics, git signs and diffs leave the family.
   This matches the user's existing collection (`accent.vim`, `vim-256noir`, `austere`,
   `komau`, `vim-boring`, `coal`, `vim-colors-off`, `plain`, `fogbell`).
2. **Mid-depth backgrounds.** Dark enough that gold glows, light enough that indigo reads as
   indigo and brown reads as brown. Both themes sit at the same depth so they feel matched.
3. **Gold retuned per background.** Same lightness ladder and same role structure in both,
   but the brown theme's gold shifts cooler toward champagne-ivory. On cool indigo, warm gold
   is complementary and pops; on warm brown, the identical gold would sit inside the
   background's own hue family and go muddy even at equal contrast ratio.
4. **Muted jewel accents.** Garnet, amber, verdigris, sage — real hues, desaturated enough
   that they never shatter the monochrome field. Diffs are background washes only, so gold
   text keeps its own color inside a diff.

## The ladder rule

One rule, applied identically to both themes: **hue is fixed, lightness encodes importance.**

| rung | role | gets |
|---|---|---|
| `bright` | scan targets | functions, headings, titles, matched parens, constants (bold) |
| `string` | lifted | strings, characters, raw markup — slightly above base so quoted text lifts |
| `base` | substance | Normal, variables, members, properties, operators |
| `type` | grammar | types, structures, typedefs, attributes |
| `brass` | keywords | keywords, conditionals, repeats, preproc, special |
| `dim` | secondary | builtin variables (italic), modules, folded text, WinBarNC |
| `comment` | aside | comments (italic) |
| `punct` | scaffolding | punctuation, brackets, delimiters, LineNr |
| `faint` | invisible-ish | NonText, EndOfBuffer, Conceal, FoldColumn, indent guides |

The two `sl_*` keys sit outside the ladder: `sl_bg`/`sl_fg` are `StatusLine` only.
`StatusLineNC` uses `sl_bg` with `dim` text. These are separate because `transparent.nvim`
is configured to exclude `StatusLine` and `StatusLineNC`, so they must stay legible even
when every other background is stripped.

`bold` marks only constants and booleans. `italic` marks only comments and `builtin`
variants. Nothing else uses attributes, so both stay meaningful.

## Palettes

Identical key sets, so `load()` is a pure function of whichever table it is handed.

### `noble-ink` — warm old-gold on indigo

```
surfaces                      gold ladder              accents
bg           #14162E          bright   #F0E2BE         garnet    #B8555E
bg_light     #1B1E3C          base     #DCCBA0         amber     #D9A85C
bg_float     #191C36          string   #E8D4A8         verdigris #6E9188
bg_visual    #2A2E52          type     #D8C08A         sage      #8A9A78
border       #4A4E7A          brass    #C4A469
indent       #22254A          dim      #A88F5E         diff washes
indent_scope #3A3E66          comment  #8A7548         add  #16241B
sl_bg        #22254A          punct    #7E6C48         del  #2A1418
sl_fg        #DCCBA0          faint    #5E5238         chg  #16203A
                                                       text #1F2C4E
```

### `noble-leather` — cool champagne on brown

```
surfaces                      champagne ladder         accents
bg           #241811          bright   #F2EAD3         garnet    #B85A52
bg_light     #2E2017          base     #DED5B6         amber     #D9AE68
bg_float     #2A1D15          string   #E9DDBF         verdigris #6F938C
bg_visual    #3E2C1E          type     #D5C9A4         sage      #8C9B79
border       #5A4433          brass    #C0B287
indent       #33251A          dim      #A79B78         diff washes
indent_scope #4A3726          comment  #90886A         add  #1E2417
sl_bg        #33251A          punct    #837B60         del  #2E1815
sl_fg        #DED5B6          faint    #625C48         chg  #2A2418
                                                       text #3A3020
```

### Measured contrast

WCAG ratios against each theme's own `bg`, as measured by the verification pass from the
shipped palette (not hand-computed):

| role | ink | leather | delta |
|---|---|---|---|
| `bright` | 13.79:1 | 14.41:1 | 0.62 |
| `string` | 12.17:1 | 12.82:1 | 0.64 |
| `base` | 11.06:1 | 11.78:1 | 0.72 |
| `type` | 9.99:1 | 10.48:1 | 0.49 |
| `brass` | 7.48:1 | 8.21:1 | 0.72 |
| `dim` | 5.71:1 | 6.26:1 | 0.56 |
| `comment` | 3.99:1 | 4.87:1 | 0.89 |
| `punct` | 3.48:1 | 4.09:1 | 0.61 |
| `faint` | 2.31:1 | 2.59:1 | 0.28 |

The verification pass asserts every readable role clears 4.5:1 and that no role's `delta`
between the two themes exceeds 1.2, so the siblings cannot drift apart.

`faint` is intentionally sub-threshold — it is scaffolding (indent guides, `EndOfBuffer`)
that should be perceptible without being readable.

The two themes are deliberately kept within a rung of each other so switching between them
does not change how hard the eye works.

## Neovim

### Files

```
lua/noble/palette.lua                 pure data: { ink = {...}, leather = {...} }, no nvim calls
lua/noble/init.lua                    M.load("ink"|"leather") -> 493 nvim_set_hl calls
lua/noble/lualine.lua                 M.build(name) -> lualine theme from the same palette
colors/noble-ink.lua                  entry point
colors/noble-leather.lua              entry point
lua/lualine/themes/noble-ink.lua      lualine theme='auto' resolves via colors_name
lua/lualine/themes/noble-leather.lua
```

The two `lua/lualine/themes/*` files are one-line shims delegating to
`noble.lualine.build`, so statusline colors are derived from the same palette table rather
than being a second set of hardcoded hexes that could drift.

`load` also sets `vim.g.terminal_color_0`–`15` to mirror the Alacritty ANSI palette, so
`:terminal` inside Neovim matches the host terminal.

`M.load` takes a palette *name*, looks the table up in `noble.palette`, and derives every
highlight group from it — so the group definitions exist exactly once and both themes are
guaranteed to have identical structure.

Three units with clean boundaries: the palette is testable data with no side effects, `load`
is a total function of one palette table, and `colors/*` are shims. A third sibling later is
one new palette table and nothing else.

Plain `nvim_set_hl`, matching the house style of the existing `colors/fresh-days.lua`. The
installed `lush.nvim` is deliberately not used — no reason to give a colorscheme a load-time
dependency.

### Entry point shape

```lua
vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end
vim.opt.background = "dark"
vim.g.colors_name = "noble-ink"
package.loaded["noble"] = nil          -- so palette edits show on re-:colorscheme
package.loaded["noble.palette"] = nil
require("noble").load("ink")
```

The cache busting is for tuning: edit a hex, re-run `:colorscheme noble-ink`, see it. Cost is
negligible next to the `nvim_set_hl` calls themselves.

### `init.lua` is not modified

The user is staying on `colorscheme accent` for now and will try these with `:colorscheme`.

The two existing manual overrides at `init.lua:1267-1268` (`LineBreakpoint` at `#511111`,
`DapStopped` at `#31353f`) are therefore **left in place**. Instead both groups are defined
*inside* each noble scheme, retoned per theme. Since a colorscheme's `hi clear` wipes custom
groups anyway, this is the only correct place for them — and it leaves `accent` behavior
completely untouched.

### Group coverage

Everything `fresh-days.lua` covers — base UI, statusline/tabline/winbar, Pmenu, search,
diff, diagnostics, standard syntax, treesitter, LSP semantic tokens — plus the groups the
current plugin set actually renders:

- **snacks.nvim** — `SnacksPicker*`, `SnacksDashboard*`, `SnacksNotifier*`, `SnacksInput*`,
  `SnacksIndent`, `SnacksIndentScope`, `SnacksWords*`, `SnacksStatusColumn*`
- **blink.cmp** — `BlinkCmpMenu`, `MenuBorder`, `MenuSelection`, `Label`, `LabelMatch`,
  `Kind*`, `Doc`, `DocBorder`, `SignatureHelp`
- **render-markdown.nvim** — `RenderMarkdownH1`–`H6` (+`Bg`), `Code`, `Bullet`, `Quote`,
  `TableHead`, `TableRow`, `Dash`, `Link`
- **aerial.nvim** — `AerialLine`, `AerialGuide`, `Aerial*Icon`
- **git-conflict.nvim** — `GitConflictCurrent`, `Incoming`, `Ancestor` (+ `*Label`)
- **nvim-dap** + **dap-ui** + **dap-virtual-text** — `DapBreakpoint`, `DapLogPoint`,
  `DapStopped`, `LineBreakpoint`, the `DapUI*` set, `NvimDapVirtualText*`
- **vim-matchup** — `MatchWord`, `MatchParenCur`, `MatchWordCur`
- **gitsigns** — add/change/delete, topdelete, changedelete, staged variants
- **telescope**, **trouble**, **floaterm**, **mini.icons** (`MiniIcons*`)
- **git-blame.nvim** — `GitBlameVirtualText` set explicitly to `faint` rather than left
  linked to `Comment`
- **lsp_lines** and **actions-preview** need nothing of their own: they ride the
  `DiagnosticVirtualText*` and float groups respectively

`nvim-colorizer` generates its own highlights and needs no coverage.

Accent assignment: `DiagnosticError`/`GitSignsDelete` → garnet, `DiagnosticWarn`/
`GitSignsChange` → amber, `DiagnosticInfo` → verdigris, `DiagnosticHint`/`GitSignsAdd` →
sage.

Search uses three escalating tiers rather than the two originally specified — `Search` on
brass, `CurSearch` on amber, `IncSearch` on `bright`, all inverted to `bg` text. Putting
`Search` and `CurSearch` both on amber would have made the focused match indistinguishable
from the rest.
`Visual` is a lifted `bg_visual` with gold text left unchanged.

## Alacritty

Real files in `~/dotfiles/alacritty/.config/alacritty/`, relative-symlinked into
`~/.config/alacritty/` — matching the existing `dec_*.toml` convention exactly:

```
dec_noble_ink.toml
dec_noble_leather.toml
```

Named `dec_*` so `theme-switch`'s existing `dec_[a-z_]+` regexes keep working with no logic
change. The prefix has already drifted from meaning "DEC VT220 phosphor" — `dec_gray_light`
is not a phosphor either — so it now reads as a namespace for the user's own themes.

Structure follows the existing files: a bare `[colors]` table carrying
`draw_bold_text_with_bright_colors = false` first (TOML requires it before its sub-tables),
then `primary`, `cursor`, `vi_mode_cursor`, `selection`, `search.matches`,
`search.focused_match`, `footer_bar`, `hints.start`, `hints.end`, `normal`, `bright`.

### ANSI palette

`dec_amber` collapses all 16 slots to amber, which suits phosphor cosplay but destroys
`git diff`, `ls` colors and fzf highlighting in the terminal. Since the Neovim side uses
muted jewel accents, the same accents carry into ANSI, with black and white slots taken from
the gold ladder:

| slot | ink normal | ink bright | leather normal | leather bright |
|---|---|---|---|---|
| black | `#1B1E3C` | `#4A4E7A` | `#2E2017` | `#5A4433` |
| red | `#B8555E` | `#C97078` | `#B85A52` | `#CA7168` |
| green | `#8A9A78` | `#A0B08C` | `#8C9B79` | `#A3B08D` |
| yellow | `#C4A469` | `#D9A85C` | `#C0B287` | `#D9AE68` |
| blue | `#6B7A9E` | `#8595B8` | `#6E8394` | `#879AAB` |
| magenta | `#8E7A9E` | `#A894B8` | `#A07E86` | `#B7969D` |
| cyan | `#6E9188` | `#86A9A0` | `#6F938C` | `#88A8A1` |
| white | `#DCCBA0` | `#F0E2BE` | `#DED5B6` | `#F2EAD3` |

ANSI needs six hues where the Neovim palette has four, so blue and magenta are extrapolated:
amethyst on indigo (coherent with that background), dusty rose on brown.

Note: `alacritty.toml` sets `opacity = 0.95` globally, so both backgrounds blend slightly
with whatever is behind the window. The indigo in particular will shift with the wallpaper.

## Yazi

Real directories in `~/dotfiles/yazi/.config/yazi/flavors/`, relative-symlinked into the
upstream `yazi-rs/flavors` clone at `~/.config/yazi/flavors/` where they show as untracked —
matching how the existing five `dec-*.yazi` flavors are handled, which keeps them alive
across a re-clone of upstream:

```
dec-noble-ink.yazi/{flavor.toml,tmtheme.xml}
dec-noble-leather.yazi/{flavor.toml,tmtheme.xml}
```

`flavor.toml` follows `dec-green.yazi`'s structure and its convention of using ANSI color
*names* for the marker and count groups, so those track the Alacritty palette automatically
rather than duplicating hexes.

`tmtheme.xml` (1509 lines, driving file-preview syntax colors) is derived from
`dec-green.yazi`'s by remapping its bounded set of palette hexes onto the gold ladder, not
authored from scratch — mechanical and diff-verifiable.

**Finding, worth knowing:** `dec-green.yazi/tmtheme.xml` is an *unmodified gruvbox* theme —
its internal name is literally `gruvbox (Dark) (Medium)` and all 25 of its hexes are gruvbox
values. The same is true of the other four `dec-*` flavors. So yazi's file previews have
always rendered in gruvbox regardless of which `dec-*` flavor was active. The two noble
flavors do not inherit that: their tmthemes contain only palette colors (15 distinct hexes,
verified as a subset of the palette). The pre-existing five are left as they are — fixing
them was not part of this work.

## Switcher

`~/dotfiles/scripts/.local/bin/theme-switch` — two array entries, no logic change:

```bash
ALACRITTY_THEMES=(dec_amber dec_blue dec_gray dec_gray_light dec_green dec_noble_ink dec_noble_leather)
YAZI_THEMES=(dec-amber dec-blue dec-gray dec-gray-light dec-green dec-noble-ink dec-noble-leather)
```

The two golds sit adjacent and last, so one press moves between the siblings.

Neovim is deliberately **not** joined to the cycle. The colorscheme stays independent, set
with `:colorscheme`. Consequence, accepted: cycling to `dec_amber` leaves Neovim gold-on-
indigo inside an amber terminal.

### Latent bug, avoided rather than fixed

`theme-switch` discovers current state with `grep -oP 'dec_[a-z_]+(?=\.toml)'` and rewrites
with `sed s|/dec_[a-z_]\+\.toml|`. Both are hardcoded to the `dec_` prefix. Any theme named
otherwise makes `current` come back empty, so `idx` stays `-1`, `next_idx` becomes `0`, and
the Alacritty `sed` silently fails to match — leaving Alacritty pinned while Yazi flips, a
desync with no error. Conforming to `dec_*` sidesteps this. The trap remains for any future
non-`dec_` theme; generalizing the script was considered and declined in favor of the
smaller change.

## Verification

- **Neovim** — headless load of each scheme; dump every group set via `nvim_get_hl` and
  assert none resolve to cleared, no group has `fg` equal to its own `bg`, and every palette
  key is referenced at least once. A misspelled group name fails silently in Neovim, which is
  the main way colorschemes rot, so the referenced-key check is the important one.
- **Contrast** — recompute the table above from the shipped palette and assert the two themes
  stay within a rung of each other per role.
- **Alacritty** — parse both TOMLs with `tomllib`, then render all 16 slots with the existing
  `~/.config/alacritty/themes/print_colors.sh`.
- **Yazi** — parse both `flavor.toml`s and launch `yazi` on each flavor to confirm no load
  error.
- **Switcher** — dry-run seven presses; assert the Alacritty import and the Yazi flavor stay
  in lockstep at every step and return to the starting theme.
- Screenshots of both themes in Alacritty, showing real files from the user's own config.

## Commits

Two repositories, committed separately:

- `~/.config/nvim` — the six new files, staged **by explicit path**. The repo already carries
  an unrelated dirty `init.lua` and an untracked `lazy-lock.json`; neither is touched or
  staged.
- `~/dotfiles` — the two Alacritty themes, the two Yazi flavor directories, and the
  `theme-switch` edit.

Symlinks in `~/.config/alacritty/` and `~/.config/yazi/flavors/` are created on the live
filesystem and are not themselves tracked by either repo, matching the existing setup.
