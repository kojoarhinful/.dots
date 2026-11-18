local map = vim.keymap.set

-- saving and quitting
map("n", "<leader>w", "<cmd>w<cr>")
map("n", "<leader>q", "<cmd>q<cr>")

-- quick escape
map("i", "jk", "<ESC>")

-- terminal
map("n", "<leader>t", ":botright 21split | terminal<CR>", { desc = "bottom terminal" })
map("n", "<leader>tt", "<cmd>terminal<cr>", { desc = "open terminal" })
map("t", "jk", "<C-\\><C-n>", { desc = "exit terminal mode" })
map("n", "<C-j>", "<C-w>j", { desc = "go down" })
map("n", "<C-k>", "<C-w>k", { desc = "go up" })

-- jump into projects folder with telescope
map("n", "<leader>fp", function()
    require("telescope.builtin").find_files({
        prompt_title = "Projects",
        cwd = "~/space",
        find_command = { "find", ".", "-maxdepth", "1", "-type", "d" },
    })
end)

-- lsp servers
vim.lsp.enable({
    "clangd",
    "rust_analyzer",
    "gopls",
    "ts_ls",
})
