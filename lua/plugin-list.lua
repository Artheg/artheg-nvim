return {
  startup = function(use)
    -- Packer (plugin manager)
    use 'wbthomason/packer.nvim'
    --

    -- lspkind (vscode-like pictograms to neovim built-in lsp)
    use 'onsails/lspkind.nvim'
    -- project managament, Rooter
    use {
      "ahmedkhalf/project.nvim",
      config = function()
        require("project_nvim").setup {
          patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "tsconfig.json",
            "angular.json" },
          detection_methods = { "pattern", "lsp" }
        }
      end
    }
    --

    -- null-ls
    use 'jose-elias-alvarez/null-ls.nvim'

    -- better typescript lsp
    -- use {
    --   "pmizio/typescript-tools.nvim",
    --   requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    --   config = function()
    --     require("typescript-tools").setup {}
    --   end,
    -- }


    -- git blamer
    use {
      'f-person/git-blame.nvim',
      config = function()
        vim.g.gitblame_date_format = "%d.%m.%y %H:%M"
        vim.g.gitblame_message_template = "// <author> (<committer-date>) • <summary>"
      end
    }
    --

    -- git signs and hunk actions
    use {
      'lewis6991/gitsigns.nvim',
      requires = 'nvim-lua/plenary.nvim',
      config = function()
        require('gitsigns').setup()
      end
    }
    use { 'airblade/vim-gitgutter' }
    --

    -- display diagnostic lines in a fancy manner
    use({
      "folke/trouble.nvim",

      config = function()
        vim.keymap.set("n", "<leader>xx", function() require("trouble").open() end)
        vim.keymap.set("n", "<leader>xw", function() require("trouble").open("workspace_diagnostics") end)
        vim.keymap.set("n", "<leader>xd", function() require("trouble").open("document_diagnostics") end)
        vim.keymap.set("n", "<leader>xq", function() require("trouble").open("quickfix") end)
        vim.keymap.set("n", "<leader>xl", function() require("trouble").open("loclist") end)
        -- require("lsp_lines").setup()
        -- vim.diagnostic.config({
        --   virtual_text = false
        -- })
      end,
    })

    -- git conflict helper
    use { 'akinsho/git-conflict.nvim', tag = "*", config = function()
      require('git-conflict').setup()
    end }

    ---- create themes with live preview
    -- use {'rktjmp/lush.nvim'}
    ----

    -- extends match (matches special words)
    use 'andymass/vim-matchup'
    --

    -- automatically replaces words
    use {
      'AndrewRadev/switch.vim',
      config = function()
        vim.g['switch_custom_definitions'] = {
          { "width", "height" },
          { "Width", "Height" },
          { "x",     "y",      "z" },
          { "top",   "bottom", "Top", "Bottom" },
          { "left",  "right" },
          { "add",   "remove" },
        }
        vim.cmd [[
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
      end
    }
    --

    -- build system
    use {
      'Shatur/neovim-tasks',
      requires = { 'plenary.nvim' }
    }

    -- fuzzy file search
    use { 'junegunn/fzf' }
    use { 'junegunn/fzf.vim' }
    --

    -- Debugger
    use {
      'mfussenegger/nvim-dap',
      config = function()
        local dap = require('dap')

        -- vim.fn.sign_define('DapBreakpoint', {text='⭕', texthl='BP', linehl='LineBreakpoint', numhl=''})
        vim.fn.sign_define('DapBreakpoint',
          { text = '', texthl = 'LineBreakpoint', linehl = 'LineBreakpoint', numhl = 'LineBreakpoint' })
        vim.fn.sign_define('DapStopped', {
          text = '',
          texthl = 'DapStopped',
          linehl = 'DapStopped',
          numhl =
          'DapStopped'
        })
        vim.api.nvim_set_hl(0, 'LineBreakpoint', { ctermbg = 0, bg = '#511111' })
        vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, bg = '#934111' })

        dap.adapters.lldb = {
          type = 'executable',
          command = 'lldb-vscode',
          name = 'lldb'
        }

        dap.adapters.chrome = {
          type = "executable",
          command = "node",
          args = { os.getenv("HOME") .. "/git/vscode-chrome-debug/out/src/chromeDebug.js" } -- TODO adjust
        }

        dap.configurations.c = {
          type = 'lldb',
          request = 'launch',
          cwd = '${workspaceFolder}',
          stopOnEntry = false
        }

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
      end
    }
    --

    -- experimental ui for dap
    use {
      'rcarriga/nvim-dap-ui',
      requires = { 'mfussenegger/nvim-dap' },
      config = function()
        require("dapui").setup()
      end
    }

    -- zig support
    use 'ziglang/zig.vim'
    --

    -- better word motion (e.g. CamelCase)
    use 'chaoren/vim-wordmotion'
    --

    -- lf file manager
    use {
      'ptzz/lf.vim',
      config = function()
        vim.g['lf_replace_netrw'] = 1
        vim.g['lf_map_keys'] = 0
      end
    }
    --

    -- floating terminal
    use {
      'voldikss/vim-floaterm'
    }
    --

    -- highlight other uses of words
    use {
      'RRethy/vim-illuminate',
      config = function()
        vim.cmd [[
          augroup illuminate_augroup
          autocmd!
          autocmd VimEnter * hi illuminatedWord ctermbg=DarkBlue guibg=DarkBlue
          augroup END
        ]]
      end
    }
    --

    -- commenter
    use 'tpope/vim-commentary'
    --

    -- Telescope (highly extendable fuzzy finder over lists. Built on the latest awesome features from neovim)
    use {
      'nvim-telescope/telescope.nvim',
      requires = 'nvim-lua/plenary.nvim',
      config = function()
        local telescope = require('telescope')
        telescope.load_extension('projects')
        telescope.load_extension('fzf')
        telescope.load_extension('fzy_native')
        telescope.load_extension('projects')
      end
    }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use { 'nvim-telescope/telescope-fzy-native.nvim' }
    --

    -- highlight hex colors
    use {
      'chrisbra/Colorizer',
      config = function()
      end
    }
    --

    -- better surrounding chars edit
    use 'tpope/vim-surround'
    --

    -- adds indentation guides
    use {
      'lukas-reineke/indent-blankline.nvim',
      config = function()
        vim.opt.list = true
        vim.opt.listchars:append "space:⋅"
        vim.opt.listchars:append "eol:↴"

        require('indent_blankline').setup {
          show_end_of_line = true,
          space_char_blankline = " ",
          show_current_context = true,
          show_current_context_start = true
        }
      end
    }

    -- colorschemes
    use { 'mcchrish/zenbones.nvim', requires = 'rktjmp/lush.nvim' }
    --

    -- godot support
    use 'habamax/vim-godot'
    --

    -- -- coloscheme switcher
    -- use 'xolox/vim-misc'
    -- use 'xolox/vim-colorscheme-switcher'
    --

    --------------------------------

    ------
    -- LSP
    ------

    use {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v1.x',
      requires = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },

        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-nvim-lua' },
        { 'hrsh7th/cmp-vsnip' },

        -- Snippets
        { 'L3MON4D3/LuaSnip' },
        { 'rafamadriz/friendly-snippets' },

        -- Formatting
        { 'lukas-reineke/lsp-format.nvim' }
      },
      config = function()
        local lsp = require("lsp-zero")

        lsp.preset("recommended")

        lsp.format_on_save({
          format_opts = {
            async = true,
            timeout_ms = 10000,
          },
          servers = {
            ['lua_ls'] = { 'lua' },
            ['rust_analyzer'] = { 'rust' },
            -- if you have a working setup with null-ls
            -- you can specify filetypes it can format.
            ['null-ls'] = { 'javascript', 'typescript' },
          }
        })
        lsp.format_mapping('gq', {
          format_opts = {
            async = true,
            timeout_ms = 10000,
          },
          servers = {
            ['null-ls'] = { 'javascript', 'typescript', 'lua' },
          }
        })

        lsp.ensure_installed({
          'tsserver',
        })

        -- Fix Undefined global 'vim'
        lsp.nvim_workspace()

        local cmp = require('cmp')
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local cmp_mappings = lsp.defaults.cmp_mappings({
          ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
          ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        })

        cmp_mappings['<Tab>'] = nil
        cmp_mappings['<S-Tab>'] = nil

        lsp.setup_nvim_cmp({
          mapping = cmp_mappings
        })

        lsp.set_preferences({
          suggest_lsp_servers = true,
          sign_icons = {
            error = 'E',
            warn = 'W',
            hint = 'H',
            info = 'I'
          }
        })

        lsp.on_attach(function(client, bufnr)
          local opts = { buffer = bufnr, remap = false }

          vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
          vim.keymap.set("n", "gy", function() vim.lsp.buf.type_definition() end, opts)
          vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
          vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
          vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
          vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
          vim.keymap.set("n", "ld", function() vim.diagnostic.open_float() end, opts)
          vim.keymap.set("n", "<leader>ga", function() vim.lsp.buf.code_action() end, opts)
          vim.keymap.set("n", "gr", function() vim.cmd('Telescope lsp_references') end, opts)
          vim.keymap.set("n", "gR", function() vim.lsp.buf.rename() end, opts)
          vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        end)

        lsp.configure('zls', {
          single_file_support = true,
          cmd = { vim.fn.expand('$HOME/git/zig/zls/zig-out/bin/zls') }
        })

        lsp.setup()

        local null_ls = require('null-ls');
        null_ls.setup({
          -- add your sources / config options here
          sources = {
            null_ls.builtins.code_actions.eslint_d,
            null_ls.builtins.diagnostics.eslint_d,
            null_ls.builtins.formatting.eslint_d,
            null_ls.builtins.formatting.prettier,
          },
        })

        vim.diagnostic.config({
          virtual_text = true
        })
      end
    }


    -- lsp signature (displays signature params as you type)
    use {
      'ray-x/lsp_signature.nvim',
      config = function()
        require('lsp_signature').setup()
      end
    }
    --

    -- symbols outline
    -- use 'simrat39/symbols-outline.nvim'
    use {
      'stevearc/aerial.nvim',
      config = function()
        require('aerial').setup({})
      end
    }
    --

    -- Neovim LSP Integration
    -- use 'neovim/nvim-lspconfig'
    -- use 'gfanto/fzf-lsp.nvim'
    --

    -- lsp saga (fancier hover, actions lots of other things)
    -- use { 'glepnir/lspsaga.nvim', branch='main' }
    -- noice, experimental UI
    --
    -- use({
    --   "folke/noice.nvim",
    --   event = "VimEnter",
    --   config = function()
    --     require("noice").setup()
    --   end,
    --   requires = {
    --     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    --     "MunifTanjim/nui.nvim",
    --     -- OPTIONAL:
    --     --   `nvim-notify` is only needed, if you want to use the notification view.
    --     --   If not available, we use `mini` as the fallback
    --     "rcarriga/nvim-notify",
    --   }
    -- })
    --

    -- status line
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = function()
        require('lualine').setup {}
      end
    }

    -- [], {}, (), etc.
    use {
      'windwp/nvim-autopairs',
      config = function()
        require('nvim-autopairs').setup()
      end
    }
    --

    -- better typescript support (???)
    use 'jose-elias-alvarez/typescript.nvim';
    --

    -- nvim-cmp completion
    -- use 'hrsh7th/cmp-nvim-lsp'
    -- use 'hrsh7th/cmp-buffer'
    -- use 'hrsh7th/cmp-path'
    -- use 'hrsh7th/cmp-cmdline'
    -- use 'hrsh7th/nvim-cmp'
    -- use 'hrsh7th/cmp-vsnip'
    -- use 'hrsh7th/vim-vsnip'
    -- use {
    --   'David-Kunz/cmp-npm',
    --   requires = {
    --     'nvim-lua/plenary.nvim'
    --   }
    -- }
    --

    -- Treesitter for better highlight
    use {
      'nvim-treesitter/nvim-treesitter',
      config = function()
        require('nvim-treesitter.configs').setup {
          ensure_installed = { "regex", "c", "lua", "typescript", "zig", "javascript" },
          highlight = {
            enable = true
          },
        }
      end,
      run = ':TSUpdate',
    }

    -----
    use({
      "iamcco/markdown-preview.nvim",
      run = function() vim.fn["mkdp#util#install"]() end,
    })
  end
}
