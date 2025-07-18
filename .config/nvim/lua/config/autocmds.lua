vim.api.nvim_create_user_command("HarpoonOpenAll", function()
  local harpoon = require("harpoon")
  local list = harpoon:list()

  for i = 1, list:length() do
    local item = list:get(i)
    if item and item.value then
      vim.cmd("badd " .. vim.fn.fnameescape(item.value))
    end
  end

  -- optionally jump to first mark
  local first = list:get(1)
  if first and first.value then
    vim.cmd("buffer " .. vim.fn.fnameescape(first.value))
  end
end, { desc = "Load all harpoon marks as buffers and jump to first" })
