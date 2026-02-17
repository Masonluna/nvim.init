return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "clangd", "omnisharp" },
                handlers = {  -- Use 'handlers', not 'setup_handlers'
                    function(server_name)
                        require("lspconfig")[server_name].setup({})
                    end,
                    ["clangd"] = function()
                        require("lspconfig").clangd.setup({
                            cmd = {
                                "clangd",
                                "--background-index",
                                "--clang-tidy",
                                "--header-insertion=iwyu",
                                "--completion-style=detailed",
                                "--function-arg-placeholders",
                            },
                        })
                    end,
                    ["omnisharp"] = function()
                        require("lspconfig").omnisharp.setup({
                            cmd = { "omnisharp" },
                            enable_roslyn_analyzers = true,
                            organize_imports_on_format = true,
                            enable_import_completion = true,
                        })
                    end,
                },
            })

            -- Keybindings via LspAttach autocmd (this is the standard way)
            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(args)
                    local opts = { buffer = args.buf }
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                    vim.keymap.set('n', '<leader>cf', function()
                        vim.lsp.buf.code_action({
                            context = { only = { 'quickfix' }},
                            apply = true
                        })
                    end, opts)
                    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
                end,
            })
        end,
    },
}
