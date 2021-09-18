-- options
-- 
-- relative and absolute number simulte simultaneously
vim.opt.relativenumber = true
vim.opt.number = true
-- enable mouse selection
vim.opt.mouse = 'a'
-- smartcase search
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- syntax highlight
vim.opt.syntax = 'on'
--  important for some themes I use
vim.opt.termguicolors = true
-- spaces instead tabs
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.scrolloff = 25

-- confirm save on q
vim.opt.confirm = true
-- hide buffers instead of closing them
vim.opt.hidden = true

-- change active directory based on current active file
-- vim.opt.autochdir = true
--
-- indent based on filetype
-- vim.filetype.plugin = 'on'

-- start scrolling before reaching n*th line
vim.opt.scrolloff=25
-- 
vim.opt.updatetime=500

-- Resize vim's windows automatically on the terminal window resize
vim.cmd[[autocmd VimResized * wincmd =]]

----------------- PAQ plugin manager
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path})
end

-- Set the short hand
local plug = require('paq-nvim').paq

-- Make paq manage it self
plug {'savq/paq-nvim', opt=true}

-- lexima (autocomplete {} () etc.)
plug 'cohama/lexima.vim'

-- Rooter
plug 'ahmedkhalf/project.nvim'
require("project_nvim").setup{
  patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "tsconfig.json", "angular.json" },
  detection_methods = { "pattern", "lsp" }
}

-- ALE
plug 'dense-analysis/ale'
vim.g['ale_fixers'] = {'eslint'}
vim.g['ale_linters'] = { javascript = {'eslintd'}, typescript = {'eslintd'} }
-- floating terminal
plug 'voldikss/vim-floaterm'
--

-- lf file manager
plug 'ptzz/lf.vim'
vim.g['lf_replace_netrw'] = 1
vim.g['lf_map_keys'] = 0

vim.api.nvim_set_keymap( 'n', '<leader>e', ':lua require("telescope.builtin").file_browser({cwd = vim.fn.expand("%:p:h")})<CR>', {} )
--

