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

vim.g.lf_replace_netrw = 1
vim.g.lf_map_keys = 0

---- syntax highlight vim.opt.syntax = 'on'

vim.opt.background = "dark"

---- cursor line
vim.cmd [[set cursorline]]

-- persistend undo
vim.opt.undofile = true
vim.opt.undodir = os.getenv('HOME') .. '/.nvim/undodir'

---- confirm save on q
vim.opt.confirm = true
---- hide buffers instead of closing them
vim.opt.hidden = true

---- disable highlight search
vim.cmd [[set nohlsearch]]

---- change active directory based on current active file
-- vim.opt.autochdir = true
----
---- indent based on filetype
-- vim.filetype.plugin = 'on'

---- start scrolling before reaching n*th line
vim.opt.scrolloff = 25
----
-- vim.opt.updatetime=500

---- Resize vim's windows automatically on the terminal window resize
vim.cmd [[autocmd VimResized * wincmd =]]

---- Toggle tmux panel when entering/exiting vim
vim.cmd [[autocmd VimEnter,VimLeave * silent !tmux set status]]

-- Close quickfix and location list after selecting item
vim.cmd [[:autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>]]

-- Update Floaterm on vim resize
vim.api.nvim_create_autocmd('VimResized', {
  command = 'silent FloatermUpdate',
  group = vim.api.nvim_create_augroup('Floaterm', {}),
})

----------------- packer plugin manager

require('keybindings')
-- vim.cmd [[colorscheme warlock]]
-- vim.cmd[[colorscheme OceanicNext]]
-- vim.cmd[[colorscheme blue-moon]]
-- vim.cmd[[colorscheme farout]]
-- vim.cmd[[colorscheme deus]]
-- vim.cmd[[colorscheme falcon]]
-- vim.cmd [[colorscheme kanagawabones]]
-- vim.cmd[[colorscheme halcyon]]
-- vim.cmd[[colorscheme no-clown-fiesta]]


