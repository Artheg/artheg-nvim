hi clear
syntax reset
set t_Co=256
let g:colors_name = 'melange'
highlight Melange guifg=NONE guibg=NONE guisp=NONE gui=NONE
highlight NormalFloat guifg=#EDE6DE guibg=#38332E guisp=NONE gui=NONE
highlight NormalNC guifg=#EDE6DE guibg=#2A2622 guisp=NONE gui=NONE
highlight Comment guifg=#A38C75 guibg=NONE guisp=NONE gui=italic
highlight Conceal guifg=#F7C96E guibg=NONE guisp=NONE gui=NONE
highlight Whitespace guifg=#6B5947 guibg=NONE guisp=NONE gui=NONE
highlight! link NonText Whitespace
highlight! link SpecialKey Whitespace
highlight Cursor guifg=#2A2622 guibg=#EDE6DE guisp=NONE gui=NONE
highlight TermCursor guifg=#2A2622 guibg=#EDE6DE guisp=NONE gui=NONE
highlight ColorColumn guifg=NONE guibg=#38332E guisp=NONE gui=NONE
highlight CursorColumn guifg=NONE guibg=#38332E guisp=NONE gui=NONE
highlight! link CursorLine CursorColumn
highlight MatchParen guifg=#EDE6DE guibg=#584D41 guisp=NONE gui=NONE
highlight LineNr guifg=#6B5947 guibg=NONE guisp=NONE gui=NONE
highlight CursorLineNr guifg=#CC8033 guibg=NONE guisp=NONE gui=NONE
highlight! link SignColumn LineNr
highlight VertSplit guifg=#38332E guibg=#38332E guisp=NONE gui=NONE
highlight Folded guifg=#A38C75 guibg=#38332E guisp=NONE gui=NONE
highlight! link FoldColumn LineNr
highlight Pmenu guifg=#EDE6DE guibg=#38332E guisp=NONE gui=NONE
highlight PmenuSel guifg=#EDE6DE guibg=#584D41 guisp=NONE gui=NONE
highlight! link PmenuSbar Pmenu
highlight Normal guifg=#EDE6DE guibg=#2A2622 guisp=NONE gui=NONE
highlight! link WildMenu Pmenu
highlight StatusLine guifg=#EDE6DE guibg=#38332E guisp=NONE gui=NONE
highlight StatusLineNC guifg=#6B5947 guibg=#38332E guisp=NONE gui=NONE
highlight TabLineSel guifg=#F7C96E guibg=#584D41 guisp=NONE gui=NONE
highlight! link IncSearch Search
highlight! link Substitute Search
highlight TabLine guifg=#EDE6DE guibg=#38332E guisp=NONE gui=NONE
highlight VisualNOS guifg=NONE guibg=#38332E guisp=NONE gui=NONE
highlight ModeMsg guifg=#6B5947 guibg=NONE guisp=NONE gui=NONE
highlight! link MsgArea Normal
highlight MsgSeparator guifg=#CC8033 guibg=NONE guisp=NONE gui=NONE
highlight MoreMsg guifg=#8BC270 guibg=NONE guisp=NONE gui=NONE
highlight Question guifg=#8BC270 guibg=NONE guisp=NONE gui=NONE
highlight ErrorMsg guifg=#D65C70 guibg=NONE guisp=NONE gui=NONE
highlight WarningMsg guifg=#D65C70 guibg=NONE guisp=NONE gui=NONE
highlight Directory guifg=#CC8033 guibg=NONE guisp=NONE gui=NONE
highlight Title guifg=#CC8033 guibg=NONE guisp=NONE gui=NONE
highlight! link TSFunction Function
highlight! link TSFuncBuiltin TSFunction
highlight! link TSFuncMacro TSFunction
highlight! link TSMethod TSFunction
highlight! link TSConstructor TSFunction
highlight TSKeywordFunction guifg=#8BC270 guibg=NONE guisp=NONE gui=NONE
highlight! link TSKeyword Keyword
highlight! link TSConditional Conditional
highlight! link TSRepeat Repeat
highlight! link TSLabel Label
highlight! link TSOperator Operator
highlight! link TSException Exception
highlight! link TSNamespace PreProc
highlight! link TSAnnotation TSNamespace
highlight Constant guifg=#997AB8 guibg=NONE guisp=NONE gui=NONE
highlight Number guifg=#D194C7 guibg=NONE guisp=NONE gui=NONE
highlight! link Float Number
highlight! link Boolean Number
highlight Character guifg=#9CA7C9 guibg=NONE guisp=NONE gui=NONE
highlight String guifg=#9CA7C9 guibg=NONE guisp=NONE gui=italic
highlight Identifier guifg=#87CEEB guibg=NONE guisp=NONE gui=NONE
highlight Function guifg=#F7C96E guibg=NONE guisp=NONE gui=NONE
highlight Statement guifg=#CC8033 guibg=NONE guisp=NONE gui=NONE
highlight! link Conditional Statement
highlight! link Repeat Statement
highlight! link Label Statement
highlight Operator guifg=#F7856E guibg=NONE guisp=NONE gui=NONE
highlight! link Keyword Statement
highlight Exception guifg=#D65C70 guibg=NONE guisp=NONE gui=NONE
highlight PreProc guifg=#4DB380 guibg=NONE guisp=NONE gui=NONE
highlight! link Include PreProc
highlight! link Define PreProc
highlight! link Macro PreProc
highlight! link PreCondit PreProc
highlight Type guifg=#85ADAD guibg=NONE guisp=NONE gui=NONE
highlight! link StorageClass Type
highlight! link Structure Type
highlight! link Typedef Type
highlight Special guifg=#CC8033 guibg=NONE guisp=NONE gui=NONE
highlight! link SpecialChar Special
highlight Tag guifg=#F7C96E guibg=NONE guisp=NONE gui=NONE
highlight Delimiter guifg=#F7856E guibg=NONE guisp=NONE gui=NONE
highlight! link SpecialComment Special
highlight! link Debug Special
highlight Underlined guifg=NONE guibg=NONE guisp=NONE gui=underline
highlight Bold guifg=NONE guibg=NONE guisp=NONE gui=bold
highlight Italic guifg=NONE guibg=NONE guisp=NONE gui=italic
highlight Ignore guifg=#584D41 guibg=NONE guisp=NONE gui=NONE
highlight Error guifg=#D65C70 guibg=NONE guisp=NONE gui=NONE
highlight Todo guifg=#CC8033 guibg=NONE guisp=NONE gui=bold,italic
highlight! link TSConstant Constant
highlight TSConstBuiltin guifg=#997AB8 guibg=NONE guisp=NONE gui=italic
highlight TSConstMacro guifg=#997AB8 guibg=NONE guisp=NONE gui=bold
highlight! link TSNumber Number
highlight! link TSFloat Float
highlight! link TSBoolean Boolean
highlight! link TSCharacter Character
highlight! link TSString String
highlight! link TSStringRegex String
highlight TSStringEscape guifg=#85ADAD guibg=NONE guisp=NONE gui=italic
highlight TSSymbol guifg=#D194C7 guibg=NONE guisp=NONE gui=italic
highlight TSField guifg=#EDE6DE guibg=NONE guisp=NONE gui=NONE
highlight! link TSProperty TSField
highlight TSParameter guifg=#EDE6DE guibg=NONE guisp=NONE gui=NONE
highlight! link TSParameterReference TSParameter
highlight TSVariable guifg=#EDE6DE guibg=NONE guisp=NONE gui=NONE
highlight TSVariableBuiltin guifg=#EDE6DE guibg=NONE guisp=NONE gui=italic
highlight markdownLinkText guifg=#EDE6DE guibg=NONE guisp=NONE gui=NONE
highlight HelpHyperTextJump guifg=#F7C96E guibg=NONE guisp=NONE gui=NONE
highlight TSError guifg=#D65C70 guibg=NONE guisp=NONE gui=NONE
highlight! link TSURI TSSymbol
highlight! link TSLiteral TSString
highlight TSTitle guifg=#CC8033 guibg=NONE guisp=NONE gui=NONE
highlight TSStrong guifg=#EDE6DE guibg=NONE guisp=NONE gui=bold
highlight TSStrike guifg=#A38C75 guibg=NONE guisp=NONE gui=underline
highlight TSUnderline guifg=#EDE6DE guibg=NONE guisp=NONE gui=underline
highlight TSEmphasis guifg=#EDE6DE guibg=NONE guisp=NONE gui=italic
highlight TSText guifg=#EDE6DE guibg=NONE guisp=NONE gui=NONE
highlight! link TSTagDelimiter Special
highlight! link TSTag Tag
highlight! link TSComment Comment
highlight! link TSPunctSpecial Delimiter
highlight TSPunctBracket guifg=#CC9933 guibg=NONE guisp=NONE gui=NONE
highlight! link TSPunctDelimiter Delimiter
highlight TSTypeBuiltin guifg=#85ADAD guibg=NONE guisp=NONE gui=italic
highlight! link TSType Type
highlight LspDiagnosticsDefaultHint guifg=#4DB380 guibg=NONE guisp=NONE gui=NONE
highlight LspDiagnosticsDefaultInformation guifg=#EDE6DE guibg=NONE guisp=NONE gui=NONE
highlight LspDiagnosticsDefaultWarning guifg=#F7C96E guibg=NONE guisp=NONE gui=NONE
highlight LspDiagnosticsDefaultError guifg=#D65C70 guibg=NONE guisp=NONE gui=NONE
highlight SpellRare guifg=#F7C96E guibg=NONE guisp=NONE gui=underline
highlight SpellLocal guifg=#CC8033 guibg=NONE guisp=NONE gui=underline
highlight SpellCap guifg=#D194C7 guibg=NONE guisp=NONE gui=underline
highlight SpellBad guifg=#D65C70 guibg=NONE guisp=NONE gui=underline
highlight! link DiffRemoved DiffDelete
highlight! link DiffAdded DiffAdd
highlight DiffText guifg=#CC9933 guibg=NONE guisp=NONE gui=underline
highlight DiffChange guifg=#CC9933 guibg=NONE guisp=NONE gui=NONE
highlight DiffDelete guifg=#D65C70 guibg=NONE guisp=NONE gui=NONE
highlight DiffAdd guifg=#8BC270 guibg=NONE guisp=NONE gui=NONE
highlight! link QuickFixLine Search
highlight Search guifg=#2A2622 guibg=#F7C96E guisp=NONE gui=NONE
highlight TabLineFill guifg=NONE guibg=#38332E guisp=NONE gui=NONE
highlight! link PmenuThumb PmenuSel
highlight Visual guifg=NONE guibg=#38332E guisp=NONE gui=NONE
highlight! link TSInclude TSNamespace
