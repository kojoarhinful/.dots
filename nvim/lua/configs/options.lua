-- basic stuff
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = "menuone,noselect,popup"
vim.opt.undofile = true
vim.g.undotree_SetFocusWhenToggle = 1
vim.opt.signcolumn = "yes"

-- indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.cmd("filetype plugin indent on")
