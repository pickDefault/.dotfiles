local get_selection_count = function()
  local line_start = vim.fn.line("v")
  local line_end = vim.fn.line(".")
  local col_start = vim.fn.col("v")
  local col_end = vim.fn.col(".")
  local line_count = line_start <= line_end and line_end - line_start + 1 or line_start - line_end + 1
  local col_count = col_start <= col_end and col_end - col_start + 1 or col_start - col_end + 1
  return line_count .. ":" .. col_count
end

return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  -- See `:help lualine.txt`
  opts = {
    options = {
      icons_enabled = true,
      theme = require("theme").lualine_theme,
      component_separators = '|',
      section_separators = '',
      always_divide_middle = true,
    },
  },
  config = function()
    -- local hydra = require('hydra.statusline')
    require('lualine').setup {
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {
          {
            function() return '[' .. vim.fn.bufnr() .. ']' end, separator = '',
          },
          {
            'filename', padding = { left = 0, right = 1 },
          }
        },
        lualine_c = { 'branch', 'diff', 'diagnostics' },
        lualine_x = {},
        lualine_y = { function()
          return vim.fn.getcwd()
        end },
        lualine_z = {
          { "location",
            cond = function()
              return vim.fn.mode():find("[Vv]") == nil
            end
          },
          {
            get_selection_count,
            cond = function()
              return vim.fn.mode():find("[Vv]") ~= nil
            end,
          },
        },
      }
    }
  end
}
