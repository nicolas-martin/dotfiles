return require('packer').startup(function(use)
        use 'wbthomason/packer.nvim'
        use 'preservim/nerdtree'
        use 'tpope/vim-repeat'
        use 'tpope/vim-surround'
        use 'tpope/vim-commentary'
        -- use 'ellisonleao/gruvbox.nvim'
        use 'EdenEast/nightfox.nvim'
        use 'fatih/vim-go'
        use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
        -- to debug treesitter syntax
        use 'nvim-treesitter/playground'

        -- refactor
        use 'dyng/ctrlsf.vim'

        -- Collection of common configurations for the Nvim LSP client
        use 'neovim/nvim-lspconfig'

        -- LSP completion source for nvim-cmp
        -- use 'hrsh7th/cmp-nvim-lsp-signature-help'
        use 'ray-x/lsp_signature.nvim'
        -- add the nice source + completion item kind to the menu
        use {
                'onsails/lspkind.nvim',
                config = function()
                        require('lspkind').init()
                end
        }

        -- Snippet completion source for nvim-cmp
        -- Autocompletion framework
        use("hrsh7th/nvim-cmp")
        use("hrsh7th/cmp-nvim-lsp")
        use("hrsh7th/cmp-path")
        use("hrsh7th/cmp-buffer")

        -- Snippets
        use("L3MON4D3/LuaSnip")
        use("rafamadriz/friendly-snippets")
        use("saadparwaiz1/cmp_luasnip")

        -- See hrsh7th's other useins for more completion sources!
        use 'hrsh7th/cmp-cmdline'

        -- nice icons
        use 'kyazdani42/nvim-web-devicons'

        -- Fuzzy finder
        -- Optional
        use 'nvim-lua/popup.nvim'
        use {
                'nvim-telescope/telescope.nvim',
                requires = { { 'nvim-lua/plenary.nvim' } }
        }
        use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

        use("simrat39/rust-tools.nvim")

        -- lua / plugin
        use 'folke/lua-dev.nvim'

        -- move syntax
        use 'rvmelkonian/move.vim'

        -- Copilot setup
        use {
                "zbirenbaum/copilot.lua",
                cmd = "Copilot",
                event = "InsertEnter",
                config = function()
                        require("copilot").setup({
                                suggestion = { enabled = false },
                                panel = { enabled = false },
                        })
                end,
        }
        use {
                "zbirenbaum/copilot-cmp",
                after = { "copilot.lua" },
                config = function()
                        require("copilot_cmp").setup()
                end
        }
        -- use 'github/copilot.vim'
        use({
                "olimorris/codecompanion.nvim",
                requires = {
                        "nvim-lua/plenary.nvim",
                        "nvim-treesitter/nvim-treesitter",
                }
        })

        use {
                "pmizio/typescript-tools.nvim",
                requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
                config = function()
                        require("typescript-tools").setup {}
                end,
        }
end)
