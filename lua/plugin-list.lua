return {
  startup = function (use) 

    -- Packer (plugin manager)
    use 'wbthomason/packer.nvim'
    --

    -- ALE
    use 'dense-analysis/ale'
    --

    -- Rooter
    use 'ahmedkhalf/project.nvim'
    --

    -- git blamer 
    use 'f-person/git-blame.nvim'

    -- git signs and hunk actions
    use {'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim'}
    use {'airblade/vim-gitgutter'}
    --

    ---- create themes with live preview
    -- use {'rktjmp/lush.nvim'}
    ----

    -- extends match (matches special words)
    use 'andymass/vim-matchup'
    --

    -- automatically replaces words
    use 'AndrewRadev/switch.vim'
    --

    -- fuzzy file search
    use {'junegunn/fzf'}
    use {'junegunn/fzf.vim'}
    --

    -- Debugger 
    use 'mfussenegger/nvim-dap'
    --

    -- zig support
    use 'ziglang/zig.vim'
    --

    -- better word motion (e.g. CamelCase)
    use 'chaoren/vim-wordmotion'
    --

    -- lf file manager
    use 'ptzz/lf.vim'
    --

    -- floating terminal
    use 'voldikss/vim-floaterm'
    --

    -- highlight other uses of words
    use 'RRethy/vim-illuminate'
    --
    
    -- formatter
    use 'sbdchd/neoformat'
    --

    -- commenter
    use 'tpope/vim-commentary'
    --

    -- Telescope (highly extendable fuzzy finder over lists. Built on the latest awesome features from neovim)
    use {'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim'}
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }  
    use {'nvim-telescope/telescope-fzy-native.nvim' }  
    --

    -- highlight hex colors
    use 'chrisbra/Colorizer'
    --

    -- better surrounding chars edit
    use 'tpope/vim-surround'
    --

    -- adds indentation guides 
    use 'lukas-reineke/indent-blankline.nvim'

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
    --

    -- -- coloscheme switcher
    -- use 'xolox/vim-misc'
    -- use 'xolox/vim-colorscheme-switcher'
    --

    --------------------------------

    ------
    -- LSP
    ------

    -- lsp signature (displays signature params as you type)
    use 'ray-x/lsp_signature.nvim'
    --

    -- symbols outline
    use 'simrat39/symbols-outline.nvim'
    --

    -- Neovim LSP Integration
    use 'neovim/nvim-lspconfig'
    use 'gfanto/fzf-lsp.nvim'
    --

    -- lsp saga (fancier hover, actions lots of other things)
    use 'tami5/lspsaga.nvim'
    --

    -- [], {}, (), etc.
    use 'windwp/nvim-autopairs'
    --

    -- better typescript support (???)
    use 'jose-elias-alvarez/typescript.nvim';
    --

    -- nvim-cmp completion
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
    --

    -- Treesitter for better highlight
    use {'nvim-treesitter/nvim-treesitter', run=':TSUpdate'}

    -----

end
}
