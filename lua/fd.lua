local colors = {
  bg = "#00001A",
  fg = "#DCDCDC",
  comment = "#57A63A",
  string = "#FFAA55",
  number = "#9F5000",
  identifier = "#F1F1F1",
  keyword = "#9F5000",
  operator = "#B4B4B4",
  preproc = "#0429CD6",
  special = "#9F5000",
  line_nr = "#2B91AF",
  cursor_line_nr = "#429CD6",
  vert_split = "#B6B6B6",
  statusline_fg = "#DCDCDC",
  statusline_bg = "#0429CD6",
  statusline_nc_fg = "#616161",
  statusline_nc_bg = "#B4B4B4",
  function_fg = "#9C9C9C",
  type = "#616161",
  constant = "#FFAA55",
  error_fg = "white",
  error_bg = "red",
  warning_fg = "yellow",
  match_paren_fg = "black",
  match_paren_bg = "white",
  visual_fg = "#111111",
  visual_bg = "#F1F1F1",
  non_text = "#4B4B4B",
  special_key = "#4B4B4B",
  ts_const = "#ff5555",
}

vim.cmd("hi clear")
vim.opt.background = "dark"
vim.g.colors_name = "fd"

local function highlight(group, fg, bg, style)
  local cmd = string.format("hi %s guifg=%s guibg=%s gui=%s", group, fg or "NONE", bg or "NONE", style or "NONE")
  vim.cmd(cmd)
end

-- Basic groups
highlight("Normal", colors.fg, colors.bg)
highlight("Comment", colors.comment)
highlight("String", colors.string)
highlight("Number", colors.number)
highlight("Identifier", colors.identifier)

-- Additional syntax
highlight("Keyword", colors.keyword)
highlight("Operator", colors.operator)
highlight("PreProc", colors.preproc)
highlight("Special", colors.special)

-- UI elements
highlight("LineNr", colors.line_nr)
highlight("CursorLineNr", colors.cursor_line_nr)
highlight("VertSplit", colors.vert_split)
highlight("StatusLine", colors.statusline_fg, colors.statusline_bg)
highlight("StatusLineNC", colors.statusline_nc_fg, colors.statusline_nc_bg)

-- Additional mappings
highlight("Function", colors.function_fg)
highlight("Type", colors.type)
highlight("Constant", colors.constant)
highlight("ErrorMsg", colors.error_fg, colors.error_bg)
highlight("WarningMsg", colors.warning_fg)
-- highlight("MatchParen", colors.match_paren_fg, colors.match_paren_bg)
highlight("Visual", colors.visual_fg, colors.visual_bg)
highlight("NonText", colors.non_text)
highlight("SpecialKey", colors.special_key)

-- Treesitter highlights
highlight("@constant", colors.ts_const, nil, "bold")
highlight("@keyword", colors.keyword)
highlight("@string", colors.string)
highlight("@function", colors.function_fg)
highlight("@type", colors.type)
highlight("@operator", colors.operator)
highlight("@comment", colors.comment)
highlight("@number", colors.number)
