return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  opts = {},
  config = function()
    require('persistence').setup {
      options = { 'buffers', 'curdir', 'tabpages', 'winsize' },
    }
  end,
  keys = {
    {
      '<leader>p',
      function()
      end,
      desc = 'Persistence',
    },
    {
      '<leader>pr',
      function()
        require('persistence').load()
      end,
      desc = 'Restore Session',
    },
    {
      '<leader>pd',
      function()
        require('persistence').stop()
      end,
      desc = "Delete Session",
    },
  },
}

