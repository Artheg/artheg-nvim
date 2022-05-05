-- options
--
-- relative and absolute number simultaneously
vim.opt.relativenumber = true
vim.opt.number = true
---- enable mouse selection
vim.opt.mouse = 'a'
---- smartcase search
vim.opt.ignorecase = true
vim.opt.smartcase = true
----  important for some themes I use
vim.opt.termguicolors = true
---- spaces instead tabs
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

---- syntax highlight
vim.opt.syntax = 'on'

---- cursor line
vim.cmd[[set cursorline]]

---- confirm save on q
vim.opt.confirm = true
---- hide buffers instead of closing them
vim.opt.hidden = true

---- disable highlight search
vim.cmd[[set nohlsearch]]

---- change active directory based on current active file
-- vim.opt.autochdir = true
----
---- indent based on filetype
-- vim.filetype.plugin = 'on'

---- start scrolling before reaching n*th line
vim.opt.scrolloff=25
----
-- vim.opt.updatetime=500

---- Resize vim's windows automatically on the terminal window resize
vim.cmd[[autocmd VimResized * wincmd =]]

---- Toggle tmux panel when entering/exiting vim
vim.cmd[[autocmd VimEnter,VimLeave * silent !tmux set status]]

-- Close quickfix and location list after selecting item
vim.cmd[[:autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>]]

