return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",     
  event = { "BufReadPost", "BufNewFile" }, 
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "lua", "vim", "vimdoc",  "json", "typescript", "typescript", "go", "python" },
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      }
    })
  end
}
