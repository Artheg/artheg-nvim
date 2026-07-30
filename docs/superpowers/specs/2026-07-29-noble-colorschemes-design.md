# Noble: two aristocratic gold colorschemes

Date: 2026-07-29

Two sibling themes — gold text on deep indigo, champagne text on graphite — delivered for
Neovim, Alacritty and Yazi, wired into the existing `super + F9` theme switcher.

> **Revised 2026-07-29 (backgrounds).** `noble-leather`'s base moved from brown `#241811` to
> `dec_amber`'s neutral `#2D2D2D`, keeping a low-chroma warm tint on every surface above the
> base; `noble-ink`'s base dropped from `#14162E` to `#0C0E20`. Decision 2 below (matched
> depth) no longer holds — see [Measured contrast](#measured-contrast).

## Aesthetic decisions

Four decisions, settled during brainstorming, that everything else follows from:

1. **Near-monochrome.** Hue is locked to the gold family. Tokens separate by lightness and
   by `bold`/`italic`, never by hue. Only diagnostics, git signs and diffs leave the family.
   This matches the user's existing collection (`accent.vim`, `vim-256noir`, `austere`,
   `komau`, `vim-boring`, `coal`, `vim-colors-off`, `plain`, `fogbell`).
2. ~~**Mid-depth backgrounds.** Dark enough that gold glows, light enough that indigo reads
   as indigo and brown reads as brown. Both themes sit at the same depth so they feel
   matched.~~ **Superseded 2026-07-29.** The bases were pulled apart deliberately: ink went
   deeper, leather went to `dec_amber`'s neutral graphite so the two terminal themes share a
   base. The siblings no longer sit at the same depth.
3. **Gold retuned per background.** Same lightness ladder and same role structure in both,
   but the leather theme's gold shifts cooler toward champagne-ivory. On cool indigo, warm
   gold is complementary and pops; against leather's warm surfaces, the identical gold would
   sit inside their own hue family and go muddy even at equal contrast ratio.
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

### `noble-ink` — warm old-gold on deep indigo

```
surfaces                      gold ladder              accents
bg           #0C0E20          bright   #F0E2BE         garnet    #B8555E
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

### `noble-leather` — cool champagne on graphite

`bg` is `dec_amber`'s neutral `#2D2D2D`; every surface above it keeps a low-chroma warm tint,
so floats, visual and the statusline still read as leather on a neutral desk.

```
surfaces                      champagne ladder         accents
bg           #2D2D2D          bright   #F2EAD3         garnet    #B85A52
bg_light     #383430          base     #DED5B6         amber     #D9AE68
bg_float     #333029          string   #E9DDBF         verdigris #6F938C
bg_visual    #47413A          type     #D5C9A4         sage      #8C9B79
border       #5F564C          brass    #C0B287
indent       #3E3A34          dim      #A79B78         diff washes
indent_scope #524A40          comment  #90886A         add  #2B3626
sl_bg        #3E3A34          punct    #837B60         del  #3B2A26
sl_fg        #DED5B6          faint    #625C48         chg  #363327
                                                       text #464031
```

### Measured contrast

WCAG ratios against each theme's own `bg`, as measured by the verification pass from the
shipped palette (not hand-computed):

| role | ink | leather | delta | (was: ink / leather) |
|---|---|---|---|---|
| `bright` | 14.85:1 | 11.47:1 | 3.39 | 13.79 / 14.41 |
| `string` | 13.11:1 | 10.20:1 | 2.91 | 12.17 / 12.82 |
| `base` | 11.91:1 | 9.38:1 | 2.53 | 11.06 / 11.78 |
| `type` | 10.76:1 | 8.34:1 | 2.42 | 9.99 / 10.48 |
| `brass` | 8.06:1 | 6.53:1 | 1.53 | 7.48 / 8.21 |
| `dim` | 6.15:1 | 4.99:1 | 1.16 | 5.71 / 6.26 |
| `comment` | 4.29:1 | 3.88:1 | 0.41 | 3.99 / 4.87 |
| `punct` | 3.75:1 | 3.26:1 | 0.50 | 3.48 / 4.09 |
| `faint` | 2.49:1 | 2.06:1 | 0.43 | 2.31 / 2.59 |

`faint` is intentionally sub-threshold — it is scaffolding (indent guides, `EndOfBuffer`)
that should be perceptible without being readable. `punct` and `comment` have always sat
below 4.5:1 on at least one theme; the ladder targets 4.5:1 from `bright` down through
`dim`, and that still holds on both (`dim` is the floor at 4.99:1 on leather).

**The `delta ≤ 1.2` invariant no longer holds.** It was written when both bases sat at the
same depth. The 2026-07-29 background change pulled them apart in opposite directions — ink
darker, leather lighter — so the same text ladders now measure up to 3.39 apart, and leather
reads flatter than ink. Restoring parity would mean brightening leather's champagne ladder,
which changes text colors rather than backgrounds; not done, since the brief was backgrounds
only.

Leather's accents dropped with its base: garnet `3.03:1`, verdigris `4.08:1`, sage `4.64:1`,
amber `6.69:1` (ink: `4.09` / `5.52` / `6.34` / `8.83`). Garnet on leather is the weakest
point — error diagnostics and `DiffDelete` text are the places to watch.

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
| black | `#1B1E3C` | `#4A4E7A` | `#383430` | `#5F564C` |
| red | `#B8555E` | `#C97078` | `#B85A52` | `#CA7168` |
| green | `#8A9A78` | `#A0B08C` | `#8C9B79` | `#A3B08D` |
| yellow | `#C4A469` | `#D9A85C` | `#C0B287` | `#D9AE68` |
| blue | `#6B7A9E` | `#8595B8` | `#6E8394` | `#879AAB` |
| magenta | `#8E7A9E` | `#A894B8` | `#A07E86` | `#B7969D` |
| cyan | `#6E9188` | `#86A9A0` | `#6F938C` | `#88A8A1` |
| white | `#DCCBA0` | `#F0E2BE` | `#DED5B6` | `#F2EAD3` |

ANSI needs six hues where the Neovim palette has four, so blue and magenta are extrapolated:
amethyst on indigo (coherent with that background), dusty rose on leather.

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