----------------- packer plugin manager
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'ziglang/zig.vim'

  -- vifm integration
  -- use 'vifm/vifm.vim'

  use {'junegunn/fzf'}
  use {'junegunn/fzf.vim'}

  ---- automatically replaces words
  use 'AndrewRadev/switch.vim'
  vim.g['switch_custom_definitions'] = { 
    { "width", "height"}, 
    { "x", "y", "z" },
    { "top", "bottom", "Top", "Bottom" }
  }
  vim.cmd[[
    nnoremap <silent> <Plug>(SwitchInLine) :<C-u>call SwitchLine(v:count1)<cr>
    nmap <F3> <Plug>(SwitchInLine)w

    fun! SwitchLine(cnt)
        let tick = b:changedtick
        let start = getcurpos()
        for n in range(a:cnt)
            Switch
        endfor
        if b:changedtick != tick
            return
        endif
        while v:true
            let pos = getcurpos()
            normal! w
            if pos[1] != getcurpos()[1] || pos == getcurpos()
                break
            endif
            for n in range(a:cnt)
                Switch
            endfor
            if b:changedtick != tick
                return
            endif
        endwhile
        call setpos('.', start)
    endfun
  ]]

  ---- extends match (matches special words)
  use 'andymass/vim-matchup'

  ---- create themes with live preview
  use {'rktjmp/lush.nvim'}

  ---- lexima (autocomplete {} () etc.)
  ---- use 'cohama/lexima.vim'
  -- use 'windwp/nvim-autopairs'
  -- local has_npairs,npairs = pcall(require, 'nvim-autopairs')
  -- if has_npairs then
  --   npairs.setup({ map_bs = false, map_cr = false })
  -- end

  ---- git signs and hunk actions
  use {'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim'}
  use {'airblade/vim-gitgutter'}
  local has_gitsigns,gitsigns = pcall(require, 'gitsigns')
  if has_gitsigns then gitsigns.setup() end

  ---- Rooter
  use 'ahmedkhalf/project.nvim'
  local has_project_nvim,project_nvim = pcall(require, 'project_nvim')
  if has_project_nvim then
    project_nvim.setup{
      patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "tsconfig.json", "angular.json" },
      detection_methods = { "pattern", "lsp" }
    }
  end

  ---- ALE
  use 'dense-analysis/ale'
  vim.g['ale_fixers'] = {'eslint'}
  vim.g['ale_linters'] = { javascript = {'eslint'}, typescript = {'eslintd'} }
  vim.g['ale_javascript_eslint_executable'] = 'eslint_d'
  vim.g['ale_javascript_eslint_use_global'] = 1
  vim.g['ale_typescript_eslint_executable'] = 'eslint_d'
  vim.g['ale_typescript_eslint_use_global'] = 1
  ----

  ---- better word motion (e.g. CamelCase)
  use 'chaoren/vim-wordmotion'

  -- lf file manager
  use 'ptzz/lf.vim'
  vim.g['lf_replace_netrw'] = 1
  vim.g['lf_map_keys'] = 0

  -- floating terminal
  use 'voldikss/vim-floaterm'
  vim.api.nvim_set_keymap( 'n', '<leader>e', ':Lf<CR>', {silent=true} )
  --

  -- opening screen
  -- use 'mhinz/vim-startify'
  -- use 'glepnir/dashboard-nvim'
  vim.g['dashboard_default_executive'] = 'telescope'
  vim.g['dashboard_custom_header'] = {
    [[                                     ]],
    [[                                     ]],
    [[            &&&&&&&&&&&&&%           ]],
    [[        %&&&#            &&&%        ]],
    [[      &&%&                  &&&      ]],
    [[     %&&                      &&     ]],
    [[    %&%                       *&&    ]],
    [[    &&%        &&&&%&&&&&%     &&    ]],
    [[    &&&        &&&&&&&&&&&&&   &&    ]],
    [[     &&#       &&&&&&&&&&&&&&&&&%    ]],
    [[      &&%,,,,,,&&&&&&&&&&&&&&&&%     ]],
    [[       (&&&&&&&&&&&&&&&&&&&&&%       ]],
    [[          %&&&&&&&&&&&&&&&&          ]],
    [[                #%%&&#               ]],
    [[                                     ]],
    [[      Right man in the wrong place   ]],
    [[      can make all the difference    ]],
    [[             in the world            ]],
    [[              ⠉⠉⠛⠛⠛⠛⠛⠛⠉⠉             ]],
    [[                                     ]],
    [[                                     ]],
    [[                                     ]],
    [[                                     ]],
    [[                                     ]],
    [[                                     ]],
    [[                                     ]],
    [[                                     ]],
    [[                                     ]]
  }
  vim.g['dashboard_custom_footer'] = {}

  ---- status line
  -- use 'adelarsq/neoline.vim'
  -- use 'vimpostor/vim-tpipeline'
  -- use 'itchyny/lightline.vim'
  -- vim.g.lightline = { colorscheme='melange' }
  ----

  ---- formatter
  use 'sbdchd/neoformat'

  ---- commenter
  use 'tpope/vim-commentary'

  ---- Telescope (highly extendable fuzzy finder over lists. Built on the latest awesome features from neovim)
  use {'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim'}
  local has_telescope,telescope = pcall(require, 'telescope')
  if has_telescope then telescope.load_extension('projects') end
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }  
  use {'nvim-telescope/telescope-fzy-native.nvim' }  
  require('telescope').load_extension('fzf')
  require('telescope').load_extension('fzy_native')

  ---- highlight hex colors
  use 'chrisbra/Colorizer'

  ---- better surrounding chars edit
  use 'tpope/vim-surround'

  ------- git
  ----
  ---- blamer
  -- use 'APZelos/blamer.nvim'
  use 'f-person/git-blame.nvim'
  vim.g.gitblame_date_format = "%d.%m.%y %H:%M"
  vim.g.gitblame_message_template = "<author> (<committer-date>) • <summary>"
  ----

  -----

  ------- LSP

  -- use {'neoclide/coc.nvim', branch='release'}

  use {'ms-jpq/coq.artifacts', branch='artifacts' }
  use {'nvim-treesitter/nvim-treesitter', run=':TSUpdate'}
  local has_nvim_treesitter,nvim_treesitter = pcall(require, 'nvim-treesitter.configs')
  if has_nvim_treesitter then
    nvim_treesitter.setup{
      highlight = {
        enable = true
      },
      matchup = {
        enable = true
      }
    }
  end
  -- use 'tree-sitter/tree-sitter-typescript'
  if has_nvim_treesitter then
    local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
    -- parser_config.typescript.used_by = { "typescript" }
    -- parser_config.c.used_by = { "c" }
  end

  require('lsp').startup(use)


  -- Keybindings

  ----- Navigation
  vim.api.nvim_set_keymap('n', '<A-h>', ':tabprev<CR>', { silent = true, noremap = true })
  vim.api.nvim_set_keymap('n', '<A-l>', ':tabnext<CR>', { silent = true, noremap = true })
  vim.api.nvim_set_keymap('n', '<Leader>ct', ':tabclose<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<Leader>nt', ':tabnew<CR>', { silent = true })

  -- center screen when focusing on search occurences
  vim.api.nvim_set_keymap('n', 'n', 'nzzzv', { noremap = true })
  vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', { noremap = true })

  -- buffer
  vim.api.nvim_set_keymap('n', '<A-j>', ':bnext<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<A-k>', ':bprevious<CR>', { silent = true })

  -- better history jumping
  vim.cmd[[
    nnoremap <expr> j (v:count > 1 ? "m'" . v:count : "") . 'j'
    nnoremap <expr> k (v:count > 1 ? "m'" . v:count : "") . 'k'
  ]]

  -- vim.api.nvim_set_keymap('i', '<C-l>', '<Plug>(coc-snippets-vim)', {})

  ----- quickfix
  vim.api.nvim_set_keymap('n', '<C-j>', ':cnext<CR>', {})
  vim.api.nvim_set_keymap('n', '<C-k>', ':cprevious<CR>', {})
  vim.api.nvim_set_keymap('n', '<Leader>cc', ':cclose<CR>', {})
  vim.api.nvim_set_keymap('n', '<Leader>co', ':copen<CR>', {})
  vim.api.nvim_set_keymap('n', '<esc>', ':cclose<CR>', { silent = true })

  ------- Dashboard
  -- vim.api.nvim_set_keymap('n','<Leader>fb',':DashboardJumpMark<CR>', { noremap = true , silent = false })
  -- vim.api.nvim_set_keymap('n','<Leader>tc',':DashboardChangeColorscheme<CR>', { noremap = true , silent = false })
  -- vim.api.nvim_set_keymap('n','<Leader>ff',':DashboardFindFile<CR>', { noremap = true , silent = false })
  -- vim.api.nvim_set_keymap('n','<Leader>fh',':DashboardFindHistory<CR>', { noremap = true , silent = false })
  -- vim.api.nvim_set_keymap('n','<Leader>fa',':DashboardFindHistory<CR>', { noremap = true , silent = false })
  -- vim.api.nvim_set_keymap('n','<Leader>sl',':<C-u>SessionLoad<CR>', { noremap = true , silent = false })
  -- vim.api.nvim_set_keymap('n','<Leader>fa',':DashboardFindWord<CR>', { noremap = true , silent = false })
  -- vim.api.nvim_set_keymap('n','<Leader>cn',':DashboardNewFile<CR>i', { noremap = true , silent = false })

  ------- Floaterm
  vim.api.nvim_set_keymap('n', '<F9>', ':FloatermToggle<cr>', {silent=true})
  vim.api.nvim_set_keymap('t', '<F9>', '<C-\\><C-n>:FloatermToggle<CR>', {silent=true, noremap=true})
  vim.g.floaterm_opener = 'drop'

  ------- Git
  vim.api.nvim_set_keymap('n', '<Leader>gg', ':!git gui<cr><cr>', {silent=true})
  vim.api.nvim_set_keymap('n', '<Leader>gt', ':tabnew | :edit term://tig<CR>i', {silent=true})

  ------- Coc
  ---- vim.api.nvim_set_keymap('n', '<Leader>gf', ':CocFix<CR>', {silent=true})
  ---- vim.api.nvim_set_keymap('n', '<Leader>gto', ':CocCommand tsserver.organizeImports<CR>', {silent=true})

  ---- Angular
  vim.api.nvim_set_keymap('n', '<Leader>ac', '/constructor<Esc>:nohl<cr>f(a<cr>', {silent=true})
  vim.api.nvim_set_keymap('n', '<Leader>at', '/.component.html<cr>gd', {silent=true})

  -------

  ---- LSP
  vim.api.nvim_set_keymap('n', '<Leader>ld', ':LspDiagLine<CR>', { silent = true })

  ------- Telescope
  vim.api.nvim_set_keymap('n', '<Leader>tt', ':Telescope<CR>', {silent=true})

  vim.api.nvim_set_keymap('n', '<Leader>tb', ':Buffers<CR>', {silent=true})
  vim.api.nvim_set_keymap('n', '<Leader>tr', ':Rg:<CR>', {silent=true})
  vim.api.nvim_set_keymap('n', '<Leader>tf', ':Files<CR>', {silent=true})
  vim.api.nvim_set_keymap('n', '<F1>', ':Telescope oldfiles<CR>', {silent=true, noremap = true})
  vim.api.nvim_set_keymap('i', '<F1>', ':Telescope oldfiles<CR>', {silent=true, noremap = true})
  -- vim.api.nvim_set_keymap('n', '<Leader>tr', ':Telescope live_grep<CR>', {silent=true})
  -- vim.api.nvim_set_keymap('n', '<Leader>tf', ':Telescope find_files<CR>', {silent=true})
  -- vim.api.nvim_set_keymap('n', '<Leader>tp', ':Telescope projects<CR>', {silent=true})
  -- vim.api.nvim_set_keymap('n', '<Leader>tgb', ':Telescope git_branches<CR>', {silent=true})
  -- vim.api.nvim_set_keymap('n', '<Leader>tgc', ':Telescope git_commits<CR>', {silent=true})
  -- vim.api.nvim_set_keymap('n', '<Leader>tgs', ':Telescope git_status<CR>', {silent=true})
  -----

  ----- Windows
  vim.cmd[[
  let windowMaximized = 1
  function! ToggleWindowMaximize()
  if g:windowMaximized
    :exe "normal \<C-w>_ \<C-w>|"
    let g:windowMaximized = 0
  else
    :exe "normal \<C-w>="
    let g:windowMaximized = 1
    endif
    endfunction
    ]]
    vim.api.nvim_set_keymap('n', 'L', '<c-w><c-w>', {silent=true})
    vim.api.nvim_set_keymap('n', 'H', '<c-w>W', {silent=true})
    vim.api.nvim_set_keymap('n', '<C-x>', ':call ToggleWindowMaximize()<cr>', {silent=true})
    -----

    ----- Edit
    -- Emacs-like movement for insert mode
    vim.api.nvim_set_keymap('i', '<C-b>', '<C-o>b', {})
    vim.api.nvim_set_keymap('i', '<C-f>', '<C-o>w', {})
    vim.api.nvim_set_keymap('i', '<C-a>', '<C-o>I', {})
    vim.api.nvim_set_keymap('i', '<C-e>', '<C-o>A', {})

    -- make Y behave as other capital letters by default
    vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap=true })
    -- save all
    vim.api.nvim_set_keymap('n', '<C-A-s>', ':wall<CR>', {})
    vim.api.nvim_set_keymap('i', '<C-A-s>', ':wall<CR>', {})
    -- save current
    vim.api.nvim_set_keymap('n', '<C-s>', '<ESC>:w<CR>', {})
    vim.api.nvim_set_keymap('i', '<C-s>', '<ESC>:w<CR>', {})
    -----

    ------ Move
    vim.api.nvim_set_keymap('v', 'J', ':m \'>+1<CR>gv=gv', {})
    vim.api.nvim_set_keymap('v', 'K', ':m \'<-2<CR>gv=gv', {})

    ----- Format
    -- auto indent on paste
    vim.api.nvim_set_keymap('n', 'p', 'p`[v`]=', { noremap=true })
    vim.api.nvim_set_keymap('n', 'P', 'P`[v`]=', { noremap=true })
    -- vim.api.nvim_set_keymap('n', '<C-p>', ']p', { noremap=true })
    -- vim.api.nvim_set_keymap('n', '<C-P>', 'P', { noremap=true })

    vim.api.nvim_set_keymap('n', '<F10>', '<ESC>:Neoformat | ALEFix<CR>', {})
    vim.api.nvim_set_keymap('n', '<C-S-i>', '<ESC>:Neoformat<CR>a', { noremap=true })
    vim.api.nvim_set_keymap('i', '<C-S-i>', '<ESC>:Neoformat<CR>a', { noremap=true })
    -----

    ----- Clipboard
    vim.api.nvim_set_keymap('i', '<C-v>', '<ESC>"+p<S-v>==ea', {noremap=true})
    vim.api.nvim_set_keymap('v', '<C-c>', '"+y', {noremap=true})
    vim.api.nvim_set_keymap('n', '<C-S-v>', '"+p', {noremap=true})
    vim.api.nvim_set_keymap('v', '<C-v>', '"+p<S-v>==ea', {noremap=true})

    ----- Terminal
    -- vim.api.nvim_set_keymap('n', '<A-t>', ':terminal tig<cr>i', {noremap=true, silent=true})

    ----- coc.nvim
    -- vim.api.nvim_set_keymap('n', 'K', ':call CocAction("doHover")<CR>', {silent=true} )
    -- vim.api.nvim_set_keymap('n', 'gd', ':call CocAction("jumpDefinition")<CR>', {silent=true} )


    ----- colorschemes
    use 'kyazdani42/blue-moon'
    use 'bluz71/vim-nightfly-guicolors'
    use 'Pocco81/Catppuccino.nvim'
    use 'kdheepak/monochrome.nvim'
    use 'flazz/vim-colorschemes'
    use 'savq/melange'
    use 'fenetikm/falcon'
    use 'ayu-theme/ayu-vim'

    vim.g.falcon_background = 0
    vim.g.falcon_inactive = 1

    vim.cmd[[colorscheme OceanicNext]]
    vim.cmd[[colorscheme halflife]]
    -- transparent bg
    -- vim.cmd[[autocmd vimenter * hi Normal guibg=none guifg=none ctermbg=none ctermfg=none]]
    -- vim.cmd[[autocmd vimenter * hi NormalNC guibg=none guifg=none ctermbg=none ctermfg=none]]
    -- vim.cmd[[autocmd vimenter * hi NonText guibg=none guifg=none ctermbg=none ctermfg=none]]
    -- vim.cmd[[autocmd vimenter * hi Visual guibg=#333344 guifg=none ctermbg=none ctermfg=none]]
    -- -- -- coloscheme switcher
    -- use 'xolox/vim-misc'
    -- use 'xolox/vim-colorscheme-switcher'
    -- -- use 'honza/vim-snippets'
    vim.cmd[[
    " Open multiple lines (insert empty lines) before or after current line,
    " and position cursor in the new space, with at least one blank line
    " before and after the cursor.

    function! OpenLines(nrlines, dir)
    let nrlines = a:nrlines < 3 ? 3 : a:nrlines
    let start = line('.') + a:dir
    call append(start, repeat([''], nrlines))
    if a:dir < 0
      normal! 2k
    else
      normal! 2j
      endif
      endfunction
      " Mappings to open multiple lines and enter insert mode.
      nnoremap <Leader>o :<C-u>call OpenLines(v:count, 0)<CR>S
      nnoremap <Leader>O :<C-u>call OpenLines(v:count, -1)<CR>S
    ]]

    if packer_bootstrap then
      require('packer').sync()
    end
  end)
