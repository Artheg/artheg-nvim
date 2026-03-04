vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.opt.background = "dark"
vim.g.colors_name = "fresh-days"

local c = {
  bg        = "#00001A",
  bg_light  = "#000B2E",
  bg_float  = "#0A0A30",
  bg_visual = "#1A1A4A",
  fg        = "#DCDCDC",
  fg_dim    = "#9C9C9C",
  fg_dark   = "#616161",
  non_text  = "#4B4B4B",

  comment   = "#57A63A",
  string    = "#FFAA55",
  number    = "#9F5000",
  keyword   = "#9F5000",
  operator  = "#B4B4B4",
  special   = "#9F5000",
  constant  = "#ff5555",
  preproc   = "#429CD6",
  func      = "#9C9C9C",
  type      = "#7A7A7A",
  ident     = "#F1F1F1",
  tag       = "#FFAA55",
  attribute = "#B4B4B4",
  punct     = "#7A7A7A",
  param     = "#C8C8C8",

  blue      = "#429CD6",
  blue_dim  = "#2B91AF",
  green     = "#57A63A",
  orange    = "#FFAA55",
  red       = "#ff5555",
  yellow    = "#E5C07B",

  diff_add  = "#1A3A1A",
  diff_del  = "#3A1A1A",
  diff_chg  = "#1A2A3A",

  diag_err  = "#ff5555",
  diag_warn = "#E5C07B",
  diag_info = "#429CD6",
  diag_hint = "#57A63A",
}

local hl = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- ── Base UI ──────────────────────────────────────────────
hl("Normal",       { fg = c.fg, bg = c.bg })
hl("NormalFloat",  { fg = c.fg, bg = c.bg_float })
hl("FloatBorder",  { fg = c.blue_dim, bg = c.bg_float })
hl("FloatTitle",   { fg = c.blue, bg = c.bg_float, bold = true })
hl("CursorLine",   { bg = c.bg_light })
hl("CursorColumn", { bg = c.bg_light })
hl("ColorColumn",  { bg = c.bg_light })
hl("Visual",       { fg = "#111111", bg = "#F1F1F1" })
hl("VisualNOS",    { fg = "#111111", bg = "#F1F1F1" })
hl("LineNr",       { fg = c.blue_dim })
hl("CursorLineNr", { fg = c.blue, bold = true })
hl("SignColumn",   { bg = c.bg })
hl("FoldColumn",   { fg = c.non_text, bg = c.bg })
hl("Folded",       { fg = c.fg_dim, bg = c.bg_light })
hl("VertSplit",    { fg = c.non_text })
hl("WinSeparator", { fg = c.non_text })
hl("NonText",      { fg = c.non_text })
hl("SpecialKey",   { fg = c.non_text })
hl("EndOfBuffer",  { fg = c.non_text })
hl("Conceal",      { fg = c.fg_dark })

hl("StatusLine",   { fg = c.fg, bg = "#2A2A2A" })
hl("StatusLineNC", { fg = c.fg_dark, bg = c.non_text })
hl("TabLine",      { fg = c.fg_dim, bg = c.bg_light })
hl("TabLineFill",  { bg = c.bg })
hl("TabLineSel",   { fg = c.fg, bg = "#2A2A2A", bold = true })
hl("WinBar",       { fg = c.fg_dim, bg = c.bg })
hl("WinBarNC",     { fg = c.fg_dark, bg = c.bg })

hl("Pmenu",        { fg = c.fg, bg = c.bg_float })
hl("PmenuSel",     { fg = c.fg, bg = c.bg_visual })
hl("PmenuSbar",    { bg = c.bg_light })
hl("PmenuThumb",   { bg = c.fg_dark })

hl("Search",       { fg = c.bg, bg = c.orange })
hl("IncSearch",    { fg = c.bg, bg = c.blue })
hl("CurSearch",    { fg = c.bg, bg = c.yellow })
hl("Substitute",   { fg = c.bg, bg = c.red })

hl("MatchParen",   { fg = c.orange, bold = true, underline = true })
hl("Directory",    { fg = c.blue })
hl("Title",        { fg = c.blue, bold = true })
hl("Question",     { fg = c.green })
hl("MoreMsg",      { fg = c.green })
hl("ModeMsg",      { fg = c.fg_dim })
hl("WildMenu",     { fg = c.bg, bg = c.blue })

hl("ErrorMsg",     { fg = "white", bg = "red" })
hl("WarningMsg",   { fg = c.yellow })
hl("SpellBad",     { undercurl = true, sp = c.red })
hl("SpellCap",     { undercurl = true, sp = c.yellow })
hl("SpellRare",    { undercurl = true, sp = c.blue })
hl("SpellLocal",   { undercurl = true, sp = c.green })