-- opening screen
-- plug 'mhinz/vim-startify'
plug 'glepnir/dashboard-nvim'
vim.g['dashboard_default_executive'] = 'telescope'
vim.g['dashboard_custom_header'] = {

  [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀          ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
  [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀          ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
  [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀          ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
  [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀          ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
  [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀          ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
  [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀          ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
  [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣠⣤⣤⣴⣦⣤⣤⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
  [[⠀⠀⠀⠀⠀⠀⢀⣤⣾⣿⣿⣿⣿⠿⠿⠿⠿⣿⣿⣿⣿⣶⣤⡀⠀⠀⠀⠀⠀⠀ ]],
  [[⠀⠀⠀⠀⣠⣾⣿⣿⡿⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⢿⣿⣿⣶⡀⠀⠀⠀⠀ ]],
  [[⠀⠀⠀⣴⣿⣿⠟⠁⠀⠀⠀⣶⣶⣶⣶⡆⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⣦⠀⠀⠀ ]],
  [[⠀⠀⣼⣿⣿⠋⠀⠀⠀⠀⠀⠛⠛⢻⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠙⣿⣿⣧⠀⠀ ]],
  [[⠀⢸⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⡇⠀ ]],
  [[⠀⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⠀ ]],
  [[⠀⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⡟⢹⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⣹⣿⣿⠀ ]],
  [[⠀⣿⣿⣷⠀⠀⠀⠀⠀⠀⣰⣿⣿⠏⠀⠀⢻⣿⣿⡄⠀⠀⠀⠀⠀⠀⣿⣿⡿⠀ ]],
  [[⠀⢸⣿⣿⡆⠀⠀⠀⠀⣴⣿⡿⠃⠀⠀⠀⠈⢿⣿⣷⣤⣤⡆⠀⠀⣰⣿⣿⠇⠀ ]],
  [[⠀⠀⢻⣿⣿⣄⠀⠀⠾⠿⠿⠁⠀⠀⠀⠀⠀⠘⣿⣿⡿⠿⠛⠀⣰⣿⣿⡟⠀⠀ ]],
  [[⠀⠀⠀⠻⣿⣿⣧⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⠏⠀⠀⠀ ]],
  [[⠀⠀⠀⠀⠈⠻⣿⣿⣷⣤⣄⡀⠀⠀⠀⠀⠀⠀⢀⣠⣴⣾⣿⣿⠟⠁⠀⠀⠀⠀ ]],
  [[⠀⠀⠀⠀⠀⠀⠈⠛⠿⣿⣿⣿⣿⣿⣶⣶⣿⣿⣿⣿⣿⠿⠋⠁⠀⠀⠀⠀⠀⠀ ]],
  [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⠛⠛⠛⠛⠛⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
  [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀          ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
  [[  Right man in the wrong place ]],
  [[  can make all the difference  ]],
  [[         in the world          ]],
  [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⠛⠛⠛⠛⠛⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
  [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀          ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
  [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀          ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
  [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀          ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
  [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀          ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
  [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀          ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
  [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀          ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
  [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀          ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
  [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀          ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
  [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀          ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
}
vim.g['dashboard_custom_footer'] = {}

-- bottom line
plug 'itchyny/lightline.vim'
--

-- formatter
plug 'sbdchd/neoformat'

-- commenter
plug 'tpope/vim-commentary'

-- Telescope (highly extendable fuzzy finder over lists. Built on the latest awesome features from neovim)
plug 'nvim-lua/plenary.nvim'
plug 'nvim-telescope/telescope.nvim'
require('telescope').load_extension('projects')

----- git

-- blamer
-- plug 'APZelos/blamer.nvim'
plug 'f-person/git-blame.nvim'
vim.g.gitblame_date_format = "%d.%m.%y %H:%M"
vim.g.gitblame_message_template = "<author> (<committer-date>) • <summary>"
--

-----

----- LSP

-- Neovim LSP Integration
plug 'neovim/nvim-lspconfig'

-- treesitter (syntax parser)
plug {'nvim-treesitter/nvim-treesitter', run=':TSUpdate'}
plug 'tree-sitter/tree-sitter-typescript'
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.typescript.used_by = { "typescript" }

-- coq_nvim autocompletion
plug {'ms-jpq/coq_nvim', branch='coq' }
vim.g.coq_settings = { auto_start=true }

-- lots of snippets from ms-jpg
plug {'ms-jpq/coq.artifacts', branch='artifacts' }

plug {'ms-jpq/chadtree', branch='chad', run='python3 -m chadtree deps'}

----- Typescript

-- highlighter
plug 'leafgarland/typescript-vim'

local nvim_lsp = require("lspconfig")
local format_async = function(err, _, result, _, bufnr)
    if err ~= nil or result == nil then return end
    if not vim.api.nvim_buf_get_option(bufnr, "modified") then
        local view = vim.fn.winsaveview()
        vim.lsp.util.apply_text_edits(result, bufnr)
        vim.fn.winrestview(view)
        if bufnr == vim.api.nvim_get_current_buf() then
            vim.api.nvim_command("noautocmd :update")
        end
    end
end
vim.lsp.handlers["textDocument/formatting"] = format_async
_G.lsp_organize_imports = function()
    local params = {
        command = "_typescript.organizeImports",
        arguments = {vim.api.nvim_buf_get_name(0)},
        title = ""
    }
    vim.lsp.buf.execute_command(params)
end
local on_attach = function(client, bufnr)
    local buf_map = vim.api.nvim_buf_set_keymap
    vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
    vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
    vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
    vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
    vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
    vim.cmd("command! LspOrganize lua lsp_organize_imports()")
    vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
    vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
    vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
    vim.cmd("command! LspDiagPrev lua vim.lsp.diagnostic.goto_prev()")
    vim.cmd("command! LspDiagNext lua vim.lsp.diagnostic.goto_next()")
    vim.cmd(
        "command! LspDiagLine lua vim.lsp.diagnostic.show_line_diagnostics()")
    vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
buf_map(bufnr, "n", "gd", ":LspDef<CR>", {silent = true})
    buf_map(bufnr, "n", "gr", ":LspRename<CR>", {silent = true})
    buf_map(bufnr, "n", "gR", ":LspRefs<CR>", {silent = true})
    buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>", {silent = true})
    buf_map(bufnr, "n", "K", ":LspHover<CR>", {silent = true})
    buf_map(bufnr, "n", "gs", ":LspOrganize<CR>", {silent = true})
    buf_map(bufnr, "n", "[a", ":LspDiagPrev<CR>", {silent = true})
    buf_map(bufnr, "n", "]a", ":LspDiagNext<CR>", {silent = true})
    buf_map(bufnr, "n", "ga", ":LspCodeAction<CR>", {silent = true})
    buf_map(bufnr, "n", "gf", ":LspFormatting<CR>", {silent = true})
    buf_map(bufnr, "n", "<Leader>a", ":LspDiagLine<CR>", {silent = true})
    buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>",
              {silent = true})
if client.resolved_capabilities.document_formatting then
        vim.api.nvim_exec([[
         augroup LspAutocommands
             autocmd! * <buffer>
             autocmd BufWritePost <buffer> LspFormatting
         augroup END
         ]], true)
    end
end
nvim_lsp.tsserver.setup {
    on_attach = function(client)
        client.resolved_capabilities.document_formatting = false
        on_attach(client)
    end
}
local filetypes = {
    typescript = "eslint",
    typescriptreact = "eslint",
    html = "eslint"
}
local linters = {
    eslint = {
        sourceName = "eslint_d",
        command = "eslint_d",
        rootPatterns = {".eslintrc.json", "package.json"},
        debounce = 100,
        args = {"--stdin", "--stdin-filename", "%filepath", "--format", "json"},
        parseJson = {
            errorsRoot = "[0].messages",
            line = "line",
            column = "column",
            endLine = "endLine",
            endColumn = "endColumn",
            message = "${message} [${ruleId}]",
            security = "severity"
        },
        securities = {[2] = "error", [1] = "warning"}
    }
}
local formatters = {
    prettier = {command = "prettierd", args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)}, rootPatterns = {".eslintrc.json", "package.json"}}
}
local formatFiletypes = {
    typescript = "prettierd",
    typescriptreact = "prettierd"
}
nvim_lsp.diagnosticls.setup {
    on_attach = on_attach,
    filetypes = vim.tbl_keys(filetypes),
    init_options = {
        filetypes = filetypes,
        linters = linters,
        formatters = formatters,
        formatFiletypes = formatFiletypes
    }
}
-----

-- HTML
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.html.setup {
  capabilities = capabilities,
}

nvim_lsp.html.setup{}

-- Angular
local project_library_path = "/usr/lib/node_modules"
local cmd = {"ngserver", "--stdio", "--tsProbeLocations", project_library_path , "--ngProbeLocations", project_library_path}

require'lspconfig'.angularls.setup{
  cmd = cmd,
  on_attach = on_attach,
  on_new_config = function(new_config,new_root_dir)
    new_config.cmd = cmd
  end,
}
----- colorschemes
plug 'bluz71/vim-nightfly-guicolors'
plug 'Pocco81/Catppuccino.nvim'
plug 'kdheepak/monochrome.nvim'
plug 'flazz/vim-colorschemes'

-- transparent bg
vim.cmd[[au ColorScheme * hi Normal ctermbg=none guibg=none]]
vim.cmd[[au ColorScheme * hi Normal ctermbg=none guibg=none]]
vim.cmd[[colorscheme ayu]]
-- vim.api.nvim_command('COQnow')

-- coloscheme switcher
plug 'xolox/vim-misc'
plug 'xolox/vim-colorscheme-switcher'

-- Keybindings

----- Floaterm

vim.api.nvim_set_keymap('n', '<F9>', ':FloatermToggle<cr>', {silent=true}) 
vim.api.nvim_set_keymap('t', '<F9>', '<C-\\><C-n>:FloatermToggle<CR>', {silent=true, noremap=true}) 

----- Git
vim.api.nvim_set_keymap('n', '<Leader>gg', ':!git gui<cr><cr>', {silent=true}) 
vim.api.nvim_set_keymap('n', '<Leader>gt', ':!alacritty -t tig -e tig <cr><cr>', {silent=true}) 

----- LSP
vim.api.nvim_set_keymap('n', '<Leader>k', ':lua vim.lsp.buf.code_action()<CR>', {silent=true}) 
vim.api.nvim_set_keymap('n', '<Leader>s', ':LspSignatureHelp<CR>', {silent=true}) 
vim.api.nvim_set_keymap('n', 'gf', ':LspDef<CR>', {silent=true}) 

-- Angular
vim.api.nvim_set_keymap('n', '<Leader>ac', '/constructor<Esc>:nohl<cr>f(a<cr>', {silent=true}) 
vim.api.nvim_set_keymap('n', '<Leader>at', '/.component.html<cr>gf', {silent=true}) 

-----

----- Telescope
vim.api.nvim_set_keymap('n', '<Leader>tt', ':Telescope<CR>', {silent=true}) 
vim.api.nvim_set_keymap('n', '<Leader>tgb', ':Telescope git_branches<CR>', {silent=true}) 
vim.api.nvim_set_keymap('n', '<Leader>tgc', ':Telescope git_commits<CR>', {silent=true}) 
vim.api.nvim_set_keymap('n', '<Leader>tgs', ':Telescope git_status<CR>', {silent=true}) 
vim.api.nvim_set_keymap('n', '<Leader>tb', ':Telescope buffers<CR>', {silent=true}) 
vim.api.nvim_set_keymap('n', '<Leader>tr', ':Telescope live_grep<CR>', {silent=true}) 
vim.api.nvim_set_keymap('n', '<Leader>tf', ':Telescope find_files<CR>', {silent=true}) 
vim.api.nvim_set_keymap('n', '<Leader>tp', ':Telescope projects<CR>', {silent=true}) 
-----

----- Windows
vim.api.nvim_set_keymap('n', 'L', '<c-w><c-w>', {silent=true}) 
vim.api.nvim_set_keymap('n', 'H', '<c-w>W', {silent=true}) 
-----

----- CHADTree
vim.api.nvim_set_keymap('n', '<c-b>', ':CHADopen<cr>', {silent=true})
-----

----- Edit
-- save all
vim.api.nvim_set_keymap('n', '<C-A-s>', ':wall<CR>', {}) 
vim.api.nvim_set_keymap('i', '<C-A-s>', ':wall<CR>', {}) 
-- save current
vim.api.nvim_set_keymap('n', '<C-s>', '<ESC>:w<CR>', {}) 
vim.api.nvim_set_keymap('i', '<C-s>', '<ESC>:w<CR>a', {}) 
-----

----- Format
vim.api.nvim_set_keymap('n', '<F10>', ':Neoformat<CR>', {})
vim.api.nvim_set_keymap('i', '<F10>', '<ESC>:Neoormat<CR>a', {})
-----

----- Clipboard
vim.api.nvim_set_keymap('i', '<C-v>', '<ESC>+p<S-v>==ea', {noremap=true})
vim.api.nvim_set_keymap('v', '<C-c>', '<ESC>"+p<S-v>==ea', {noremap=true})
vim.api.nvim_set_keymap('n', '<C-S-v>', '"+p', {noremap=true})
vim.api.nvim_set_keymap('v', '<C-d>', '"+d', {noremap=true})
