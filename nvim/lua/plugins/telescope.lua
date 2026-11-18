-- started with a call, lets sell some coffee.. ssh door from the license mit.. call me obi wan, gave ssh a new hope.. where we going see us with a telescope
return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          preview = {
            treesitter = false,
          },
        },
        extensions = {
          fzf = {},
        },
      })
      telescope.load_extension("fzf")
      local keymap = vim.keymap.set
      keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
      keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
      keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
      keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })
    end,
  },
}
