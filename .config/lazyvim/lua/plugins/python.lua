return {
  {

    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "pyright",
        "debugpy",
      },
    },
  },
  {
    "nvim-neotest/neotest-python",
  },
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      require("dap-python").setup(LazyVim.get_pkg_path("debugpy", "/venv/bin/python"))
    end,
  },
}
