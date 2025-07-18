return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "leoluz/nvim-dap-go",
      'jay-babu/mason-nvim-dap.nvim',
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")

      require('mason-nvim-dap').setup {
        automatic_installation = true,
        handlers = {},
        ensure_installed = {
          'delve',
        },
      }

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      require('dapui').setup()
      require('dap-go').setup({
      })

      dap.adapters.go = function(callback, config)
        local handle
        local pid_or_err
        local port = 38697
        handle, pid_or_err = vim.loop.spawn("dlv", {
          args = { "dap", "-l", "127.0.0.1:" .. port },
          detached = true,
        }, function(code)
          handle:close()
          print("Delve exited with exit code: " .. code)
        end)
        -- Wait a bit for delve to start
        vim.defer_fn(function()
          callback({ type = "server", host = "127.0.0.1", port = port })
        end, 100)
      end

      dap.configurations.go = {
        {
          type = "go",
          name = "Debug",
          request = "launch",
          program = "${fileDirname}",
          cwd = "${workspaceFolder}",
        },
      }

      vim.keymap.set('n', '<F2>', dap.toggle_breakpoint)
      vim.keymap.set('n', '<F5>', dap.continue)
      vim.keymap.set('n', '<F10>', dap.step_over)
      vim.keymap.set('n', '<F11>', dap.step_into)
      vim.keymap.set('n', '<F12>', dap.step_out)
    end
  }
}
