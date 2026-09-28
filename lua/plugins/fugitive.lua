return {
    "tpope/vim-fugitive",
    lazy = false,
    keys = {
        {"<leader>gs", "<cmd>Git<CR>", desc = "Git Status" },
        {"<leader>gc", "<cmd>Git commit<CR>", desc = "Git Commit" },
        {"<leader>gp", "<cmd>Git push<CR>", desc = "Git Push" }
    },
}
