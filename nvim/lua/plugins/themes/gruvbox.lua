return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    require('gruvbox').setup({
      terminal_colors = true,
      undercurl = true,

    })
    vim.o.background = "dark"
  end
}
