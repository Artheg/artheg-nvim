-- {{{ Options

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

vim.g.neovide_input_macos_option_key_is_meta = "only_left"
vim.g.guifont = "CozetteVector:h11"

-- vim.cmd.colorscheme[[catppuccin]]

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
-- vim.cmd [[autocmd VimEnter,VimLeave * silent !tmux set status]]

-- Close quickfix and location list after selecting item
vim.cmd [[:autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>]]

-- Update Floaterm on vim resize
vim.api.nvim_create_autocmd('VimResized', {
  command = 'silent FloatermUpdate',
  group = vim.api.nvim_create_augroup('Floaterm', {}),
})

vim.opt.foldmethod = 'marker'
-- }}}
--
---- {{{ lazy.nvim

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

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyDone",
  once = true,
  callback = function()
    vim.cmd [[colorscheme weird-days]]
  end
})

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
  -- better paste
  {
    'ConradIrwin/vim-bracketed-paste'
  },
  -- better lsp experience
  {
    'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup({})
      vim.keymap.set("n", "<leader>lp", ':Lspsaga peek_definition<CR>')
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons',     -- optional
    }
  },
  -- git
  {
    "f-person/git-blame.nvim",
    config = function()
      vim.g.gitblame_date_format = "%d.%m.%y %H:%M"
      vim.g.gitblame_message_template = "// <author> (<committer-date>) • <summary>"
    end,
  },
  -- debug
  { "rcarriga/nvim-dap-ui",     dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
      }
      dap.configurations.c = {
        {
          name = "Launch",
          type = "gdb",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = "${workspaceFolder}",
          stopAtBeginningOfMainSubprogram = false,
        },
        {
          name = "Select and attach to process",
          type = "gdb",
          request = "attach",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          pid = function()
            local name = vim.fn.input('Executable name (filter): ')
            return require("dap.utils").pick_process({ filter = name })
          end,
          cwd = '${workspaceFolder}'
        },
        {
          name = 'Attach to gdbserver :1234',
          type = 'gdb',
          request = 'attach',
          target = 'localhost:1234',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}'
        },
      }
      dap.configurations.odin = dap.configurations.c
    end
  },
  {
    'Wansmer/symbol-usage.nvim',
  },
  { "airblade/vim-gitgutter" },
  { "akinsho/git-conflict.nvim" },
  -- extend match (matches special words)
  {
    "andymass/vim-matchup",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end
  },
  { 'mfussenegger/nvim-jdtls' },
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
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        matchup = {
          enable = true,
        },
      })
    end
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle focus=true<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  -- highlight arguments with treesitter
  { 'm-demare/hlargs.nvim' },
  -- fuzzy file search
  { "junegunn/fzf" },
  { "junegunn/fzf.vim" },
  -- better word motion (e.g. CamelCase)
  { "chaoren/vim-wordmotion" },
  -- yazi file manager
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>e",
        function()
          require("yazi").yazi()
        end,
        desc = "Open the file manager",
      }
    },
    opts = {
      open_for_directories = true
    }
  },
  -- lf file manager
  -- {
  --   "ptzz/lf.vim",
  --   lazy = false,
  -- },
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
      telescope.setup({
        pickers = {
          colorscheme = {
            enable_preview = true
          }
        },
      })
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
  { "windwp/nvim-autopairs",               config = [[require("config.autopairs")]] },
  -- colorschemes
  -- nocolor
  { "andreasvc/vim-256noir" },
  { "Alligator/accent.vim" },
  { "huyvohcmc/atlas.vim" },
  { "LuRsT/austere.vim" },
  { "https://git.sr.ht/~romainl/vim-bruin" },
  { "aditya-azad/candle-grey" },
  { "ntk148v/komau.vim" },
  { "t184256/vim-boring" },
  { "cranberry-clockworks/coal.nvim" },
  { "davidosomething/vim-colors-meh" },
  { "pbrisbin/vim-colors-off" },
  { "andreypopp/vim-colors-plain" },
  { "KKPMW/distilled-vim" },
  { "jaredgorski/fogbell.vim" },
  { "zekzekus/menguless" },
  --
  { "xiyaowong/transparent.nvim" },
  { "sam4llis/nvim-tundra" },
  { "sainnhe/everforest" },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      -- vim.cmd [[colorscheme base16-helios]]
      -- require('fd')
    end
  },
  { "slugbyte/lackluster.nvim" },
  { "haystackandroid/carbonized" },
  { "aliqyan-21/darkvoid.nvim" },
  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    "zootedb0t/citruszest.nvim",
    lazy = false,
    priority = 1000,
  },
  { "paulfrische/reddish.nvim" },
  {
    "mcchrish/zenbones.nvim",
    dependencies = { "rktjmp/lush.nvim" },
  },
  { "chriskempson/base16-vim" },
  {
    "hardselius/warlock"
  },
  -- Formatting
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          typescript = { "biome" }
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
  -- {
  --   "pmizio/typescript-tools.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  -- },
  -- LSP/Completion
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    dependencies = {
      -- LSP Support
      "neovim/nvim-lspconfig",
      "Tetralux/odin.vim",
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
      {
        "hrsh7th/nvim-cmp",
        dependencies = {
          "hrsh7th/cmp-buffer",
          "hrsh7th/cmp-path",
          "hrsh7th/cmp-nvim-lsp-signature-help",
          "saadparwaiz1/cmp_luasnip",
          "hrsh7th/cmp-nvim-lsp",
          "hrsh7th/cmp-nvim-lua",
          "hrsh7th/cmp-vsnip",
        }
      },

      -- Snippets
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",

      -- Better typescript integration
      -- "pmizio/typescript-tools.nvim",
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
          clangd = function()
            require('lspconfig').clangd.setup({
              cmd = { "clangd", "--function-arg-placeholders=0" },
            })
          end,
        },
        lua_ls = function()
          require 'lspconfig'.lua_ls.setup {
            settings = {
              Lua = {
                diagnostics = {
                  -- Get the language server to recognize the `vim` global
                  globals = { 'vim' },
                },
              },
            },
          }
        end

      })

      local cmp = require('cmp')
      local luasnip = require("luasnip")
      local lspkind = require('lspkind')


      local cmp_enabled = false
      vim.api.nvim_create_user_command("ToggleAutoComplete", function()
        if cmp_enabled then
          require("cmp").setup.buffer({ enabled = false })
          cmp_enabled = false
          if (cmp.visible()) then
            cmp.close()
          end
        else
          require("cmp").setup.buffer({ enabled = true })
          cmp_enabled = true
          cmp.complete()
        end
      end, {})

      vim.keymap.set({ "n", "v", "i" }, "<M-i>", function()
        vim.cmd [[ToggleAutoComplete]]
      end, { silent = true })

      cmp.setup({
        sources = {
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'vsnip' },
          { name = 'nvim_lua' }
        },
        buffer = {
          enabled = cmp_enabled,
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
          ['C-p'] = cmp.mapping.select_next_item({ behavior = 'select' }),
          ['C-n'] = cmp.mapping.select_next_item({ behavior = 'select' }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
      })

      local on_attach = function(client, bufnr)
        -- require("lsp-format").on_attach(client, bufnr)
        require('symbol-usage').setup()
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

      lsp_zero.configure("ols", {
        single_file_support = true,
        cmd = { vim.fn.expand("$HOME/git/odin/ols/ols") }
      })

      lsp_zero.configure("biome", {
        single_file_support = true,
      })

      -- lsp_zero.configure("tsserver", {

      -- })

      require('lspconfig').ts_ls.setup({
        settings = {

          javascript = {
            inlayHints = {
              includeInlayEnumMemberValueHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayVariableTypeHints = false,
            },
          },

          typescript = {
            inlayHints = {
              includeInlayEnumMemberValueHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayVariableTypeHints = false,
            },
          },
        }
      })
      -- lsp.skip_server_setup({ 'tsserver' })
      -- require("typescript-tools").setup({
      --   on_attach = function(client, bufnr)
      --     on_attach(client, bufnr)
      --   end,
      --   settings = {
      --     tsserver_file_preferences = {
      --       includeInlayParameterNameHints = "all",
      --       includeCompletionsForModuleExports = true,
      --     }
      --   }
      -- })

      lsp_zero.setup()

      vim.diagnostic.config({
        virtual_text = true,
      })
      require("cmp").setup.buffer({ enabled = false })
      cmp_enabled = false
    end,
  }
})
-- }}}
--
-- {{{ Keybindings

----- Navigation
vim.api.nvim_set_keymap('n', '<A-j>', '10jzz', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<A-k>', '10kzz', { silent = true, noremap = true })
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

----- quickfix
vim.api.nvim_set_keymap('n', '<C-j>', ':cnext<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', ':cprevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>cc', ':cclose<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>co', ':copen<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<esc>', ':cclose<CR>', { silent = true })

------- Floaterm
-- vim.api.nvim_set_keymap('n', '<leader>e', ':Lf<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<F2>', ':FloatermToggle<cr>', { silent = true })
vim.api.nvim_set_keymap('t', '<F2>', '<C-\\><C-n>:FloatermToggle<CR>', { silent = true, noremap = true })
vim.g.floaterm_opener = 'drop'
-----

------- Git
vim.api.nvim_set_keymap('n', '<Leader>gg', ':!git gui<cr><cr>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>gt', ':tabnew | :terminal lazygit<CR>i', { silent = true })
-----

----- Colorizer
vim.api.nvim_set_keymap('n', '<leader>c', ':ColorHighlight<CR>', { silent = true, noremap = true })
--

---- Typescript
vim.api.nvim_set_keymap('n', '<Leader>ac', '/constructor<Esc>:nohl<cr>f(a<cr>', { silent = true })
-------

------- Telescope
vim.api.nvim_set_keymap('n', '<Leader>tt', ':Telescope<CR>', { silent = true })

vim.api.nvim_set_keymap('n', '<Leader>tb', ':Telescope buffers<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>tr', ':Telescope live_grep<CR>', { silent = true })
vim.api.nvim_set_keymap('v', '<Leader>tr', 'y<ESC>:Telescope live_grep default_text=<c-r>0<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>tf', ':Telescope find_files<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>to', ':Telescope oldfiles<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ta', ':Telescope aerial<CR>', { silent = true })
vim.api.nvim_set_keymap('n', 'gr', ':Telescope lsp_references<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ti', ':Telescope lsp_implementations<CR>', { silent = true })


------- LSP
vim.api.nvim_set_keymap('n', '<Leader>q', ':lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>',
  { silent = true })
------

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

----- nvim-dap
vim.api.nvim_set_keymap('n', '<F6>', ':lua require("dap").clear_breakpoints()<CR>', {})
vim.api.nvim_set_keymap('n', '<F7>', ':DapContinue<CR>', {})
vim.api.nvim_set_keymap('n', '<F8>', ':lua require("dap.ui.widgets").hover()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<F9>', ':DapToggleBreakpoint<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<F10>', ':DapStepOver<CR>', {})
vim.api.nvim_set_keymap('n', '<F11>', ':DapStepInto<CR>', {})
vim.api.nvim_set_keymap('n', '<F12>', ':DapStepOut<CR>', {})

----- dap-ui
vim.api.nvim_set_keymap('n', '<C-k>', ':lua require("dap.ui.widgets").hover()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>dt', ':lua require(\'dapui\').toggle()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>de', ':lua require(\'dapui\').eval()<CR>', { silent = true })

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
-- vim.api.nvim_set_keymap('n', 'p', 'p`[v`]=', { noremap = true })
-- vim.api.nvim_set_keymap('n', 'P', 'P`[v`]=', { noremap = true })
vim.api.nvim_set_keymap('n', 'p', ']p<S-v>==', { noremap = true })
vim.api.nvim_set_keymap('n', 'P', 'P', { noremap = true })

vim.api.nvim_set_keymap('n', '<F3>', '<ESC>:lua vim.lsp.buf.format({ async = true })<CR>', {})
-----

----- Clipboard
vim.api.nvim_set_keymap('i', '<C-v>', '<ESC>"+p<S-v>==ea<ESC>', { noremap = true })
vim.api.nvim_set_keymap('v', '<C-c>', '"+y', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-S-v>', '"+pgv=', { noremap = true })
vim.api.nvim_set_keymap('v', '<C-v>', '"+p<S-v>==ea<ESC>', { noremap = true })
vim.cmd [[
xnoremap <expr> p 'pgv"' . v:register . 'y'
]]
-----

----- Aerial (outline symbols)
vim.api.nvim_set_keymap('n', '<C-a>', ':AerialToggle<CR>', { silent = true })
-----

-- }}}
