vim.o.nu = true
vim.o.relativenumber = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true

vim.o.cindent = true
vim.o.cinoptions = "l1,(8,:0"

vim.o.wrap = false

vim.o.swapfile = false
vim.o.backup = false

local undodir = vim.fn.stdpath("data") .."/undo"
if not vim.loop.fs_stat(undodir) then
    vim.fn.mkdir(undodir, "p")
end

vim.o.undodir = undodir
vim.o.undofile = true
vim.o.hlsearch = true
vim.o.incsearch = true

vim.o.termguicolors = true

vim.o.scrolloff = 8
vim.o.signcolumn = "yes"

vim.opt.isfname:append("@")
vim.o.updatetime = 50

vim.o.colorcolumn = "120"

vim.g.mapleader = " "
