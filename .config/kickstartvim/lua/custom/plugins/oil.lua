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
          ['<CR>'] = 'actions.select', -- Default
          ['<C-v>'] = 'actions.select_vsplit', -- Open in vertical split
          ['<C-x>'] = 'actions.select_split', -- Open in horizontal split
          ['<C-t>'] = 'actions.select_tab', -- Open in new tab
        },
      }
    end,
  },
  {
    'chrishrb/gx.nvim',
    keys = { { 'gx', '<cmd>Browse<cr>', mode = { 'n', 'x' } } },
    cmd = { 'Browse' },
    init = function()
      vim.g.netrw_nogx = 1 -- disable netrw gx
    end,
    config = true, -- default settings
    submodules = false, -- not needed, submodules are required only for tests
  },
}
