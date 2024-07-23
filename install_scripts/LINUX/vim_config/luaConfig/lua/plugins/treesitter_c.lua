return
{
        {
                "nvim-treesitter/nvim-treesitter",
                lazy = false,
                event = { "BufReadPre", "BufNewFile" },
                build = ":TSUpdate",
                config = function()
                        local configs = require("nvim-treesitter.configs")
                        configs.setup({
                                ensure_installed = "maintained",
                                sync_install = false,
                                highlight = { enable = true },
                                indent = { enable = true },

                                incremental_selection = {
                                        enable = true,
                                        keymaps = {
                                                init_selection = "<C-space>",
                                                node_incremental = "<C-space>",
                                                scope_incremental = false,
                                                node_decremental = "<bs>",
                                        },
                                },
                                rainbow = {
                                        enable = true,
                                        disable = { "html" },
                                        extended_mode = false,
                                        max_file_lines = nil,
                                },
                                context_commentstring = {
                                        enable = true,
                                        enable_autocmd = false,
                                },
                        })
                end
        }
}
