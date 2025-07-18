return {
  {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('oil').setup {
        default_file_explorer = true,
        keymaps = {
          ['<CR>'] = 'actions.select',
          ['<C-v>'] = 'actions.select_vsplit',
          ['<C-x>'] = 'actions.select_split',
          ['<C-t>'] = 'actions.select_tab',
        },
      }
    end,
  },
  {
    'chrishrb/gx.nvim',
    keys = { { 'gx', '<cmd>Browse<cr>', mode = { 'n', 'x' } } },
    cmd = { 'Browse' },
    init = function()
      vim.g.netrw_nogx = 1
    end,
    config = true,
    submodules = false,
  },
}
