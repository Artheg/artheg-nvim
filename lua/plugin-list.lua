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
    -- use { 'jose-elias-alvarez/null-ls.nvim',
    --   config = function()
    --     local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    --     local null_ls = require('null-ls');
    --     null_ls.setup({
    --       -- add your sources / config options here
    --       sources = {
    --         null_ls.builtins.code_actions.eslint_d,
    --         null_ls.builtins.diagnostics.eslint_d,
    --         null_ls.builtins.formatting.eslint_d,
    --         null_ls.builtins.formatting.prettier,
    --       },
    --       debug = false,
    --       on_attach = function(client, bufnr)
    --         if client.supports_method("textDocument/formatting") then
    --           vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    --           vim.api.nvim_create_autocmd("BufWritePost", {
    --             group = augroup,
    --             buffer = bufnr,
    --             callback = function()
    --               if vim.bo.filetype == 'typescript' or vim.bo.filetype == 'typescriptreact' then
    --                 local original = "@gsbaltic/telesis/src/modules"
    --                 local replacement = "@telesis"
    --                 vim.api.nvim_command("silent! :%s/" ..
    --                 vim.fn.escape(original, "/") .. "/" .. vim.fn.escape(replacement, "/") .. "/g")
    --                 vim.api.nvim_command("silent! :%s/" ..
    --                 vim.fn.escape('@gsbaltic/telesis/src/engines', "/") .. "/" .. vim.fn.escape(replacement, "/") .. "/g")
    --               end
    --               async_formatting(bufnr)
    --             end,
    --           })
    --         end
    --       end,
    --     })
    --   end }
    --

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
    use 'kyazdani42/blue-moon'
    use 'bluz71/vim-nightfly-guicolors'
    use 'Pocco81/Catppuccino.nvim'
    use 'kdheepak/monochrome.nvim'
    use 'flazz/vim-colorschemes'
    use 'savq/melange'
    use 'fenetikm/falcon'
    use 'ayu-theme/ayu-vim'
    use 'cocopon/iceberg.vim'
    use 'EdenEast/nightfox.nvim'
    use 'fcpg/vim-farout'
    use 'adigitoleo/vim-mellow'
    use 'slugbyte/yuejiu'
    use 'azolus/evernight.nvim'
    use 'yonlu/omni.vim'
    use 'aktersnurra/no-clown-fiesta.nvim'
    use { 'mcchrish/zenbones.nvim', requires = 'rktjmp/lush.nvim' }
    use 'kwsp/halcyon-neovim'
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

        -- Snippets
        { 'L3MON4D3/LuaSnip' },
        { 'rafamadriz/friendly-snippets' },

        -- Formatting
        { 'lukas-reineke/lsp-format.nvim' }
      },
      config = function()
        local lsp = require("lsp-zero")

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
        lsp.preset("recommended")

        lsp.format_on_save({
          format_opts = {
            async = false,
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
            async = false,
            timeout_ms = 10000,
          },
          servers = {
            ['null-ls'] = { 'javascript', 'typescript', 'lua' },
          }
        })

        lsp.ensure_installed({
          'tsserver',
          'rust_analyzer',
          'null-ls'
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

        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        local async_formatting = function(bufnr)
          bufnr = bufnr or vim.api.nvim_get_current_buf()

          vim.lsp.buf_request(
            bufnr,
            "textDocument/formatting",
            vim.lsp.util.make_formatting_params({}),
            function(err, res, ctx)
              if err then
                local err_msg = type(err) == "string" and err or err.message
                -- you can modify the log message / level (or ignore it completely)
                vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
                return
              end

              -- don't apply results if buffer is unloaded or has been modified
              if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
                return
              end

              if res then
                local client = vim.lsp.get_client_by_id(ctx.client_id)
                vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or "utf-16")
                vim.api.nvim_buf_call(bufnr, function()
                  vim.cmd("silent noautocmd update")
                end)
              end
            end
          )
        end
        lsp.on_attach(function(client, bufnr)
          local opts = { buffer = bufnr, remap = false }

          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            -- vim.api.nvim_create_autocmd("BufWritePost", {
            --   group = augroup,
            --   buffer = bufnr,
            --   callback = function()
            --     -- async_formatting(bufnr)
            --   end
            -- })
          end
          vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
          vim.keymap.set("n", "gy", function() vim.lsp.buf.type_definition() end, opts)
          vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
          vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
          vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
          vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
          vim.keymap.set("n", "ld", function() vim.diagnostic.open_float() end, opts)
          vim.keymap.set("n", "<leader>ga", function() vim.lsp.buf.code_action() end, opts)
          vim.keymap.set("n", "<leader>gr", function() vim.lsp.buf.references() end, opts)
          vim.keymap.set("n", "<leader>gR", function() vim.lsp.buf.rename() end, opts)
          vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        end)

        lsp.setup()

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