-- ── Diff ─────────────────────────────────────────────────
hl("DiffAdd",    { bg = c.diff_add })
hl("DiffChange", { bg = c.diff_chg })
hl("DiffDelete", { fg = c.red, bg = c.diff_del })
hl("DiffText",   { bg = "#2A3A5A", bold = true })

-- ── Diagnostics ──────────────────────────────────────────
hl("DiagnosticError",          { fg = c.diag_err })
hl("DiagnosticWarn",           { fg = c.diag_warn })
hl("DiagnosticInfo",           { fg = c.diag_info })
hl("DiagnosticHint",           { fg = c.diag_hint })
hl("DiagnosticUnderlineError", { undercurl = true, sp = c.diag_err })
hl("DiagnosticUnderlineWarn",  { undercurl = true, sp = c.diag_warn })
hl("DiagnosticUnderlineInfo",  { undercurl = true, sp = c.diag_info })
hl("DiagnosticUnderlineHint",  { undercurl = true, sp = c.diag_hint })
hl("DiagnosticVirtualTextError", { fg = c.diag_err, bg = "#1A0000" })
hl("DiagnosticVirtualTextWarn",  { fg = c.diag_warn, bg = "#1A1500" })
hl("DiagnosticVirtualTextInfo",  { fg = c.diag_info, bg = "#00001A" })
hl("DiagnosticVirtualTextHint",  { fg = c.diag_hint, bg = "#001A00" })

-- ── Standard syntax ──────────────────────────────────────
hl("Comment",    { fg = c.comment, italic = true })
hl("String",     { fg = c.string })
hl("Character",  { fg = c.string })
hl("Number",     { fg = c.number })
hl("Float",      { fg = c.number })
hl("Boolean",    { fg = c.constant, bold = true })
hl("Identifier", { fg = c.ident })
hl("Function",   { fg = c.func })
hl("Keyword",    { fg = c.keyword })
hl("Statement",  { fg = c.keyword })
hl("Conditional",{ fg = c.keyword })
hl("Repeat",     { fg = c.keyword })
hl("Label",      { fg = c.keyword })
hl("Exception",  { fg = c.keyword })
hl("Operator",   { fg = c.operator })
hl("PreProc",    { fg = c.preproc })
hl("Include",    { fg = c.preproc })
hl("Define",     { fg = c.preproc })
hl("Macro",      { fg = c.preproc })
hl("PreCondit",  { fg = c.preproc })
hl("Type",       { fg = c.type })
hl("StorageClass", { fg = c.keyword })
hl("Structure",  { fg = c.type })
hl("Typedef",    { fg = c.type })
hl("Special",    { fg = c.special })
hl("SpecialChar",{ fg = c.orange })
hl("Tag",        { fg = c.tag })
hl("Delimiter",  { fg = c.punct })
hl("Constant",   { fg = c.constant, bold = true })
hl("Todo",       { fg = c.bg, bg = c.yellow, bold = true })
hl("Underlined", { underline = true })
hl("Error",      { fg = "white", bg = "red" })

-- ── Treesitter ───────────────────────────────────────────
-- Identifiers
hl("@variable",                  { fg = c.fg })
hl("@variable.builtin",         { fg = c.fg_dim, italic = true })
hl("@variable.parameter",       { fg = c.param })
hl("@variable.member",          { fg = c.fg })

hl("@constant",                  { fg = c.constant, bold = true })
hl("@constant.builtin",         { fg = c.constant, bold = true })
hl("@constant.macro",           { fg = c.constant })

hl("@module",                    { fg = c.fg_dim })
hl("@label",                     { fg = c.blue })

-- Literals
hl("@string",                    { fg = c.string })
hl("@string.escape",            { fg = c.orange, bold = true })
hl("@string.regexp",            { fg = c.orange })
hl("@string.special",           { fg = c.orange })
hl("@string.special.url",       { fg = c.blue, underline = true })
hl("@string.special.symbol",    { fg = c.string })

hl("@character",                 { fg = c.string })
hl("@character.special",        { fg = c.orange })

hl("@number",                    { fg = c.number })
hl("@number.float",             { fg = c.number })

hl("@boolean",                   { fg = c.constant, bold = true })

-- Types
hl("@type",                      { fg = c.type })
hl("@type.builtin",             { fg = c.type, italic = true })
hl("@type.definition",          { fg = c.type })
hl("@type.qualifier",           { fg = c.keyword })

hl("@attribute",                 { fg = c.attribute })
hl("@property",                  { fg = c.fg })

-- Functions
hl("@function",                  { fg = c.func })
hl("@function.builtin",         { fg = c.func, italic = true })
hl("@function.call",            { fg = c.func })
hl("@function.macro",           { fg = c.preproc })
hl("@function.method",          { fg = c.func })
hl("@function.method.call",     { fg = c.func })

hl("@constructor",               { fg = c.blue })

