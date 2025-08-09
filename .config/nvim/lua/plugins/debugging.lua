return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "leoluz/nvim-dap-go",
      "nvim-neotest/nvim-nio",
      'jay-babu/mason-nvim-dap.nvim',
      "mxsdev/nvim-dap-vscode-js",
      "microsoft/vscode-js-debug"
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      local dap_vscode = require("dap-vscode-js")
      local debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"

      dapui.setup()

      vim.keymap.set('n', '<F2>', function() dap.toggle_breakpoint() end)
      vim.keymap.set('n', '<F5>', function() dap.continue() end)
      vim.keymap.set('n', '<F10>', function() dap.step_over() end)
      vim.keymap.set('n', '<F11>', function() dap.step_into() end)
      vim.keymap.set('n', '<F12>', function() dap.step_out() end)

      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

      require('dap-go').setup({})
      dap_vscode.setup({
        debugger_path = debugger_path,
        adapters = { "pwa-node" },
      })

      require('mason-nvim-dap').setup {
        automatic_installation = true,
        handlers = {},
        ensure_installed = {
          'delve',
        },
      }

      dap.adapters.go = function(callback)
        local handle
        local port = 38697
        handle, _ = vim.loop.spawn("dlv", {
          args = { "dap", "-l", "127.0.0.1:" .. port },
          detached = true,
        }, function(code)
          handle:close()
          print("Delve exited with exit code: " .. code)
        end)
        vim.defer_fn(function()
          callback({ type = "server", host = "127.0.0.1", port = port })
        end, 100)
      end

      -- for dapDebugServer.js to be available we need lazy to install vscode-js-debug into
      -- the debugger path and execute the following commands
      -- cd ~/.local/share/nvim/lazy/vscode-js-debug
      -- npm install --legacy-peer-deps
      -- npx gulp dapDebugServer
      -- mv dist out

      require("dap").adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = { debugger_path .. "/out/src/dapDebugServer.js", "${port}" },
        }
      }

      dap.configurations.go = {
        {
          type = "go",
          name = "Debug",
          request = "launch",
          program = "${fileDirname}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "go",
          name = "Debug with arguments",
          request = "launch",
          program = "${file}",
          args = function()
            local input = vim.fn.input('Args (space separated): ')
            return vim.fn.split(input, " ", true)
          end,
        }
      }

      dap.configurations.javascript = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        }
      }

      dap.configurations.typescript = dap.configurations.javascript
    end
  }
}
