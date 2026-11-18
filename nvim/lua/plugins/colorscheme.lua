return {
    {
        "2nthony/vitesse.nvim",
        lazy = false,
        priority = 1000,
        dependencies = {
            "tjdevries/colorbuddy.nvim",
        },
        config = function()
            require("vitesse").setup()
            vim.cmd.colorscheme("vitesse")
            -- fix statusline visibility
	vim.api.nvim_set_hl(0, "StatusLine", { fg = "#dbd7ca", bg = "NONE" })
	vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "#dbd7ca", bg = "NONE" })
        end,
    },
}
