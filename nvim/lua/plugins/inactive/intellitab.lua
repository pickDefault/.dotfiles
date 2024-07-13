return {
  'pta2002/intellitab.nvim',
  config = function()
    vim.keymap.set('i', '<Tab>', require("intellitab").indent)
  end

}
