-- Fuzzy Finder (files, lsp, etc)
return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },

  config = function()
    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    local actions = require('telescope.actions')

    require('telescope').setup {
      pickers = {
        colorscheme = {
          enable_preview = true,
        }
      },
      defaults = {
        layout_config = {
          horizontal = {
            preview_cutoff = 5,
          },
        },
        mappings = {
          n = {
            ['<C-d>'] = actions.delete_buffer,
            ['<C-Space>'] = actions.toggle_selection,
          },
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = actions.delete_buffer,
            ['<C-s>'] = actions.file_split,
            ['<C-v>'] = actions.file_vsplit,
            ['<C-Space>'] = actions.toggle_selection,
          },
        },
      },
    }

    -- -- Enable telescope fzf native, if installed
    pcall(require('telescope').load_extension, 'fzf')
    --
    -- -- See `:help telescope.builtin`
    vim.keymap.set('n', '<leader>of', function()
      require('telescope.builtin').oldfiles({
        previewer = false
      })
    end, { desc = 'Search [O]ld [F]iles' })

    vim.keymap.set('n', '<leader>b', function()
      require('telescope.builtin').buffers({
        previewer = false
      })
    end, { desc = '[ ] Find existing buffers' })

    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })
    --
    -- vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
    vim.keymap.set('n', '<leader>sf', function()
      require('telescope.builtin').find_files({
        previewer = false
      })
    end, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sh', function()
      require('telescope.builtin').help_tags({
        previewer = false
      })
    end, { desc = '[S]earch [H]elp' })

    vim.keymap.set('n', '<leader>ch', function()
      require('telescope.builtin').command_history({})
    end, { desc = '[C]ommand [H]istory' })
    vim.keymap.set('n', '<leader>sg', function()
      require('telescope.builtin').grep_string({
        path_display = { 'smart' },
        only_sort_text = true,
        word_match = "-w",
        search = '',
      })
    end, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sw', require('telescope.builtin').live_grep, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sa', require('telescope.builtin').builtin, { desc = '[S]earch Telescope [A]ctions' })
    vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>rs', require('telescope.builtin').resume, { desc = 'Search [R]esume' })
    vim.keymap.set('n', '<leader>ss', require('telescope.builtin').lsp_dynamic_workspace_symbols,
      { desc = '[S]earch [S]ymbols' })
    vim.keymap.set('n', '<leader>sm',
      function() require('telescope.builtin').man_pages({ sections = { '1', '2', '3' } }) end,
      { desc = '[S]earch [M]anpages' })
  end
}
