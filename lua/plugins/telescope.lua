return {

    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
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
			}
		})
		require("telescope").load_extension("undo")
	end,

}
