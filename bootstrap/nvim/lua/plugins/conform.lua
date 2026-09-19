return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>fb',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat [B]uffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- local disable_filetypes = { c = true, cpp = true }
      local disable_filetypes = {}

      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      end

      if vim.b[bufnr].conform_disable then
        return nil
      end

      return {
        timeout_ms = 500,
        lsp_format = 'fallback',
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      go = { 'goimports', 'gofmt' },
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
    },
  },
}
