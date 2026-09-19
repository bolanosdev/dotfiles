return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup()


    vim.keymap.set('n', '<leader>ho', "<cmd>:HarpoonOpenAll<cr>", { desc = "Open All [M]arks" })
    vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "[H]arpoon [A]dd mark" })
    vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
      { desc = "[H]arpoon [T]oggle UI" })

    vim.keymap.set('n', '<leader>ht', "<cmd>:Telescope harpoon marks<cr>", { desc = "Show [M]arks (telescope)" })
    vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end, { desc = "[H]arpoon go to mark 1" })
    vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end, { desc = "[H]arpoon go to mark 2" })
    vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(2) end, { desc = "[H]arpoon go to mark 3" })
    vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(2) end, { desc = "[H]arpoon go to mark 4" })

    vim.keymap.set("n", "<C-h>", function() harpoon:list():next() end, { desc = "Harpoon next mark" })
    vim.keymap.set("n", "<C-l>", function() harpoon:list():prev() end, { desc = "Harpoon previous mark" })
  end
}
