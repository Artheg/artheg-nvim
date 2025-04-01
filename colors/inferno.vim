" Alacritty Theme for Vim
" A warm, dark theme with amber/orange accents

" Reset highlighting
highlight clear
if exists("syntax_on")
  syntax reset
endif

" Set colorscheme name
let g:colors_name = "inferno"

" Define colors
let s:bg = "#270d06"
let s:fg = "#d9d9d9"
let s:black = "#330000"
let s:black_bright = "#663300"
let s:red = "#ff3300"
let s:red_bright = "#ff6633"
let s:green = "#ff6600"
let s:green_bright = "#ff9966"
let s:yellow = "#ff9900"
let s:yellow_bright = "#ffcc99"
let s:blue = "#ffcc00"
let s:blue_bright = "#ffcc33"
let s:magenta = "#ff6600"
let s:magenta_bright = "#ff9966"
let s:cyan = "#ff9900"
let s:cyan_bright = "#ffcc99"
let s:white = "#d9d9d9"
let s:white_bright = "#d9d9d9"

" Additional colors for Vim-specific elements
let s:selection = "#663300"
let s:comment = "#cc9966"
let s:line_nr = "#996633"
let s:cursor = "#ffcc00"
let s:visual = "#4d2600"
let s:pmenu = "#331a00"
let s:pmenu_sel = "#663300"
let s:special = "#ffcc66"
let s:fold = "#4d2600"

" Helper function for highlighting
function! s:hi(group, fg, bg, attr)
  if !empty(a:fg)
    exec "hi " . a:group . " guifg=" . a:fg
  endif
  if !empty(a:bg)
    exec "hi " . a:group . " guibg=" . a:bg
  endif
  if !empty(a:attr)
    exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
  endif
endfunction

" Set terminal colors
let g:terminal_ansi_colors = [
      \ s:black, s:red, s:green, s:yellow,
      \ s:blue, s:magenta, s:cyan, s:white,
      \ s:black_bright, s:red_bright, s:green_bright, s:yellow_bright,
      \ s:blue_bright, s:magenta_bright, s:cyan_bright, s:white_bright
      \ ]

" Editor highlighting
call s:hi("Normal", s:fg, s:bg, "")
call s:hi("ColorColumn", "", s:black, "")
call s:hi("Cursor", s:bg, s:cursor, "")
call s:hi("CursorLine", "", s:black, "")
call s:hi("CursorLineNr", s:cursor, "", "bold")
call s:hi("LineNr", s:line_nr, "", "")
call s:hi("NonText", s:line_nr, "", "")
call s:hi("SpecialKey", s:special, "", "")
call s:hi("EndOfBuffer", s:line_nr, "", "")

" Selection and search
call s:hi("Visual", "", s:visual, "")
call s:hi("VisualNOS", "", s:visual, "")
call s:hi("Search", s:bg, s:yellow, "")
call s:hi("IncSearch", s:bg, s:yellow_bright, "")

" Statusline and tabline
call s:hi("StatusLine", s:fg, s:black, "")
call s:hi("StatusLineNC", s:line_nr, s:black, "")
call s:hi("TabLine", s:fg, s:black, "")
call s:hi("TabLineFill", s:fg, s:black, "")
call s:hi("TabLineSel", s:fg, s:selection, "bold")
call s:hi("VertSplit", s:line_nr, "", "")

" Popup menu
call s:hi("Pmenu", s:fg, s:pmenu, "")
call s:hi("PmenuSel", s:fg, s:pmenu_sel, "")
call s:hi("PmenuSbar", "", s:pmenu, "")
call s:hi("PmenuThumb", "", s:line_nr, "")

" Folds and columns
call s:hi("Folded", s:comment, s:fold, "")
call s:hi("FoldColumn", s:line_nr, s:bg, "")
call s:hi("SignColumn", s:fg, s:bg, "")

" Messages
call s:hi("ErrorMsg", s:red, "", "bold")
call s:hi("WarningMsg", s:yellow, "", "bold")
call s:hi("MoreMsg", s:green, "", "")
call s:hi("Question", s:green, "", "")

