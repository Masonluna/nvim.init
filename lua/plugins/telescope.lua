return {

    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
	    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install' },
        'debugloop/telescope-undo.nvim',
    },
    lazy = false,
	config = function()
		require("telescope").setup({
			extensions = {
				undo = {
				      	side_by_side = true,
				      	layout_strategy = "vertical",
                        layout_config = {
                            preview_height = 0.8,
                        },
				},
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                }
			}
		})
		require("telescope").load_extension("undo")
        require("telescope").load_extension("fzf")
	end,

}
