-- treesitter: code highlighting
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c", "cpp", "rust", "go",
          "typescript", "javascript",
          "lua", "bash", "markdown",
        },
        auto_install = true,
        highlight = {
          enable = true,
          disable = { "markdown", "markdown-inline" },
        },
        indent = { enable = false },
      })
    end,
  },
}
