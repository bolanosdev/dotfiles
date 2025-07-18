return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/neotest-go",
    "nvim-neotest/neotest-jest",
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter"
  },
  config = function()
    local neotest_ns = vim.api.nvim_create_namespace("neotest")
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          local message =
              diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
          return message
        end,
      },
    }, neotest_ns)

    require("neotest").setup({
      adapters = {
        require("neotest-go"),
        require("neotest-jest")({
          jestCommand = "npm test --",
          jestConfigFile = "jest.config.(js|ts)",
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        }),
      },
    })


    vim.keymap.set("n", "<leader>tr", function()
      require("neotest").run.run()
    end, { desc = "[R]un nearest" })

    vim.keymap.set("n", "<leader>td", function()
      require("neotest").run.run({ strategy = "dap" })
    end, { desc = "[D]ebug nearest" })

    vim.keymap.set("n", "<leader>tf", function()
      require("neotest").run.run(vim.fn.expand("%"))
    end, { desc = "All tests in current [F]ile" })

    vim.keymap.set("n", "<leader>ts", function()
      require("neotest").summary.toggle()
    end, { desc = "Toggle [S]ummary" })

    vim.keymap.set("n", "<leader>to", function()
      require("neotest").output.open({ enter = true })
    end, { desc = "Show test [O]utput" })
  end

}
