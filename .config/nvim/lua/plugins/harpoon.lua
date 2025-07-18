return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2", -- ← important!
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").load_extension('harpoon')
      local harpoon = require("harpoon")

      harpoon:setup()

      local keymap = vim.keymap.set
      local list = harpoon:list()

      keymap('n', '<leader>ho', "<cmd>:HarpoonOpenAll<cr>", { desc = "Open All [M]arks" })
      keymap('n', '<leader>ht', "<cmd>:Telescope harpoon marks<cr>", { desc = "Show [M]arks (telescope)" })
      keymap("n", "<leader>ha", function() list:add() end, { desc = "[H]arpoon [A]dd mark" })
      keymap("n", "<leader>hq", function() harpoon.ui:toggle_quick_menu(list) end, { desc = "[H]arpoon [T]oggle UI" })

      keymap("n", "<leader>h1", function() list:select(1) end, { desc = "[H]arpoon go to mark 1" })
      keymap("n", "<leader>h2", function() list:select(2) end, { desc = "[H]arpoon go to mark 2" })
      keymap("n", "<leader>h3", function() list:select(2) end, { desc = "[H]arpoon go to mark 3" })
      keymap("n", "<leader>h4", function() list:select(2) end, { desc = "[H]arpoon go to mark 4" })

      keymap("n", "<C-h>", function() list:next() end, { desc = "Harpoon next mark" })
      keymap("n", "<C-l>", function() list:prev() end, { desc = "Harpoon previous mark" })
    end
  },
}
