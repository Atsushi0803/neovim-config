-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- {
        --     "ivechan/gtags.vim",
        -- },
        -- {
        --     "ivechan/telescope-gtags",
        -- },
        {
            "gtags.vim",
            dir = "~/.config/nvim/lua/plugins", -- プラグインが配置されているディレクトリを指定
            config = function()
                vim.cmd("runtime lua/plugins/gtags.vim")
                -- vim.cmd("runtime lua/plugins/gtags-cscope.vim") -- nvimからcscope対応が外されたためNOP化
            end,
        },
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            config = function ()
                local configs = require("nvim-treesitter")
                configs.setup({
                    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html" },
                    sync_install = false,
                    highlight = { enable = true },
                    indent = { enable = true },
                    endwise = { enable = true }
                })
            end
        },
        {
	        "cocopon/iceberg.vim",
	        lazy=false,
	        priority=1000,
	        config = function()
	            vim.cmd("colorscheme iceberg")
	        end
        },
        {
            'nvim-lualine/lualine.nvim',
            dependencies = { 'nvim-tree/nvim-web-devicons' },
            config = function ()
                require("lualine").setup()
            end
        },
        {
            'akinsho/bufferline.nvim',
            version = "*",
            dependencies = 'nvim-tree/nvim-web-devicons',
            config = function ()
                require("bufferline").setup()
	            vim.o.termguicolors=true
            end
        },
        -- LSPの設定
        {
            "neovim/nvim-lspconfig",
            config = function()
                -- 使用するLSPサーバーを設定
                require('lspconfig').lua_ls.setup {}
                -- 必要に応じて他のLSPサーバーも追加
            end,
        },
        -- MasonでLSPとフォーマッタの管理
        {
            "williamboman/mason.nvim",
            config = function()
                require("mason").setup()
            end,
        },
        {
            "williamboman/mason-lspconfig.nvim",
            config = function()
                require("mason-lspconfig").setup({
                    ensure_installed = { "lua_ls"}, -- 必要なLSPサーバーを指定
                })
            end,
        },
        {
            "zapling/mason-conform.nvim",
            dependencies = { "mason.nvim" },
            config = function()
                require("mason-conform").setup({
                    ensure_installed = { "stylua", "prettier" }, -- 必要なフォーマッタを指定
                })
            end,
        },
        -- Conformの設定（フォーマッタ管理）
        {
            "stevearc/conform.nvim",
            config = function()
                require("conform").setup({
                    formatters_by_ft = {
                        lua = { "stylua" },
                        javascript = { "prettier" },
                    },
                })
            end,
        },
        {
            "folke/trouble.nvim",
            opts = {}, -- for default options, refer to the configuration section for custom setup.
            cmd = "Trouble",
            keys = {
                {
                    "<leader>xx",
                    "<cmd>Trouble diagnostics toggle<cr>",
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
        {
            'nvim-telescope/telescope.nvim',
            tag = '0.1.8',
            dependencies = { 
                "nvim-lua/plenary.nvim",
                "nvim-telescope/telescope-live-grep-args.nvim"
            },
            config = function()
                local configs = require("telescope")
                configs.setup()
                configs.load_extension("live_grep_args")
            end
        },
        {
            "ibhagwan/fzf-lua",
            -- optional for icon support
            dependencies = { "nvim-tree/nvim-web-devicons" },
            config = function()
                -- calling `setup` is optional for customization
                require("fzf-lua").setup({})
            end
        },
        {
            'rmagatti/auto-session',
            lazy = false,

            ---enables autocomplete for opts
            ---@module "auto-session"
            ---@type AutoSession.Config
            opts = {
                suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
            -- log_level = 'debug',
            }
        },
        {
            "karb94/neoscroll.nvim",
            config = function ()
                require('neoscroll').setup({})
            end
        },
        {
            'windwp/nvim-autopairs',
            event = "InsertEnter",
            config = true
        },
        {
            'nvimdev/dyninput.nvim',
            dependencies = {'nvim-treesitter/nvim-treesitter'},
            config = function()
                local configs = require('dyninput')
                local rs = require('dyninput.lang.rust')
                local ms = require('dyninput.lang.misc')
                configs.setup({
                    c = {
                        ['-'] = {
                            { '->', ms.c_struct_pointer },
                            { '_', ms.snake_case },
                        },
                    },
                    rust = {
                        [';'] = {
                            { '::', rs.double_colon },
                            { ': ', rs.single_colon },
                        },
                        ['='] = { ' => ', rs.fat_arrow },
                        ['-'] = {
                            { ' -> ', rs.thin_arrow },
                            { '_', ms.snake_case },
                        },
                        ['\\'] = { '|!| {}', rs.closure_fn },
                    },
                })
            end
        },
        {
            'numToStr/Comment.nvim',
            config = function()
                local configs = require("Comment")
                configs.setup()
            end
        },
        {
            "nvim-treesitter/nvim-treesitter-context",
            config = function()
                local configs = require("treesitter-context")
                configs.setup()
            end
        },
        -- Configure any other settings here. See the documentation for more details.
        -- automatically check for plugin updates
        checker = { enabled = true },
    }
})
