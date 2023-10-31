return {
{
  "kylechui/nvim-surround",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  config = function()
      require("nvim-surround").setup({
          -- Configuration here, or leave empty to use defaults
      })
  end
  },

--{
--  "m4xshen/autoclose.nvim",
--  config = function()
--      require("autoclose.nvim").setup({
--      keys = {
--      ["("] = { escape = false, close = true, pair = "()" },
--      ["["] = { escape = false, close = true, pair = "[]" },
--      ["{"] = { escape = false, close = true, pair = "{}" },
--
--      [">"] = { escape = true, close = false, pair = "<>" },
--      [")"] = { escape = true, close = false, pair = "()" },
--      ["]"] = { escape = true, close = false, pair = "[]" },
--      ["}"] = { escape = true, close = false, pair = "{}" },
--
--      ['"'] = { escape = true, close = true, pair = '""' },
--      ["'"] = { escape = true, close = true, pair = "''" },
--      ["`"] = { escape = true, close = true, pair = "``" },
--   },
--   options = {
--      disabled_filetypes = { "text" },
--      disable_when_touch = false,
--      touch_regex = "[%w(%[{]",
--      pair_spaces = false,
--      auto_indent = true,
--      disable_command_mode = false,
--   },
--      })
--  end
--},
   {
   "windwp/nvim-autopairs",
  -- Optional dependency
  dependencies = { 'hrsh7th/nvim-cmp' },
  config = function()
    require("nvim-autopairs").setup {}
    -- If you want to automatically add `(` after selecting a function or method
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done()
    )
  end,
   },
  {
  'stevearc/dressing.nvim',
  opts = {},
},
  {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = true,
  }
}
