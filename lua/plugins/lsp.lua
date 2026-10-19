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
            -- mason-lspconfig v2 no longer supports `handlers`; servers are
            -- configured with vim.lsp.config and enabled automatically.
            vim.lsp.config("clangd", {
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=iwyu",
                    "--completion-style=detailed",
                    "--function-arg-placeholders",
                },
            })

            -- C# uses Roslyn (dotnet tool `roslyn-language-server`, not Mason):
            --   dotnet tool update -g roslyn-language-server --prerelease
            vim.lsp.config("roslyn_ls", {
                settings = {
                    ["csharp|background_analysis"] = {
                        dotnet_analyzer_diagnostics_scope = "openFiles",
                        dotnet_compiler_diagnostics_scope = "openFiles",
                    },
                    ["csharp|completion"] = {
                        dotnet_show_completion_items_from_unimported_namespaces = true,
                        dotnet_show_name_completion_suggestions = true,
                    },
                },
                on_attach = function(client)
                    -- Late-arriving semantic tokens recolor the buffer after
                    -- treesitter has painted it; keep treesitter as the only source.
                    client.server_capabilities.semanticTokensProvider = nil
                end,
            })
            vim.lsp.enable("roslyn_ls")

            require("mason-lspconfig").setup({
                ensure_installed = { "clangd" },
                automatic_enable = { "clangd" },
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
