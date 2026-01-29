return {
    {
        "neovim/nvim-lspconfig",

        -- Mason for managing LSP servers
        {
            "williamboman/mason.nvim",
            config = function()
                require("mason").setup()
            end,
        },

        -- Mason-lspconfig bridge
        {
            "williamboman/mason-lspconfig.nvim",
            dependencies = { "williamboman/mason.nvim" },
            config = function()
                require("mason-lspconfig").setup({
                    ensure_installed = { "clangd", "omnisharp" },
                })
            end,
        },

        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            -- Setup mason first
            require("mason").setup()

            -- Mason-lspconfig bridges mason and lspconfig
            require("mason-lspconfig").setup({
                ensure_installed = { "clangd", "omnisharp" },
            })

            -- Now setup the actual LSP servers
            -- Mason-lspconfig provides handlers that set up servers automatically
            require("mason-lspconfig").setup_handlers({
                -- Default handler for all servers
                function(server_name)
                    require("lspconfig")[server_name].setup({})
                end,

                -- Custom handler for clangd
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

                -- Custom handler for omnisharp
                ["omnisharp"] = function()
                    require("lspconfig").omnisharp.setup({
                        cmd = { "omnisharp" },
                        enable_roslyn_analyzers = true,
                        organize_imports_on_format = true,
                        enable_import_completion = true,
                    })
                end,
            })

            -- LSP keybindings
            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(args)
                    local opts = { buffer = args.buf }
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
                end,
            })
        end,
    },
}
