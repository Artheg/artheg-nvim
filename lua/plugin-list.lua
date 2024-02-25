return {
  startup = function(use)
    -- Packer (plugin manager)
    use("wbthomason/packer.nvim")
    --

    -- project managament, Rooter
    use({
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
    })
    --

    -- git blamer
    use({
      "f-person/git-blame.nvim",
      config = function()
        vim.g.gitblame_date_format = "%d.%m.%y %H:%M"
        vim.g.gitblame_message_template = "// <author> (<committer-date>) • <summary>"
      end,
    })
    --

    -- git signs and hunk actions
    use({ "airblade/vim-gitgutter", branch = "main" })
    --

    -- git conflict helper
    use({
      "akinsho/git-conflict.nvim",
      tag = "*",
      config = function()
        require("git-conflict").setup()
      end,
    })

    -- extends match (matches special words)
    use("andymass/vim-matchup")
    --

    -- automatically replaces words
    use({
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
    })
    --

    -- fuzzy file search
    use({ "junegunn/fzf" })
    use({ "junegunn/fzf.vim" })
    --

    -- Debugger
    use({
      "mfussenegger/nvim-dap",
      config = function()
        local dap = require("dap")

        -- vim.fn.sign_define('DapBreakpoint', {text='⭕', texthl='BP', linehl='LineBreakpoint', numhl=''})
        vim.fn.sign_define(
          "DapBreakpoint",
          { text = "", texthl = "LineBreakpoint", linehl = "LineBreakpoint", numhl = "LineBreakpoint" }
        )
        vim.fn.sign_define("DapStopped", {
          text = "",
          texthl = "DapStopped",
          linehl = "DapStopped",
          numhl = "DapStopped",
        })
        vim.api.nvim_set_hl(0, "LineBreakpoint", { ctermbg = 0, bg = "#511111" })
        vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, bg = "#934111" })

        dap.adapters.lldb = {
          type = "executable",
          command = "lldb-vscode",
          name = "lldb",
        }

        dap.adapters.chrome = {
          type = "executable",
          command = "node",
          args = { os.getenv("HOME") .. "/git/vscode-chrome-debug/out/src/chromeDebug.js" }, -- TODO adjust
        }

        dap.configurations.c = {
          type = "lldb",
          request = "launch",
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
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
            webRoot = "${workspaceFolder}",
          },
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
          },
        }
      end,
    })
    --

    -- experimental ui for dap
    use({
      "rcarriga/nvim-dap-ui",
      requires = { "mfussenegger/nvim-dap" },
      config = function()
        require("dapui").setup()
      end,
    })

    -- better word motion (e.g. CamelCase)
    use("chaoren/vim-wordmotion")
    --

    -- lf file manager
    use({
      "ptzz/lf.vim",
      config = function()
        vim.g["lf_replace_netrw"] = 1
        vim.g["lf_map_keys"] = 0
      end,
    })
    --

    -- floating terminal
    use({
      "voldikss/vim-floaterm",
    })
    --

    -- highlight other uses of words
    use({
      "RRethy/vim-illuminate",
      config = function()
        vim.cmd([[
          augroup illuminate_augroup
          autocmd!
          autocmd VimEnter * hi illuminatedWord ctermbg=DarkBlue guibg=DarkBlue
          augroup END
        ]])
      end,
    })
    --

    -- commenter
    use("tpope/vim-commentary")
    --

    -- Telescope (highly extendable fuzzy finder over lists. Built on the latest awesome features from neovim)
    use({
      "nvim-telescope/telescope.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        local telescope = require("telescope")
        telescope.load_extension("projects")
        telescope.load_extension("fzf")
        telescope.load_extension("fzy_native")
        telescope.load_extension("projects")
      end,
    })
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    use({ "nvim-telescope/telescope-fzy-native.nvim" })
    --

    -- highlight hex colors
    use({
      "chrisbra/Colorizer",
      config = function() end,
    })
    --

    -- better surrounding chars edit
    use("tpope/vim-surround")
    --

    -- colorschemes
    use({ "mcchrish/zenbones.nvim", requires = "rktjmp/lush.nvim" })
    --

    -- godot support
    use("habamax/vim-godot")
    --

    -- -- coloscheme switcher
    -- use 'xolox/vim-misc'
    -- use 'xolox/vim-colorscheme-switcher'
    --

    --------------------------------

    ------
    -- LSP
    ------

    use({
      "VonHeikemen/lsp-zero.nvim",
      branch = "v1.x",
      requires = {
        -- LSP Support
        { "neovim/nvim-lspconfig" },
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
        -- Better typescript integration
        {
          "pmizio/typescript-tools.nvim",
          requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
          config = function()
          end,
        },
        -- fancy icons
        { "onsails/lspkind.nvim" },
        -- Autocompletion
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "saadparwaiz1/cmp_luasnip" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-nvim-lua" },
        { "hrsh7th/cmp-vsnip" },

        -- Snippets
        { "L3MON4D3/LuaSnip" },
        { "rafamadriz/friendly-snippets" },

        -- Formatting
        {
          "lukas-reineke/lsp-format.nvim",
          config = function()
            require("lsp-format").setup()
          end
        },
      },
      config = function()
        local lsp = require("lsp-zero")

        lsp.preset("recommended")

        lsp.ensure_installed({
          "lua_ls"
        })

        -- Fix Undefined global 'vim'
        lsp.nvim_workspace()

        local cmp = require("cmp")
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local cmp_mappings = lsp.defaults.cmp_mappings({
          ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
          ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        })

        cmp_mappings["<Tab>"] = nil
        cmp_mappings["<S-Tab>"] = nil

        lsp.setup_nvim_cmp({
          mapping = cmp_mappings,
        })

        lsp.set_preferences({
          suggest_lsp_servers = true,
          sign_icons = {
            error = "E",
            warn = "W",
            hint = "H",
            info = "I",
          },
        })

        local on_attach = function(client, bufnr)
          require("lsp-format").on_attach(client, bufnr)
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

        lsp.on_attach(function(client, bufnr)
          on_attach(client, bufnr)
        end)

        lsp.configure("zls", {
          single_file_support = true,
          cmd = { vim.fn.expand("$HOME/git/zig/zls/zig-out/bin/zls") },
        })

        lsp.skip_server_setup({ 'tsserver' })
        require("typescript-tools").setup({
          on_attach = function(client, bufnr)
            on_attach(client, bufnr)
          end,
        })

        lsp.setup()

        vim.diagnostic.config({
          virtual_text = true,
        })
      end,
    })

    -- lsp signature (displays signature params as you type)
    use({
      "ray-x/lsp_signature.nvim",
      config = function()
        require("lsp_signature").setup()
      end,
    })
    --

    -- symbols outline
    -- use 'simrat39/symbols-outline.nvim'
    use({
      "stevearc/aerial.nvim",
      config = function()
        require("aerial").setup({})
      end,
    })
    --

    -- status line
    use({
      "nvim-lualine/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
      config = function()
        require("lualine").setup({})
      end,
    })

    -- [], {}, (), etc.
    use({
      "windwp/nvim-autopairs",
      config = function()
        require("nvim-autopairs").setup()
      end,
    })
    --

    -- Treesitter for better highlight
    use({
      "nvim-treesitter/nvim-treesitter",
      config = function()
        require("nvim-treesitter.configs").setup({
          ensure_installed = { "regex", "c", "lua", "typescript", "zig", "javascript", "markdown" },
          highlight = {
            enable = true,
          },
        })
      end,
      run = ":TSUpdate",
    })

    -----
  end,
}
