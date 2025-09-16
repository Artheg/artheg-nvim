require('fd')
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
-- Tree sitter breaks indent?
vim.opt.smartindent = false

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

-- preformat json with jq
-- vim.api.nvim_create_autocmd({ "BufReadPost" }, {
--   pattern = "*.json",
--   command = ":%!jq ."
-- })

vim.opt.foldmethod = 'marker'
-- }}}
-- {{{LSP
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = {
          'vim',
          'require',
        },
      },
    },
  },
})
vim.lsp.config("ts_ls", {
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
-- }}}
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
    -- vim.cmd [[colorscheme weird-days]]
    vim.cmd [[colorscheme accent]]
    require('project_runner')
  end
})

require("lazy").setup({
  -- project managament, Rooter
  {
    "DrKJeff16/project.nvim",
    config = function()
      require('project').setup()
    end
  },
  -- better paste
  {
    'ConradIrwin/vim-bracketed-paste'
  },
  -- a custom text object (ib, ab)
  {
    "rhysd/vim-textobj-anyblock",
    dependencies = {
      "kana/vim-textobj-user"
    }
  },
  {
    "tpope/vim-sleuth"
  },
  {
    'nathanaelkane/vim-indent-guides'
  },
  {
    'nmac427/guess-indent.nvim',
    config = function() require('guess-indent').setup {} end,
  },
  -- better lsp experience
  {
    'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup({
        lightbulb = {
          sign = false,
        }
      })
      vim.keymap.set("n", "<leader>lp", ':Lspsaga peek_definition<CR>')
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons',     -- optional
    }
  },
  -- documentation generator
  {
    "kkoomen/vim-doge",
  },
  -- git
  {
    "f-person/git-blame.nvim",
    config = function()
      require('gitblame').setup {
        date_format = "%d.%m.%y %H:%M",
        message_template = "// <author> (<committer-date>) • <summary>"
      }
    end,
  },
  -- debug
  -- {
  --   "julianolf/nvim-dap-lldb",
  --   dependencies = { "mfussenegger/nvim-dap" },
  --   config = true
  -- },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio", "williamboman/mason.nvim" },
    config = function()
      require("dapui").setup()
    end
  },
  { "mxsdev/nvim-dap-vscode-js",       requires = { "mfussenegger/nvim-dap" } },
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
      }

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = "codelldb",
          args = { "--port", "${port}" }
        }
      }

      dap.configurations.odin = {
        {
          name = 'Debug Odin With Arguments',
          type = 'lldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          args = function()
            local input = vim.fn.input 'Arguments: '
            return vim.split(input, ' ')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          runInTerminal = false,
        },
        {
          name = 'Debug Odin Without Arguments',
          type = 'lldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          args = {},
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          runInTerminal = false,
        },
      }
      dap.configurations.java = {
        {
          type = 'java',
          request = 'attach',
          name = "Debug (Attach) - Remote",
          hostName = "127.0.0.1",
          port = 5005,
        },
      }
      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
      }

      local js_debugger_cmd = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug-adapter"
      -- require("dap-vscode-js").setup({
      --   debugger_cmd = js_debugger_cmd,
      --   adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
      -- })

      for _, adapter in pairs({ "pwa-node", "pwa-chrome" }) do
        require("dap").adapters[adapter] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = js_debugger_cmd,
            args = { "${port}" },
          },
        }
      end

      dap.configurations.javascript = {
        {
          type = 'pwa-chrome',
          request = 'launch',
          name = 'Launch browser to debug client side code',
          url = function()
            local co = coroutine.running()
            return coroutine.create(function()
              vim.ui.input({ prompt = 'Enter URL: ', default = 'http://localhost:8888' }, function(url)
                if url == nil or url == '' then
                  return
                else
                  coroutine.resume(co, url)
                end
              end)
            end)
          end,
          runtimeExecutable = '/usr/bin/brave',
          runtimeArgs = { "--remote-debugging-port=" .. "9222" },
          -- for TypeScript/Svelte
          sourceMaps = true,
          webRoot = '${workspaceFolder}/src',
          protocol = 'inspector',
          port = 9222,
          -- skip files from vite's hmr
          skipFiles = { '**/node_modules/**/*', '**/@vite/*', '**/src/client/*', '**/src/*' },
        },
      }
      dap.configurations.typescript = dap.configurations.javascript
      dap.configurations.c = dap.configurations.cpp;
      dap.configurations.rust = dap.configurations.cpp;
      dap.configurations.odin = dap.configurations.cpp;
    end
  },
  { "theHamsta/nvim-dap-virtual-text", config = true,                         dependencies = "mfussenegger/nvim-dap" },
  {
    'Wansmer/symbol-usage.nvim',
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup {
        on_attach = function(bufnr)
          local gitsigns = require('gitsigns')

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then
              vim.cmd.normal({ ']c', bang = true })
            else
              gitsigns.nav_hunk('next')
            end
          end)

          map('n', '[c', function()
            if vim.wo.diff then
              vim.cmd.normal({ '[c', bang = true })
            else
              gitsigns.nav_hunk('prev')
            end
          end)

          -- Actions
          map('n', '<leader>hs', gitsigns.stage_hunk)
          map('n', '<leader>hu', gitsigns.reset_hunk)

          map('v', '<leader>hs', function()
            gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
          end)

          map('v', '<leader>hr', function()
            gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
          end)

          map('n', '<leader>hS', gitsigns.stage_buffer)
          map('n', '<leader>hR', gitsigns.reset_buffer)
          map('n', '<leader>hp', gitsigns.preview_hunk)
          map('n', '<leader>hi', gitsigns.preview_hunk_inline)

          map('n', '<leader>hb', function()
            gitsigns.blame_line({ full = true })
          end)

          map('n', '<leader>hd', gitsigns.diffthis)

          map('n', '<leader>hD', function()
            gitsigns.diffthis('~')
          end)

          map('n', '<leader>hQ', function() gitsigns.setqflist('all') end)
          map('n', '<leader>hq', gitsigns.setqflist)

          -- Toggles
          map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
          map('n', '<leader>tw', gitsigns.toggle_word_diff)

          -- Text object
          map({ 'o', 'x' }, 'ih', gitsigns.select_hunk)
        end
      }
    end
  },
  { "akinsho/git-conflict.nvim" },
  -- extend match (matches special words)
  {
    "andymass/vim-matchup",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end
  },
  {
    'mfussenegger/nvim-jdtls',
    dependencies = { "mfussenegger/nvim-dap", "williamboman/mason.nvim" }
  },
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
        enabled = true,
        matchup = {
          enable = true,
        },
      })
    end
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      indent = { enabled = true },
      picker = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
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
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto', -- you can pick another theme (gruvbox, catppuccin, etc.)
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = {},
          always_divide_middle = true,
          globalstatus = true,
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },

          -- Center section
          lualine_c = {
            {
              function()
                -- fallback: just use cwd folder name
                local cwd = vim.fn.getcwd()
                return " " .. vim.fn.fnamemodify(cwd, ":t")
                -- return " " .. vim.cmd [[ProjectRoot]]
              end,
              color = { gui = 'bold' },
            },
            { 'filename', path = 1 }, -- show relative file path
          },

          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        extensions = {}
      }
    end
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
      -- vim.cmd [[colorscheme inferno]]
      -- require('inferno.lua').setup()
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
          typescript = { "biome" },
          javascript = { "biome" },
          java = { "jdtls" }
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
  -- LSP/Completion
  -- this thing automatically configures and starts LSPs
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'lua_ls'
        },
        handlers = {
          clangd = function()
            require('lspconfig').clangd.setup({
              cmd = { "clangd", "--function-arg-placeholders=0" },
            })
          end,
        },
        lua_ls = function()
          require('lspconfig').lua_ls.setup {
            settings = {
              Lua = {
                diagnostics = {
                  -- Get the language server to recognize the `vim` global
                  globals = { 'vim' },
                },
              },
            },
          }
        end,
        biome = function()
          require('lspconfig').biome.setup {
            cmd = '/Users/ashtukert/.nvm/versions/node/v18.20.7/bin/biome'
          }
        end,
        ols = function()
          require('lspconfig').ols.setup({
            cmd = { "/home/artheg/git/odin/ols/ols" },
          })
        end
      })
    end
  },
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets' },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = { preset = 'enter', ['<Tab>'] = { 'accept', 'fallback' } },
      signature = { enabled = true },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = { documentation = { auto_show = true } },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" },
  },
  -- A code outline window for skimming and quick navigation
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("aerial").setup({
        nerd_font = "mono",
        -- optionally use on_attach to set keymaps when aerial has attached to a buffer
        on_attach = function(bufnr)
          -- Jump forwards/backwards with '{' and '}'
          vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
          vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
        end,
      })
      -- You probably also want to set a keymap to toggle aerial
      vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
    end
  },
  -- Snippets
  "L3MON4D3/LuaSnip",
  "rafamadriz/friendly-snippets",
})
-- }}}
-- {{{ Keybindings

----- Navigation
vim.api.nvim_set_keymap('n', '<A-j>', '10jzz', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<A-k>', '10kzz', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<A-h>', ':tabprev<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<A-l>', ':tabnext<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>tc', ':tabclose<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>tn', ':tabnew<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ct', '/class<CR>j', { silent = true })

------ Editing
vim.api.nvim_set_keymap('n', '<Leader>b', 'cib', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>B', 'cab', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>w', 'ciw', { silent = true })
vim.api.nvim_set_keymap('i', '<A-w>', '<Esc>ciw', { silent = true })
vim.api.nvim_set_keymap('i', '<C-w>', '<ESC>dba', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>4', 'C', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>4', 'C', { silent = true })

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
vim.api.nvim_set_keymap('n', '<C-H>', ':FloatermNew scooter<CR>', { silent = true, noremap = true })
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
vim.api.nvim_set_keymap('n', '<Leader>tp', ':Telescope projects<CR>', { silent = true })
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
vim.api.nvim_set_keymap('n', '<F5>', ':RunProject<CR>', { silent = true })
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
---LSP
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end
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
  end,
})

----- Aerial (outline symbols)
vim.api.nvim_set_keymap('n', '<C-a>', ':AerialToggle<CR>', { silent = true })
-----

-- }}}
