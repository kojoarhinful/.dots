return {
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          c = { "clang_format" },
          cpp = { "clang_format" },
          rust = { "rustfmt" },
          go = { "gofmt" },
          typescript = { "prettier" },
          javascript = { "prettier" },
        },
        format_after_save = nil,
        format_on_save = nil,
      })

      vim.keymap.set({ "n", "v" }, "<leader>cf", function()
        require("conform").format({ timeout_ms = 100, lsp_fallback = true })
      end)
    end,
  },
}
