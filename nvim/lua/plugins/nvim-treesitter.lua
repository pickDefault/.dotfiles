return {
  -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',

  build = ':TSUpdate',
  event = { "BufReadPre", "BufNewFile" },

  config = function()
    -- no idea if its okay for defer_fn to be here instead of init.lua
    vim.defer_fn(function()
      require('nvim-treesitter.configs').setup {
        -- Add languages to be installed here that you want installed for treesitter
        ensure_installed = {
          'c',
          'cpp',
          'query',
          'lua',
          'python',
          'rust',
          'vimdoc',
          'vim',
          'bash',
          'java',
          'json',
          'markdown',
          'markdown_inline',
          'gitignore',
          'bash',
          'doxygen',
          'html',
          -- 'latex' -- controlled by vimtex
        },

        -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
        auto_install = false,

        highlight = { enable = true },

        indent = { enable = true },

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<M-Space>',
            node_incremental = '<M-Space>',
            scope_incremental = '<c-s>',
            node_decremental = '<BS>',
          },
        },
      }
    end, 0)
  end
}
