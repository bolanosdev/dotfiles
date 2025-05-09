return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "hurl" })
    end,
  },
  {
    "jellydn/hurl.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = "hurl",
    opts = {
      -- Show debugging info
      debug = false,
      -- Show notification on run
      show_notification = false,
      -- Show response in popup or split
      mode = "popup",
      -- Default formatter
      formatters = {
        json = { "jq" }, -- Make sure you have install jq in your system, e.g: brew install jq
        html = {
          "prettier", -- Make sure you have install prettier in your system, e.g: npm install -g prettier
          "--parser",
          "html",
        },
        xml = {
          "tidy", -- Make sure you have installed tidy in your system, e.g: brew install tidy-html5
          "-xml",
          "-i",
          "-q",
        },
      },
    },
    keys = {
      -- Run API request
      { "<leader>ta", "<cmd>HurlRunner<CR>", desc = "Run All requests" },
      { "<leader>tA", "<cmd>HurlRunnerAt<CR>", desc = "Run Api request" },
      --{ "<leader>ce", "<cmd>HurlRunnerToEntry<CR>", desc = "Run Api request to entry" },
      { "<leader>tv", "<cmd>HurlVerbose<CR>", desc = "Run Api in verbose mode" },
      -- Run Hurl request in visual mode
      --{ "<leader>cu", ":HurlRunner<CR>", desc = "Hurl Runner", mode = "v" },
    },
  },
}
