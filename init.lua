-- options
--
-- extend selection on right click instead of popup menu
vim.opt.mousemodel = 'extend'
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

---- syntax highlight vim.opt.syntax = 'on'

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

-- Update Floaterm on vim resize
vim.api.nvim_create_autocmd('VimResized', {
  command = 'silent FloatermUpdate',
  group = vim.api.nvim_create_augroup('Floaterm', {}),
})

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


  -- require('lsp-config')
  require('keybindings')
  require("no-clown-fiesta").setup({ variables = { bold = true, italic = true }, keywords = { bold = true, italic = true, standout = true } })

  -- vim.cmd[[colorscheme OceanicNext]]
  -- vim.cmd[[colorscheme blue-moon]]
  -- vim.cmd[[colorscheme farout]]
  -- vim.cmd[[colorscheme deus]]
  -- vim.cmd[[colorscheme falcon]]
  vim.cmd[[colorscheme kanagawabones]]
   -- vim.cmd[[colorscheme halcyon]]
   -- vim.cmd[[colorscheme no-clown-fiesta]]


  -- transparent bg
  -- vim.cmd[[autocmd vimenter * hi Normal guibg=none guifg=none ctermbg=none ctermfg=none]]
  -- vim.cmd[[autocmd vimenter * hi NormalNC guibg=none guifg=none ctermbg=none ctermfg=none]]
  -- vim.cmd[[autocmd vimenter * hi NonText guibg=none guifg=none ctermbg=none ctermfg=none]]
  -- vim.cmd[[autocmd vimenter * hi Visual guibg=#333344 guifg=none ctermbg=none ctermfg=none]]

end)