-- transparent bg
-- vim.cmd[[autocmd vimenter * hi Normal guibg=none guifg=none ctermbg=none ctermfg=none]]
-- vim.cmd[[autocmd vimenter * hi NormalNC guibg=none guifg=none ctermbg=none ctermfg=none]]
-- vim.cmd[[autocmd vimenter * hi NonText guibg=none guifg=none ctermbg=none ctermfg=none]]
-- vim.cmd[[autocmd vimenter * hi Visual guibg=#333344 guifg=none ctermbg=none ctermfg=none]]
--


---- lazy.nvim
-- bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
  -- project managament, Rooter
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({
        patterns = {
          ".git",
          "_darcs",
          ".hg",
          ".bzr",
          ".svn",
          "Makefile",
          "package.json",
          "tsconfig.json",
          "angular.json",
        },
        detection_methods = { "pattern", "lsp" },
      })
    end,
  },
  -- git
  {
    "f-person/git-blame.nvim",
    config = function()
      vim.g.gitblame_date_format = "%d.%m.%y %H:%M"
      vim.g.gitblame_message_template = "// <author> (<committer-date>) • <summary>"
    end,
  },
  { "airblade/vim-gitgutter" },
  { "akinsho/git-conflict.nvim" },
  -- extend match (matches special words)
  { "andymass/vim-matchup",     event = "BufReadPost" },
  -- automatically replaces words
  {
    "AndrewRadev/switch.vim",
    config = function()
      vim.g["switch_custom_definitions"] = {
        { "width",  "height" },
        { "Width",  "Height" },
        { "x",      "y",      "z" },
        { "top",    "bottom", "Top", "Bottom" },
        { "left",   "right" },
        { "remove", "add" },
      }

      local function switchLine()
        local tick = vim.b.changedtick
        vim.cmd('Switch')
        if vim.b.changedtick ~= tick then
          vim.cmd("normal w")
          return
        end
        while true do
          local pos = vim.fn.getcurpos()
          vim.cmd("normal w")
          if pos[2] ~= vim.fn.getcurpos()[2] or pos == vim.fn.getcurpos() then
            break
          end
          vim.cmd('Switch')
          if vim.b.changedtick ~= tick then
            vim.cmd("normal w")
            return
          end
        end
      end

      vim.keymap.set("n", "<F4>", switchLine, { silent = true })
    end,
  },
  -- fuzzy file search
  { "junegunn/fzf" },
  { "junegunn/fzf.vim" },
  -- better word motion (e.g. CamelCase)
  { "chaoren/vim-wordmotion" },
  -- lf file manager
  {
    "ptzz/lf.vim",
    lazy = false,
    config = function()
      vim.g.lf_replace_netrw = 1
      vim.g.lf_map_keys = 0
    end,
  },
  -- floating terminal
  { "voldikss/vim-floaterm" },
  -- highlight other uses of words
  { "RRethy/vim-illuminate" },
  -- commenter
  { "tpope/vim-commentary" },
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make"
      },
      "nvim-telescope/telescope-fzy-native.nvim",
    },
    config = function()
      local telescope = require("telescope")
      telescope.load_extension("fzf")
      telescope.load_extension("fzy_native")
      telescope.load_extension("projects")
    end,
  },
  -- highlight hex colors
  { "chrisbra/Colorizer" },
  -- better surrounding chars edit
  { "tpope/vim-surround" },
  -- status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" }
  },
  -- [], {}, (), etc.
  { "windwp/nvim-autopairs" },
  -- colorschemes
  { "mcchrish/zenbones.nvim" },
  { "chriskempson/base16-vim" },
  {
    "hardselius/warlock",
    config = function()
      vim.cmd [[colorscheme warlock]]
    end
  },
  -- Formatting
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          typescript = { "eslint_d", "prettierd" }
        },
        format_on_save = function(bufnr)
          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return { timeout_ms = 500, lsp_fallback = true }
        end,
      })
      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          -- FormatDisable! will disable formatting just for this buffer
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })
      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      })
    end
  },
  -- Better typescript integration
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  },
  -- LSP/Completion
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    dependencies = {
      -- LSP Support
      "neovim/nvim-lspconfig",
      {
        "williamboman/mason.nvim",
        config = function()
          require("mason").setup()
        end
      },
      "williamboman/mason-lspconfig.nvim",
      -- lsp signature (displays signature params as you type)
      "ray-x/lsp_signature.nvim",
      -- fancy icons
      "onsails/lspkind.nvim",
      -- symbols outline
      "stevearc/aerial.nvim",
      -- Autocompletion
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-vsnip",

      -- Snippets
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",

      -- Better typescript integration
      "pmizio/typescript-tools.nvim",
    },
    config = function()
      -- require("lsp-format").setup()
      local lsp_zero = require("lsp-zero")

      lsp_zero.preset("recommended")
      require('mason').setup({})
      require('mason-lspconfig').setup({
        ensure_installed = {},
        handlers = {
          lsp_zero.default_setup,
        },
      })

      local cmp = require('cmp')
      local lspkind = require('lspkind')

      cmp.setup({
        sources = {
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'vsnip' },
          { name = 'nvim_lua' }
        },
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol_text', -- show only symbol annotations
            maxwidth = 100,       -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
          })
        },
        mapping = {
          ["<C-space>"] = cmp.mapping({
            i = function()
              if cmp.visible() then
                cmp.abort()
              else
                cmp.complete()
              end
            end,
            c = function()
              if cmp.visible() then
                cmp.close()
              else
                cmp.complete()
              end
            end,
          }),
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
          ['<C-e>'] = cmp.mapping.abort(),
          ['C-p'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
          ['C-n'] = cmp.mapping.select_next_item({ behavior = 'select' }),
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
      })

      local on_attach = function(client, bufnr)
        -- require("lsp-format").on_attach(client, bufnr)
        local opts = { buffer = bufnr, remap = false }
        vim.keymap.set("n", "<leader>ld", function()
          vim.diagnostic.open_float()
        end, { silent = true })
        vim.keymap.set("n", "gd", function()
          vim.lsp.buf.definition()
        end, opts)
        vim.keymap.set("n", "gy", function()
          vim.lsp.buf.type_definition()
        end, opts)
        vim.keymap.set("n", "K", function()
          vim.lsp.buf.hover()
        end, opts)
        vim.keymap.set("n", "<leader>ga", function()
          vim.lsp.buf.code_action()
        end, opts)
        vim.keymap.set("n", "gr", function()
          vim.cmd("Telescope lsp_references")
        end, opts)
        vim.keymap.set("n", "gR", function()
          vim.lsp.buf.rename()
        end, opts)
        vim.keymap.set("i", "<C-h>", function()
          vim.lsp.buf.signature_help()
        end, opts)
      end

      lsp_zero.on_attach(function(client, bufnr)
        on_attach(client, bufnr)
      end)

      lsp_zero.configure("zls", {
        single_file_support = true,
        cmd = { vim.fn.expand("$HOME/git/zig/zls/zig-out/bin/zls") },
      })

      -- lsp.skip_server_setup({ 'tsserver' })
      require("typescript-tools").setup({
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
        end,
      })

      lsp_zero.setup()

      vim.diagnostic.config({
        virtual_text = true,
      })
    end,
  }
})
