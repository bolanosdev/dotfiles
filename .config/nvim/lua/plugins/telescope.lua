return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons',            enabled = vim.g.have_nerd_font },
  },
  config = function()
    require('telescope').setup {
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>seh', builtin.help_tags, { desc = '[H]elp' })
    vim.keymap.set('n', '<leader>sek', builtin.keymaps, { desc = '[K]eymaps' })
    vim.keymap.set('n', '<leader>sef', builtin.find_files, { desc = ' [F]iles' })
    vim.keymap.set('n', '<leader>ses', builtin.builtin, { desc = '[S]elect Telescope' })
    vim.keymap.set('n', '<leader>sew', builtin.grep_string, { desc = '[W]ord' })
    vim.keymap.set('n', '<leader>seg', builtin.live_grep, { desc = '[G]rep' })
    vim.keymap.set('n', '<leader>sed', builtin.diagnostics, { desc = '[D]iagnostics' })
    vim.keymap.set('n', '<leader>ser', builtin.resume, { desc = '[R]esume' })
    vim.keymap.set('n', '<leader>se.', builtin.oldfiles, { desc = 'Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Existing buffers' })

    vim.keymap.set('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = 'current buffer' })

    vim.keymap.set('n', '<leader>se/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch in Open Files' })

    vim.keymap.set('n', '<leader>sen', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
  end,
}
