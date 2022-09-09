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

vim.opt.background = "dark"

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

  require('plugin-list').startup(use)
  if packer_bootstrap then
    require('packer').sync()
  end


  require('lsp-config')

  -- 'mfussenegger/nvim-dap' (debugger)
  local dap = require('dap')

  vim.api.nvim_set_keymap( 'n', '<F6>', ':lua require("dap").clear_breakpoints()<CR>', {} )
  vim.api.nvim_set_keymap( 'n', '<F7>', ':DapContinue<CR>', {} )
  vim.api.nvim_set_keymap( 'n', '<F8>', ':lua require("dap.ui.widgets").hover()<CR>', {silent=true} )
  vim.api.nvim_set_keymap( 'n', '<F9>', ':DapToggleBreakpoint<CR>', {silent=true} )
  vim.api.nvim_set_keymap( 'n', '<F10>', ':DapStepOver<CR>', {} )
  vim.api.nvim_set_keymap( 'n', '<F11>', ':DapStepInto<CR>', {} )
  vim.api.nvim_set_keymap( 'n', '<F12>', ':DapStepOut<CR>', {} )
  dap.adapters.chrome = {
    type = "executable",
    command = "node",
    args = {os.getenv("HOME") .. "/git/vscode-chrome-debug/out/src/chromeDebug.js"} -- TODO adjust
  }
  vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='BP', linehl='LineBreakpoint', numhl=''})

  dap.configurations.javascript = {
    {
      type = "chrome",
      request = "attach",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      port = 9222,
      webRoot = "${workspaceFolder}"
    }
  }

  dap.configurations.typescript = {
    {
      type = "chrome",
      request = "attach",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      port = 9222,
      webRoot = "${workspaceFolder}",
    }
  }

  ---- switch.vim (automatically replaces words)
  vim.g['switch_custom_definitions'] = { 
    { "width", "height"}, 
    { "Width", "Height"}, 
    { "x", "y", "z" },
    { "top", "bottom", "Top", "Bottom" },
    { "left", "right" },
    { "add", "remove" },
  }
  vim.cmd[[
  nnoremap <silent> <Plug>(SwitchInLine) :<C-u>call SwitchLine(v:count1)<cr>
  nmap <F4> <Plug>(SwitchInLine)w

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

  ---- lewis6991/gitsigns.nvim (git signs and hunk actions)
  local gitsigns = require('gitsigns')
  gitsigns.setup()

  -- ahmedkhalf/project.nvim (Rooter)
  local project_nvim = require('project_nvim')
  project_nvim.setup{
    patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "tsconfig.json", "angular.json" },
    detection_methods = { "pattern", "lsp" }
  }

  -- dense-analysis/ale
  vim.g['ale_fixers'] = {'eslint'}
  vim.g['ale_linters'] = { javascript = {'eslint'}, typescript = {'eslintd'} }
  vim.g['ale_javascript_eslint_executable'] = 'eslint_d'
  vim.g['ale_javascript_eslint_use_global'] = 1
  vim.g['ale_typescript_eslint_executable'] = 'eslint_d'
  vim.g['ale_typescript_eslint_use_global'] = 1
  vim.g['ale_fix_on_save'] = 1
  --


  -- ptzz/lf.vim (lf file manager)
  vim.g['lf_replace_netrw'] = 1
  vim.g['lf_map_keys'] = 0
  --

  -- voldikss/vim-floaterm (floating terminal)
  vim.api.nvim_set_keymap( 'n', '<leader>e', ':Lf<CR>', {silent=true} )
  --

  -- RRethy/vim-illuminate (highlight other uses of words)
  vim.cmd
  [[
    augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi illuminatedWord ctermbg=DarkBlue guibg=DarkBlue
    augroup END
  ]]
  --
  
  -- nvim-treesitter/nvim-treesitter
  local treesitter = require('nvim-treesitter.configs')
  treesitter.setup {
    ensure_installed = { "c", "lua", "typescript", "zig" }
  }
  --

  ---- nvim-telescope/telescope.nvim 
  local telescope = require('telescope')
  telescope.load_extension('projects')
  telescope.load_extension('fzf')
  telescope.load_extension('fzy_native')

  ---- chrisbra/Colorizer
  vim.api.nvim_set_keymap('n', '<leader>c', ':ColorHighlight<CR>', { silent = true, noremap = true })


  -- 'lukas-reineke/indent-blankline.nvim'
  vim.opt.list = true
  vim.opt.listchars:append "space:⋅"
  vim.opt.listchars:append "eol:↴"

  local indent_blankline = require('indent_blankline')
  indent_blankline.setup {
    show_end_of_line = true,
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true
  }

  ---- f-person/git-blame.nvim (git blamer)
  vim.g.gitblame_date_format = "%d.%m.%y %H:%M"
  vim.g.gitblame_message_template = "<author> (<committer-date>) • <summary>"
  ----

  -----

  ------- LSP

  local nvim_treesitter = require('nvim-treesitter.configs')
  nvim_treesitter.setup{
    highlight = {
      enable = true
    },
    matchup = {
      enable = true
    }
  }

  -----

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
  vim.api.nvim_set_keymap('n', '<C-k>', ':cprevious<CR>', { noremap = true })
  vim.api.nvim_set_keymap('n', '<Leader>cc', ':cclose<CR>', {})
  vim.api.nvim_set_keymap('n', '<Leader>co', ':copen<CR>', {})
  vim.api.nvim_set_keymap('n', '<esc>', ':cclose<CR>', { silent = true })

  ------- Floaterm
  vim.api.nvim_set_keymap('n', '<F2>', ':FloatermToggle<cr>', {silent=true})
  vim.api.nvim_set_keymap('t', '<F2>', '<C-\\><C-n>:FloatermToggle<CR>', {silent=true, noremap=true})
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

  ----- vim-snip
  vim.api.nvim_set_keymap('i', '<Tab>', 'vsnip#jumpable(1) ? \'<Plug>(vsnip-jump-next)\' : \'<Tab>\'', {silent=true, expr=true})
  vim.api.nvim_set_keymap('i', '<S-Tab>', 'vsnip#jumpable(-1) ? \'<Plug>(vsnip-jump-prev)\' : \'<S-Tab>\'', {silent=true, expr=true})

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

  vim.api.nvim_set_keymap('n', '<F3>', '<ESC>:Neoformat | ALEFix<CR>', {})
  vim.api.nvim_set_keymap('n', '<C-S-i>', '<ESC>:Neoformat<CR>a', { noremap=true })
  vim.api.nvim_set_keymap('i', '<C-S-i>', '<ESC>:Neoformat<CR>a', { noremap=true })
  -----

  ----- Clipboard
  vim.api.nvim_set_keymap('i', '<C-v>', '<ESC>"+p<S-v>==ea', {noremap=true})
  vim.api.nvim_set_keymap('v', '<C-c>', '"+y', {noremap=true})
  vim.api.nvim_set_keymap('n', '<C-S-v>', '"+p', {noremap=true})
  vim.api.nvim_set_keymap('v', '<C-v>', '"+p<S-v>==ea', {noremap=true})

  -- vim.g.falcon_background = 1
  -- vim.g.falcon_inactive = 1

  -- vim.cmd[[colorscheme OceanicNext]]
  -- vim.cmd[[colorscheme blue-moon]]
  -- vim.cmd[[colorscheme farout]]
  -- vim.cmd[[colorscheme deus]]
  vim.cmd[[colorscheme falcon]]
  vim.highlight.create('LineBreakpoint', { ctermbg=0, guibg='#511111' }, false)
  vim.highlight.create('DapStopped', { ctermbg=0, guifg='#98c379', guibg='#31353f' }, false)

  -- transparent bg
  -- vim.cmd[[autocmd vimenter * hi Normal guibg=none guifg=none ctermbg=none ctermfg=none]]
  -- vim.cmd[[autocmd vimenter * hi NormalNC guibg=none guifg=none ctermbg=none ctermfg=none]]
  -- vim.cmd[[autocmd vimenter * hi NonText guibg=none guifg=none ctermbg=none ctermfg=none]]
  -- vim.cmd[[autocmd vimenter * hi Visual guibg=#333344 guifg=none ctermbg=none ctermfg=none]]

end)

