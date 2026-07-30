-- Noble: two near-monochrome gold palettes.
--
-- Hue is locked to the gold family; lightness encodes importance. Both tables
-- carry identical keys, so noble.load() is a total function of one of them and
-- the two themes cannot drift apart structurally.
--
-- Ladder, brightest to faintest:
--   bright  scan targets   functions, headings, titles, constants
--   string  lifted         strings sit just above base so quoted text lifts
--   base    substance      Normal, variables, members, operators
--   type    grammar        types, structures, attributes
--   brass   keywords       keywords, conditionals, preproc, special
--   dim     secondary      builtins, modules, folded text
--   comment aside          comments
--   punct   scaffolding    punctuation, brackets, LineNr
--   faint   near-invisible NonText, indent guides, EndOfBuffer

local M = {}

-- Warm old-gold on deep indigo. Gold is complementary to the base, so it glows.
-- bg sits a step below the rest of the surface ladder, so panels and floats lift
-- off the background more strongly than a uniform step would give.
M.ink = {
  -- surfaces
  bg           = "#0C0E20",
  bg_light     = "#1B1E3C",
  bg_float     = "#191C36",
  bg_visual    = "#2A2E52",
  border       = "#4A4E7A",
  indent       = "#22254A",
  indent_scope = "#3A3E66",

  -- statusline lives outside the ladder: transparent.nvim excludes StatusLine
  -- and StatusLineNC, so these must stay legible when other bgs are stripped.
  sl_bg = "#22254A",
  sl_fg = "#DCCBA0",

  -- gold ladder
  bright  = "#F0E2BE",
  string  = "#E8D4A8",
  base    = "#DCCBA0",
  type    = "#D8C08A",
  brass   = "#C4A469",
  dim     = "#A88F5E",
  comment = "#8A7548",
  punct   = "#7E6C48",
  faint   = "#5E5238",

  -- muted jewel accents, the only hues that leave the family
  garnet    = "#B8555E",
  amber     = "#D9A85C",
  verdigris = "#6E9188",
  sage      = "#8A9A78",

  -- diff washes: background only, so gold text keeps its own color in a diff
  diff_add  = "#16241B",
  diff_del  = "#2A1418",
  diff_chg  = "#16203A",
  diff_text = "#1F2C4E",
}

-- Cool champagne on graphite. bg is dec_amber's neutral #2D2D2D so the two
-- themes share a base; every surface above it keeps a low-chroma warm tint, so
-- floats, visual and the statusline still read as leather. The same warm gold
-- ink uses would sit inside those surfaces' own hue family and go muddy, so this
-- ladder shifts toward ivory and separates by hue distance as well as lightness.
M.leather = {
  -- surfaces
  bg           = "#2D2D2D",
  bg_light     = "#383430",
  bg_float     = "#333029",
  bg_visual    = "#47413A",
  border       = "#5F564C",
  indent       = "#3E3A34",
  indent_scope = "#524A40",

  sl_bg = "#3E3A34",
  sl_fg = "#DED5B6",

  -- champagne ladder
  bright  = "#F2EAD3",
  string  = "#E9DDBF",
  base    = "#DED5B6",
  type    = "#D5C9A4",
  brass   = "#C0B287",
  dim     = "#A79B78",
  comment = "#90886A",
  punct   = "#837B60",
  faint   = "#625C48",

  -- accents lean a touch warmer to sit on leather
  garnet    = "#B85A52",
  amber     = "#D9AE68",
  verdigris = "#6F938C",
  sage      = "#8C9B79",

  diff_add  = "#2B3626",
  diff_del  = "#3B2A26",
  diff_chg  = "#363327",
  diff_text = "#464031",
}

return M
