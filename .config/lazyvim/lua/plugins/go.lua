local dap = require("dap")
local dapui = require("dapui")

return {
  { "nvim-treesitter/nvim-treesitter" },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "leoluz/nvim-dap-go",
      "theHamsta/nvim-dap-virtual-text",
    },
    opts = function()
      dap.configurations.go = {
        {
          type = "go",
          name = "brawney api",
          request = "launch",
          program = "${file}",
          args = { "start" }, -- ← your CLI args here
        },
      }
      vim.keymap.set("n", "<F2>", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
      vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
      vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result." })
      vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
      vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
      vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
    end,
  },
}
