function ColorMyPencils(color)
	color = color or "TokyoDark"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloatNC", { bg = "none" })
	vim.api.nvim_set_hl(0, "EndOfBufferNC", { bg = "none" })


    vim.api.nvim_set_hl(0, "@string", { fg  = "#00aaaa" })
    vim.api.nvim_set_hl(0, "@comment", { fg = "#00cc00" })
    vim.api.nvim_set_hl(0, "@constant", { fg = "#e5c07b" })
    vim.api.nvim_set_hl(0, "@parameter", { fg = "#F6955B", italic = true })
    vim.api.nvim_set_hl(0, "@property", { fg = "#F6955B", italic = false })
    vim.api.nvim_set_hl(0, "Comment", { fg = "#eeeeee" })
    --Comment Color

    vim.api.nvim_set_hl(0, 'DiffAdd', { bg = '#2e453b' })    
    vim.api.nvim_set_hl(0, 'DiffChange', { bg = '#2e3b4e' }) 
    vim.api.nvim_set_hl(0, 'DiffDelete', { bg = '#4e2e2e' }) 
    vim.api.nvim_set_hl(0, 'DiffText', { bg = '#3d5e7a' })   

end

ColorMyPencils()
