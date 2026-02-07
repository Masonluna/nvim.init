function ColorMyPencils(color)
	color = color or "TokyoDark"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

    vim.api.nvim_set_hl(0, "@string", { fg  = "#00aaaa" })
    vim.api.nvim_set_hl(0, "@comment", { fg = "#00cc00" })
    --Comment Color
end

ColorMyPencils()