-- Keywords
hl("@keyword",                   { fg = c.keyword })
hl("@keyword.function",         { fg = c.keyword })
hl("@keyword.operator",         { fg = c.keyword })
hl("@keyword.import",           { fg = c.preproc })
hl("@keyword.storage",          { fg = c.keyword })
hl("@keyword.repeat",           { fg = c.keyword })
hl("@keyword.return",           { fg = c.keyword })
hl("@keyword.exception",        { fg = c.keyword })
hl("@keyword.conditional",      { fg = c.keyword })
hl("@keyword.directive",        { fg = c.preproc })

hl("@operator",                  { fg = c.operator })

-- Punctuation
hl("@punctuation.bracket",      { fg = c.punct })
hl("@punctuation.delimiter",    { fg = c.punct })
hl("@punctuation.special",      { fg = c.punct })

-- Comments
hl("@comment",                   { fg = c.comment, italic = true })
hl("@comment.documentation",    { fg = c.comment, italic = true })
hl("@comment.todo",             { fg = c.bg, bg = c.yellow, bold = true })
hl("@comment.note",             { fg = c.bg, bg = c.blue, bold = true })
hl("@comment.warning",          { fg = c.bg, bg = c.diag_warn, bold = true })
hl("@comment.error",            { fg = c.bg, bg = c.red, bold = true })

-- Markup
hl("@markup.heading",           { fg = c.blue, bold = true })
hl("@markup.heading.1",         { fg = c.blue, bold = true })
hl("@markup.heading.2",         { fg = c.blue, bold = true })
hl("@markup.heading.3",         { fg = c.blue })
hl("@markup.bold",              { bold = true })
hl("@markup.italic",            { italic = true })
hl("@markup.strikethrough",     { strikethrough = true })
hl("@markup.underline",         { underline = true })
hl("@markup.link",              { fg = c.blue, underline = true })
hl("@markup.link.url",          { fg = c.blue, underline = true })
hl("@markup.raw",               { fg = c.string })
hl("@markup.list",              { fg = c.punct })

-- Tags (JSX/HTML)
hl("@tag",                       { fg = c.tag })
hl("@tag.attribute",            { fg = c.attribute })
hl("@tag.delimiter",            { fg = c.punct })
hl("@tag.builtin",              { fg = c.tag, italic = true })

-- ── LSP semantic tokens ──────────────────────────────────
hl("@lsp.type.class",           { fg = c.type })
hl("@lsp.type.decorator",       { fg = c.attribute })
hl("@lsp.type.enum",            { fg = c.type })
hl("@lsp.type.enumMember",      { fg = c.constant, bold = true })
hl("@lsp.type.function",        { fg = c.func })
hl("@lsp.type.interface",       { fg = c.type })
hl("@lsp.type.macro",           { fg = c.preproc })
hl("@lsp.type.method",          { fg = c.func })
hl("@lsp.type.namespace",       { fg = c.fg_dim })
hl("@lsp.type.parameter",       { fg = c.param })
hl("@lsp.type.property",        { fg = c.fg })
hl("@lsp.type.struct",          { fg = c.type })
hl("@lsp.type.type",            { fg = c.type })
hl("@lsp.type.typeParameter",   { fg = c.type, italic = true })
hl("@lsp.type.variable",        { fg = c.fg })
hl("@lsp.mod.deprecated",       { strikethrough = true })
hl("@lsp.mod.readonly",         { bold = true })

-- ── Plugin: GitSigns ─────────────────────────────────────
hl("GitSignsAdd",    { fg = c.green })
hl("GitSignsChange", { fg = c.blue })
hl("GitSignsDelete", { fg = c.red })

-- ── Plugin: Telescope ────────────────────────────────────
hl("TelescopeNormal",       { fg = c.fg, bg = c.bg_float })
hl("TelescopeBorder",       { fg = c.blue_dim, bg = c.bg_float })
hl("TelescopePromptNormal", { fg = c.fg, bg = c.bg_light })
hl("TelescopePromptBorder", { fg = c.blue_dim, bg = c.bg_light })
hl("TelescopePromptTitle",  { fg = c.bg, bg = c.blue, bold = true })
hl("TelescopeResultsTitle", { fg = c.blue_dim, bg = c.bg_float })
hl("TelescopePreviewTitle", { fg = c.bg, bg = c.green, bold = true })
hl("TelescopeSelection",    { bg = c.bg_visual })
hl("TelescopeMatching",     { fg = c.orange, bold = true })

-- ── Plugin: Trouble ──────────────────────────────────────
hl("TroubleNormal", { fg = c.fg, bg = c.bg_float })
hl("TroubleCount",  { fg = c.constant, bold = true })

-- ── Plugin: Indent guides ────────────────────────────────
hl("IndentBlanklineChar",        { fg = "#1A1A3A" })
hl("IndentBlanklineContextChar", { fg = c.non_text })

-- ── Plugin: Snacks indent ────────────────────────────────
hl("SnacksIndent",      { fg = "#1A1A3A" })
hl("SnacksIndentScope", { fg = c.non_text })
