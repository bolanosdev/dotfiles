return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = false },
    input = { enabled = true },
    notifier = { enabled = true },
    picker = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    terminal = { enabled = true, { win = { style = "terminal" } } },
    styles = {
      notification = {
        -- wo = { wrap = true } -- Wrap notifications
      },
    },
  },
  keys = {
    -- [S][E]arch
    { '<leader>sed',      function() require("snacks.picker").diagnostics() end,     desc = '[D]iagnostics' },
    { '<leader>sek',      function() require("snacks.picker").keymaps() end,         desc = '[K]eymaps' },
    { '<leader>sef',      function() require("snacks.picker").smart() end,           desc = '[F]iles history' },
    { '<leader>seh',      function() require("snacks.picker").help() end,            desc = '[H]elp' },
    { '<leader>seH',      function() require("snacks.picker").highlights() end,      desc = '[H]ighlights' },
    -- { '<leader>sem',      function() require("snacks.picker").marks() end,           desc = '[M]arks' }, // not sure how useful vs harpoon
    { '<leader>sem',      function() require("snacks.picker").man() end,             desc = '[M]anual' },
    { '<leader>sea',      function() require("snacks.picker").lazy() end,            desc = 'L[A]zy' },
    -- { '<leader>ses',      function() require("snacks.picker").resume() end,          desc = 'Re[S]ume' },
    { '<leader>seq',      function() require("snacks.picker").qflist() end,          desc = '[Q]uickfix list' },
    { '<leader>seu',      function() require("snacks.picker").undo() end,            desc = '[U]ndo' },

    { '<leader>se/',      function() require("snacks.picker").search_history() end,  desc = 'Search history [/]' }, -- searches with /

    { '<leader>seg',      function() require("snacks.picker").grep() end,            desc = '[G]rep' },
    { '<leader>sel',      function() require("snacks.picker").lines() end,           desc = '[G]rep [L]lines' },
    { '<leader>seb',      function() require("snacks.picker").grep_buffers() end,    desc = '[G]rep [B]uffer' },

    { '<leader>sep',      function() require("snacks.picker").projects() end,        desc = '[P]rojects' },
    { '<leader>ser',      function() require("snacks.picker").recent() end,          desc = '[R]ecent' },
    { "<leader>sec",      function() require("snacks.picker").command_history() end, desc = "[C]ommand history" },
    { "<leader>sen",      function() require("snacks.picker").notifications() end,   desc = "[N]otification history" },
    { "<leader>see",      function() require("snacks.explorer")() end,               desc = "File [E]xplorer" },
    { '<leader><leader>', function() require("snacks.picker").buffers() end,         desc = '[B]uffers history' },

    -- [G]it
    { '<leader>gb',       function() require("snacks.picker").git_branches() end,    desc = '[B]ranches' },
    { '<leader>gl',       function() require("snacks.picker").git_log() end,         desc = '[L]og' },
    { '<leader>gL',       function() require("snacks.picker").git_log_line() end,    desc = '[L]og line history' },
    { '<leader>gf',       function() require("snacks.picker").git_log_file() end,    desc = '[f]ile history' },
    { '<leader>gs',       function() require("snacks.picker").git_status() end,      desc = '[S]tatus' },
    { '<leader>gS',       function() require("snacks.picker").git_stash() end,       desc = '[S]tash' },
    { '<leader>gd',       function() require("snacks.picker").git_diff() end,        desc = '[D]iff hunks' },

    -- LSP


  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        local snacks_debug = require('snacks.debug')
        local snacks_toggle = require('snacks.toggle')

        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          snacks_debug.inspect(...)
        end
        _G.bt = function()
          snacks_debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        snacks_toggle.option("spell", { name = "Spelling" }):map("<leader>tos")
        snacks_toggle.option("wrap", { name = "Wrap" }):map("<leader>tow")
        snacks_toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>toL")
        snacks_toggle.diagnostics():map("<leader>tod")
        snacks_toggle.line_number():map("<leader>tol")
        snacks_toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map(
          "<leader>toC")
        snacks_toggle.treesitter():map("<leader>toT")
        snacks_toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>tob")
        snacks_toggle.inlay_hints():map("<leader>toh")
        snacks_toggle.indent():map("<leader>tog")
        snacks_toggle.dim():map("<leader>toD")

        vim.keymap.set("n", "<leader>toc", function()
          local buf = vim.api.nvim_get_current_buf()
          local current = vim.b[buf].conform_disable or false
          vim.b[buf].conform_disable = not current
          if vim.b[buf].conform_disable then
            vim.notify("Conform: formatting disabled for this buffer", vim.log.levels.INFO)
          else
            vim.notify("Conform: formatting enabled for this buffer", vim.log.levels.INFO)
          end
        end, { desc = "[C]onform" })
      end,
    })
  end,
}
