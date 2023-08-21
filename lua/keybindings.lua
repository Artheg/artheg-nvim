-- Keybindings

----- Navigation
vim.api.nvim_set_keymap('n', '<A-h>', ':tabprev<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<A-l>', ':tabnext<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>tc', ':tabclose<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>tn', ':tabnew<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ct', '/class<CR>j', { silent = true })

-- center screen when focusing on search occurences
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', { noremap = true })
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', { noremap = true })

-- buffer
-- vim.api.nvim_set_keymap('n', '<A-k>', ':bprevious<CR>', { silent = true, noremap = true })
-- vim.api.nvim_set_keymap('n', '<A-j>', ':bnext<CR>', { silent = true, noremap = true })

-- better history jumping
vim.cmd [[
  nnoremap <expr> j (v:count > 1 ? "m'" . v:count : "") . 'j'
  nnoremap <expr> k (v:count > 1 ? "m'" . v:count : "") . 'k'
]]

-- vim.api.nvim_set_keymap('i', '<C-l>', '<Plug>(coc-snippets-vim)', {})

----- quickfix
vim.api.nvim_set_keymap('n', '<C-j>', ':cnext<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', ':cprevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>cc', ':cclose<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>co', ':copen<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<esc>', ':cclose<CR>', { silent = true })

------- Floaterm
vim.api.nvim_set_keymap('n', '<leader>e', ':Lf<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<F2>', ':FloatermToggle<cr>', { silent = true })
vim.api.nvim_set_keymap('t', '<F2>', '<C-\\><C-n>:FloatermToggle<CR>', { silent = true, noremap = true })
vim.g.floaterm_opener = 'drop'
-----

------- Git
vim.api.nvim_set_keymap('n', '<Leader>gg', ':!git gui<cr><cr>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>gt', ':tabnew | :edit term://lazygit<CR>i', { silent = true })
-----

----- Colorizer
vim.api.nvim_set_keymap('n', '<leader>c', ':ColorHighlight<CR>', { silent = true, noremap = true })
--

---- Typescript
vim.api.nvim_set_keymap('n', '<Leader>ac', '/constructor<Esc>:nohl<cr>f(a<cr>', { silent = true })
-------

------- Telescope
vim.api.nvim_set_keymap('n', '<Leader>tt', ':Telescope<CR>', { silent = true })

vim.api.nvim_set_keymap('n', '<Leader>tb', ':Buffers<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>tr', ':Telescope live_grep<CR>', { silent = true })
vim.api.nvim_set_keymap('v', '<Leader>tr', 'y<ESC>:Telescope live_grep default_text=<c-r>0<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>tf', ':Files<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>to', ':Telescope oldfiles<CR>', { silent = true })
-- vim.api.nvim_set_keymap('n', '<Leader>tr', ':Telescope live_grep<CR>', {silent=true})
-- vim.api.nvim_set_keymap('n', '<Leader>tf', ':Telescope find_files<CR>', {silent=true})
-- vim.api.nvim_set_keymap('n', '<Leader>tp', ':Telescope projects<CR>', {silent=true}) vim.api.nvim_set_keymap('n', '<Leader>tgb', ':Telescope git_branches<CR>', {silent=true}) vim.api.nvim_set_keymap('n', '<Leader>tgc', ':Telescope git_commits<CR>', {silent=true})
-- vim.api.nvim_set_keymap('n', '<Leader>tgs', ':Telescope git_status<CR>', {silent=true})
-----




----- Windows
vim.cmd [[
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

vim.api.nvim_set_keymap('n', 'L', '<c-w><c-w>', { silent = true })
vim.api.nvim_set_keymap('n', 'H', '<c-w>W', { silent = true })
vim.api.nvim_set_keymap('n', '<C-x>', ':call ToggleWindowMaximize()<cr>', { silent = true })
-----

----- vim-snip
vim.api.nvim_set_keymap('i', '<Tab>', 'vsnip#jumpable(1) ? \'<Plug>(vsnip-jump-next)\' : \'<Tab>\'',
  { silent = true, expr = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', 'vsnip#jumpable(-1) ? \'<Plug>(vsnip-jump-prev)\' : \'<S-Tab>\'',
  { silent = true, expr = true })
-----

----- nvim-dap
vim.api.nvim_set_keymap('n', '<F6>', ':lua require("dap").clear_breakpoints()<CR>', {})
vim.api.nvim_set_keymap('n', '<F7>', ':DapContinue<CR>', {})
vim.api.nvim_set_keymap('n', '<F8>', ':lua require("dap.ui.widgets").hover()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<F9>', ':DapToggleBreakpoint<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<F10>', ':DapStepOver<CR>', {})
vim.api.nvim_set_keymap('n', '<F11>', ':DapStepInto<CR>', {})
vim.api.nvim_set_keymap('n', '<F12>', ':DapStepOut<CR>', {})

----- dap-ui
vim.api.nvim_set_keymap('n', '<leader>dt', ':lua require(\'dapui\').toggle()<CR>', { silent = true })

----- neovim-tasks
vim.api.nvim_set_keymap('n', '<F5>', ':Task start auto run<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<F17>', ':Task start auto debug<CR>', { silent = true })

vim.api.nvim_set_hl(0, 'LineBreakpoint', { ctermbg = 0, bg = '#511111' })
vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bg = '#31353f' })
-----


----- Edit
-- Emacs-like movement for insert mode
vim.api.nvim_set_keymap('i', '<C-b>', '<C-o>b', {})
vim.api.nvim_set_keymap('i', '<C-f>', '<C-o>w', {})
vim.api.nvim_set_keymap('i', '<C-a>', '<C-o>I', {})
vim.api.nvim_set_keymap('i', '<C-e>', '<C-o>A', {})

-- make Y behave as other capital letters by default
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })
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
vim.api.nvim_set_keymap('n', 'p', 'p`[v`]=', { noremap = true })
vim.api.nvim_set_keymap('n', 'P', 'P`[v`]=', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<C-p>', ']p', { noremap=true })
-- vim.api.nvim_set_keymap('n', '<C-P>', 'P', { noremap=true })

vim.api.nvim_set_keymap('n', '<F3>', '<ESC>:lua vim.lsp.buf.format({ async = true })<CR>', {})
-----

----- Clipboard
vim.api.nvim_set_keymap('i', '<C-v>', '<ESC>"+p<S-v>==ea<ESC>', { noremap = true })
vim.api.nvim_set_keymap('v', '<C-c>', '"+y', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-S-v>', '"+pgv=', { noremap = true })
vim.api.nvim_set_keymap('v', '<C-v>', '"+p<S-v>==ea<ESC>', { noremap = true })
-----

----- Aerial (outline symbols)
vim.api.nvim_set_keymap('n', '<C-a>', ':AerialToggle<CR>', { silent = true })
-----