" Language syntax highlighting
call s:hi("Comment", s:comment, "", "italic")

call s:hi("Constant", s:cyan_bright, "", "")
call s:hi("String", s:green_bright, "", "")
call s:hi("Character", s:green_bright, "", "")
call s:hi("Number", s:cyan_bright, "", "")
call s:hi("Boolean", s:cyan_bright, "", "")
call s:hi("Float", s:cyan_bright, "", "")

call s:hi("Identifier", s:fg, "", "")
call s:hi("Function", s:yellow, "", "")

call s:hi("Statement", s:red, "", "")
call s:hi("Conditional", s:red, "", "")
call s:hi("Repeat", s:red, "", "")
call s:hi("Label", s:red, "", "")
call s:hi("Operator", s:red_bright, "", "")
call s:hi("Keyword", s:red, "", "")
call s:hi("Exception", s:red, "", "")

call s:hi("PreProc", s:magenta_bright, "", "")
call s:hi("Include", s:magenta, "", "")
call s:hi("Define", s:magenta, "", "")
call s:hi("Macro", s:magenta_bright, "", "")
call s:hi("PreCondit", s:magenta_bright, "", "")

call s:hi("Type", s:blue, "", "")
call s:hi("StorageClass", s:blue, "", "")
call s:hi("Structure", s:blue, "", "")
call s:hi("Typedef", s:blue, "", "")

call s:hi("Special", s:special, "", "")
call s:hi("SpecialChar", s:special, "", "")
call s:hi("Tag", s:yellow, "", "")
call s:hi("Delimiter", s:fg, "", "")
call s:hi("SpecialComment", s:comment, "", "bold")
call s:hi("Debug", s:red, "", "")

call s:hi("Underlined", s:blue, "", "underline")
call s:hi("Ignore", s:line_nr, "", "")
call s:hi("Error", s:red, s:bg, "")
call s:hi("Todo", s:yellow, "", "bold")

" Diff highlighting
call s:hi("DiffAdd", s:green, s:black, "")
call s:hi("DiffChange", s:blue, s:black, "")
call s:hi("DiffDelete", s:red, s:black, "")
call s:hi("DiffText", s:yellow, s:black, "bold")

" Spelling
call s:hi("SpellBad", s:red, "", "undercurl")
call s:hi("SpellCap", s:blue, "", "undercurl")
call s:hi("SpellRare", s:magenta, "", "undercurl")
call s:hi("SpellLocal", s:cyan, "", "undercurl")

" Markdown
call s:hi("markdownH1", s:red, "", "bold")
call s:hi("markdownH2", s:yellow, "", "bold")
call s:hi("markdownH3", s:green, "", "bold")
call s:hi("markdownH4", s:blue, "", "bold")
call s:hi("markdownH5", s:magenta, "", "bold")
call s:hi("markdownH6", s:cyan, "", "bold")
call s:hi("markdownCode", s:green_bright, s:black, "")
call s:hi("markdownLinkText", s:blue, "", "underline")

" Terminal support
if has('terminal')
  let g:terminal_color_0 = s:black
  let g:terminal_color_1 = s:red
  let g:terminal_color_2 = s:green
  let g:terminal_color_3 = s:yellow
  let g:terminal_color_4 = s:blue
  let g:terminal_color_5 = s:magenta
  let g:terminal_color_6 = s:cyan
  let g:terminal_color_7 = s:white
  let g:terminal_color_8 = s:black_bright
  let g:terminal_color_9 = s:red_bright
  let g:terminal_color_10 = s:green_bright
  let g:terminal_color_11 = s:yellow_bright
  let g:terminal_color_12 = s:blue_bright
  let g:terminal_color_13 = s:magenta_bright
  let g:terminal_color_14 = s:cyan_bright
  let g:terminal_color_15 = s:white_bright
endif

" Fallback for older Vim versions
if !has("gui_running") && &t_Co < 256
  finish
endif

" Remove functions
delfunction s:hi
