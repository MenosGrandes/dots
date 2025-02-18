return {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
                "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
                -- local nvim_lsp = require("lspconfig")
                -- local protocol = require("vim.lsp.protocol")
                local on_attach = function(client, bufnr)
                        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
                        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
                        --Enable completion triggered by <c-x><c-o>
                        -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
                        -- Mappings.
                        local opts = { noremap = true, silent = true }
                        -- See `:help vim.lsp.*` for documentation on any of the below functions
                        buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
                        buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
                        buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
                        buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
                        buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
                        buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
                        buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
                        buf_set_keymap('n', '<space>wl',
                                '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
                        buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
                        buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
                        buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
                        buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
                        buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
                        buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
                        buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
                        buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
                end
                local capabilities = require("cmp_nvim_lsp").default_capabilities()
                local nvim_lsp = require('lspconfig')
                -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
                local servers = { 'pyright', 'html', 'ts_ls', 'erlangls', 'bashls', 'lemminx', 'jsonls', 'taplo', 'gopls' }
                for _, lsp in ipairs(servers) do
                        nvim_lsp[lsp].setup {
                                on_attach = on_attach,
                                capabilities = capabilities,
                        }
                end
                nvim_lsp["clangd"].setup {
                        capabilities = capabilities,
                        flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
                        cmd = { "clangd", '--clang-tidy', '--background-index', '--all-scopes-completion', '--header-insertion=never', '--cross-file-rename' },
                        on_attach = on_attach,
                }
                require 'lspconfig'.lua_ls.setup {
                        on_init = function(client)
                                local path = client.workspace_folders[1].name
                                if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                                        return
                                end
                                client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                                        runtime = {
                                                -- Tell the language server which version of Lua you're using
                                                -- (most likely LuaJIT in the case of Neovim)
                                                version = 'LuaJIT'
                                        },
                                        -- Make the server aware of Neovim runtime files
                                        workspace = {
                                                checkThirdParty = false,
                                                library = {
                                                        vim.env.VIMRUNTIME
                                                        -- Depending on the usage, you might want to add additional paths here.
                                                        -- "${3rd}/luv/library"
                                                        -- "${3rd}/busted/library",
                                                }
                                                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                                                -- library = vim.api.nvim_get_runtime_file("", true)
                                        }
                                })
                        end,
                        settings = {
                                Lua = {}
                        }
                }
        end,
}
