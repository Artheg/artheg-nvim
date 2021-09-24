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

vim.api.nvim_set_keymap( 'n', '<leader>e', ':CHADopen<CR>', {silent=true} )
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

------- LSP

plug {'neoclide/coc.nvim', branch='release'}

-- plug {'ms-jpq/coq.artifacts', branch='artifacts' }
-- plug {'nvim-treesitter/nvim-treesitter', run=':TSUpdate'}
-- plug 'tree-sitter/tree-sitter-typescript'
-- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
-- parser_config.typescript.used_by = { "typescript" }
plug {'ms-jpq/chadtree', branch='chad', run='python3 -m chadtree deps'}
-- require('lsp');

---- HTML
--local capabilities = vim.lsp.protocol.make_client_capabilities()
--capabilities.textDocument.completion.completionItem.snippetSupport = true

--require'lspconfig'.html.setup {
--  capabilities = capabilities,
--}

--nvim_lsp.html.setup{}

---- Angular
--local project_library_path = "/usr/lib/node_modules"
--local cmd = {"ngserver", "--stdio", "--tsProbeLocations", project_library_path , "--ngProbeLocations", project_library_path}

--require'lspconfig'.angularls.setup{
--  cmd = cmd,
--  on_attach = on_attach,
--  on_new_config = function(new_config,new_root_dir)
--    new_config.cmd = cmd
--  end,
--}
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
plug 'honza/vim-snippets'

-- Keybindings

vim.api.nvim_set_keymap('i', '<C-l>', '<Plug>(coc-snippets-vim)', {})

----- Floaterm

vim.api.nvim_set_keymap('n', '<F9>', ':FloatermToggle<cr>', {silent=true}) 
vim.api.nvim_set_keymap('t', '<F9>', '<C-\\><C-n>:FloatermToggle<CR>', {silent=true, noremap=true}) 

----- Git
vim.api.nvim_set_keymap('n', '<Leader>gg', ':!git gui<cr><cr>', {silent=true}) 
vim.api.nvim_set_keymap('n', '<Leader>gt', ':!alacritty -t tig -e tig <cr><cr>', {silent=true}) 

----- LSP
-- vim.api.nvim_set_keymap('n', '<Leader>k', ':lua vim.lsp.buf.code_action()<CR>', {silent=true}) 
-- vim.api.nvim_set_keymap('n', '<Leader>s', ':LspSignatureHelp<CR>', {silent=true}) 
-- vim.api.nvim_set_keymap('n', 'gf', ':LspDef<CR>', {silent=true}) 

----- Coc
vim.api.nvim_set_keymap('n', '<Leader>gf', ':CocFix<CR>', {silent=true}) 
vim.api.nvim_set_keymap('n', '<Leader>gto', ':CocCommand tsserver.organizeImports<CR>', {silent=true}) 

-- Angular
vim.api.nvim_set_keymap('n', '<Leader>ac', '/constructor<Esc>:nohl<cr>f(a<cr>', {silent=true}) 
vim.api.nvim_set_keymap('n', '<Leader>at', '/.component.html<cr>gd', {silent=true}) 

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
vim.api.nvim_set_keymap('i', '<C-v>', '<ESC>"+p<S-v>==ea', {noremap=true})
vim.api.nvim_set_keymap('v', '<C-c>', '"+y', {noremap=true})
vim.api.nvim_set_keymap('n', '<C-v>', '"+p', {noremap=true})
vim.api.nvim_set_keymap('v', '<C-S-v>', '"+p<S-v>==ea', {noremap=true})

----- coc.nvim
vim.api.nvim_set_keymap('n', 'K', ':call CocAction("doHover")<CR>', {silent=true} )
vim.api.nvim_set_keymap('n', 'gd', ':call CocAction("jumpDefinition")<CR>', {silent=true} )
