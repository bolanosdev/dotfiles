return {
  {
    "nvim-telescope/telescope.nvim",

    keys = {
      { "<leader>tkm", "<cmd>Telescope keymaps<cr>", desc = "Browse Files" },
    },
    config = function() end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    keys = {
      { "<leader>sf", ":Telescope file_browser path=%:p:h=%:p:h<cr>", desc = "Browse files" },
    },
    config = function()
      require("telescope").load_extension("file_browser")
    end,
  },
}
