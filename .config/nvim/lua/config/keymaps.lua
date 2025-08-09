-- ctrl -s to save
vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>', { desc = 'Save buffer' })
vim.keymap.set('n', '<C-s>', ':w<CR>', { desc = 'Save buffer' })
vim.keymap.set('n', '<C-q>', ':q<CR>', { desc = 'quit buffer' })

-- which-key maps
vim.keymap.set('n', '<leader>d', '', { desc = '[D]iagnostics' })
vim.keymap.set('n', '<leader>f', '', { desc = '[F]ormat (conform)' })
vim.keymap.set('n', '<leader>g', '', { desc = '[G]it' })
vim.keymap.set('n', '<leader>o', '', { desc = '[O]il' })

vim.keymap.set('n', '<leader>t', '', { desc = '[T][E]st/[T][o]ggle/[T]est [H]url' })
vim.keymap.set('n', '<leader>te', '', { desc = '[T][e]st' })
vim.keymap.set('n', '<leader>to', '', { desc = '[T][o]ggle' })
vim.keymap.set('n', '<leader>th', '', { desc = '[T]est [H]url' })

vim.keymap.set('n', '<leader>s', '', { desc = '[S][E]arch/[S][P]lit' })
vim.keymap.set('n', '<leader>se', '', { desc = '[S][E]arch' })
vim.keymap.set('n', '<leader>sp', '', { desc = '[S][P]lit' })

-- oil
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open buffer [P]arent' })

vim.keymap.set('n', '<leader>of', function()
  local entry = require("oil").get_cursor_entry()
  vim.cmd('Oil --float ' .. vim.fn.fnameescape(entry.name))
end, { desc = '[O]pen floating file/folder ', buffer = true })

vim.keymap.set("n", "<leader>og", function()
  local path = vim.fn.input("Path: ", vim.fn.getcwd(), "dir")
  if path ~= "" then
    vim.cmd("Oil " .. path)
  end
end, { desc = "[G]o to path" })


-- window management
vim.keymap.set('n', '<leader>sph', ':split<CR>', { desc = '[S][P]lit [H]orizontal' })
vim.keymap.set('n', '<leader>spv', ':vsplit<CR>', { desc = '[S][P]lit [V]ertical' })
vim.keymap.set('n', '<C-Left>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-Right>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-Down>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-Up>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- diagnostics
vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = '[E]rror message' })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = '[Q]uickfix list' })
vim.keymap.set('n', '<leader>dp', function() vim.diagnostic.jump { forward = true, count = 1 } end,
  { desc = '[P]revious message' })
vim.keymap.set('n', '<leader>dn', function() vim.diagnostic.jump { forward = false, count = 1 } end,
  { desc = '[N]ext message' })
