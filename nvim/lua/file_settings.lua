vim.api.nvim_create_autocmd("FileType", {
  desc = "Set C (and related) files to have tabstop, shiftwidth of 4.",
  pattern = { "*.c", "*.h" },
  callback = function()
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
  end
})
