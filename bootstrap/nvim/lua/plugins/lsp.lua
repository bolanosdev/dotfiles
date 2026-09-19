local servers = {
  gopls = {},
  pyright = {},
  ts_ls = {},
  lua_ls = {},
}

return {
  {
    "hrsh7th/cmp-nvim-lsp"
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = vim.tbl_keys(servers or {})
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local builtin = require 'telescope.builtin'
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(event)
          -- TODO: add missing lsp actions
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
          vim.keymap.set('n', 'gtd', builtin.lsp_definitions, {})
          vim.keymap.set('n', 'gtn', vim.lsp.buf.rename, {})
          vim.keymap.set('n', 'gti', vim.lsp.buf.implementation, {})
          vim.keymap.set('n', 'gta', vim.lsp.buf.code_action, {})
        end
      })

      local lspconfig = require("lspconfig")
      -- TODO: refactor this to use local servers
      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        settings = {
          typescript = {
            tsserver = {
              maxTsServerMemory = 8192
            },
          },
        },
      })
      lspconfig.gopls.setup({
        capabilities = capabilities
      })
    end
  }
}
