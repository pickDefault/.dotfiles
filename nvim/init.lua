if not vim.g.vscode then
  --[[

  =====================================================================
  ==================== READ THIS BEFORE CONTINUING ====================
  =====================================================================

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a template for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you should start exploring, configuring and tinkering to
    explore Neovim!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example:
    - https://learnxinyminutes.com/docs/lua/


    And then you can explore or search through `:help lua-guide`
    - https://neovim.io/doc/user/lua-guide.html


  Kickstart Guide:

  I have left several `:help X` comments throughout the init.lua
  You should run that command and read that help section for more information.

  In addition, I have some `NOTE:` items throughout the file.
  These are for you, the reader to help understand what is happening. Feel free to delete
  them once you know what you're doing, but they should serve as a guide for when you
  are first encountering a few different constructs in your nvim config.

  I hope you enjoy your Neovim journey,
  - TJ

  P.S. You can delete this when you're done too. It's your config now :)
  --]]
  -- Set <space> as the leader key
  -- See `:help mapleader`
  --  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '

  -- Install package manager
  --    https://github.com/folke/lazy.nvim
  --    `:help lazy.nvim.txt` for more info
  local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      lazypath,
    }
  end
  vim.opt.rtp:prepend(lazypath)
  -- NOTE: Here is where you install your plugins.
  --  You can configure plugins using the `config` key.
  --
  --  You can also configure plugins after the setup call,
  --    as they will be available in your neovim runtime.
  require('lazy').setup({
    --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
    { import = 'plugins.themes' }, -- load first!
    { import = 'plugins' },
    { import = 'plugins.lsp' },
    -- { import = 'plugins.mini' }
  })

  -- [[ setting options ]]
  -- see `:help vim.o`
  -- note: you can change these options as you wish!

  -- set highlight on search
  vim.o.hlsearch = false

  -- make line numbers relative
  vim.wo.relativenumber = true

  -- make line numbers default
  vim.wo.number = true

  -- enable mouse mode
  vim.o.mouse = 'a'

  -- sync clipboard between os and neovim.
  --  remove this option if you want your os clipboard to remain independent.
  --  see `:help 'clipboard'`
  vim.o.clipboard = 'unnamedplus'

  -- enable break indent
  vim.o.breakindent = true

  -- save undo history
  vim.o.undofile = true

  -- Case-insensitive searching UNLESS \C or capital in search
  vim.o.ignorecase = true
  vim.o.smartcase = true

  -- Keep signcolumn on by default
  vim.wo.signcolumn = 'yes'

  -- Decrease update time
  vim.o.updatetime = 250
  vim.o.timeoutlen = 300

  -- Set completeopt to have a better completion experience
  vim.o.completeopt = 'menuone,noselect'

  -- NOTE: You should make sure your terminal supports this
  vim.o.termguicolors = true

  -- Personal settings

  -- No timeout for key sequences
  vim.o.timeout = false

  -- Format with = using conform.nvim
  vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

  -- Fold options
  -- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
  -- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  -- vim.opt.foldmethod = "expr"
  -- vim.opt.foldenable = true          -- Automatically fold when opeining file
  -- vim.opt.fillchars = { fold = " " } -- Filler for folded line

  -- Set theme
  local theme = require("theme").theme
  vim.cmd([[colorscheme ]] .. theme)
  -- Remove default themes from pickers/menus
  -- https://github.com/neovim/neovim/issues/15083#issuecomment-2101929393
  vim.cmd(
    [[set wildignore+=blue.vim,darkblue.vim,delek.vim,desert.vim,elflord.vim,evening.vim,industry.vim,koehler.vim,lunaperche.vim,morning.vim,murphy.vim,pablo.vim,peachpuff.vim,quiet.vim,retrobox.vim,ron.vim,shine.vim,slate.vim,sorbet.vim,torte.vim,wildcharm.vim,zaibatsu.vim,zellner.vim,habamax.vim]])

  vim.cmd([[set wildoptions+=fuzzy]])

  -- adds a command :A, just like :argedit but pressing Tab only completes filenames from the arglist
  vim.cmd([[command! -nargs=1 -complete=arglist A argedit <args> | argdedupe]])

  -- [[ Basic Keymaps ]]
  -- vim.cmd([[map <leader>\ :lua MiniFiles.open()<cr>]])
  vim.cmd([[map <leader>\ <CMD>Oil<CR>]])

  -- Keymaps for better default experience
  -- See `:help vim.keymap.set()`
  vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true }) -- zmochi note: disables space from moving forwards

  -- vim.keymap.set('n', '<C-q>', function()
  --   if #vim.fn.getbufinfo({ buflisted = 1 }) == 1 then
  --     vim.cmd.q()
  --   else
  --     vim.cmd.bd()
  --   end -- if
  -- end)  -- function
  -- vim.keymap.set('n', '<C-s>', vim.cmd.w)

  -- For some reason <C-f> scrolls the file by default in normal mode
  vim.keymap.set({ 'n', 'v' }, '<C-f>', '<Nop>')

  -- Moving between buffers
  vim.keymap.set({ 'n' }, ']b', '<CMD>bn<CR>', { desc = "Go to next buffer" })
  vim.keymap.set({ 'n' }, '[b', '<CMD>bp<CR>', { desc = "Go to prev buffer" })

  -- local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
  --
  -- -- vim way: ; goes to the direction you were moving.
  -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
  -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
  --
  -- -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
  -- vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
  -- vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
  -- vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
  -- vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)

  -- :vsplit to split window right/below instead of left/above
  vim.cmd([[set splitright]])
  vim.cmd([[set splitbelow]])
  -- Moving between windows

  -- Remap for dealing with word wrap
  vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { silent = true, expr = true })
  vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { silent = true, expr = true })

  vim.diagnostic.config({
    virtual_text = false
  })

  -- [[ Highlight on yank ]]
  -- See `:help vim.highlight.on_yank()`
  local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
  vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
      vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
  })


  -- Diagnostic keymaps

  -- Show line diagnostics automatically in hover window
  -- vim.o.updatetime = 250
  -- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

  local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
  vim.cmd.source(vimrc)

  -- The line beneath this is called `modeline`. See `:help modeline`
  -- vim: ts=2 sts=2 sw=2 et
else
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '
  vim.fn.VSCodeExtensionNotify('visible-range') -- https://github.com/vscode-neovim/vscode-neovim/pull/869 recommended on vscode-neovim from lightning-speed README.md

  local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      lazypath,
    }
  end
  vim.opt.rtp:prepend(lazypath)

  require('lazy').setup({
    -- Git related plugins
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',
    {
      -- Adds git related signs to the gutter, as well as utilities for managing changes
      'lewis6991/gitsigns.nvim',
      opts = {
        -- See `:help gitsigns.txt`
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
        on_attach = function(bufnr)
          vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk,
            { buffer = bufnr, desc = 'Preview git hunk' })

          -- don't override the built-in and fugitive keymaps
          local gs = package.loaded.gitsigns
          vim.keymap.set({ 'n', 'v' }, ']c', function()
            if vim.wo.diff then
              return ']c'
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return '<Ignore>'
          end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
          vim.keymap.set({ 'n', 'v' }, '[c', function()
            if vim.wo.diff then
              return '[c'
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return '<Ignore>'
          end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
        end,
      },
    },
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
    {
      "ggandor/lightspeed.nvim",
      event = "BufRead",
    },
    {
      'vscode-neovim/vscode-multi-cursor.nvim',
      event = 'VeryLazy',
      cond = not not vim.g.vscode,
    },
    {
      'stevearc/conform.nvim',
      opts = {},
    }
  })
  vim.o.clipboard = 'unnamedplus'



  require('vscode-multi-cursor').setup { -- Config is optional
    -- Whether to set default mappings
    default_mappings = false,
    -- If set to true, only multiple cursors will be created without multiple selections
    no_selection = false
  }

  --[[
  local cursors = require('vscode-multi-cursor')

  local k = vim.keymap.set
k({ 'n', 'x' }, 'nc', cursors.create_cursor, { expr = true, desc = 'Create cursor' })
k({ 'n' }, 'ncc', cursors.cancel, { desc = 'Cancel/Clear all cursors' })
k({ 'n', 'x' }, 'ni', cursors.start_left, { desc = 'Start cursors on the left' })
k({ 'n', 'x' }, 'nI', cursors.start_left_edge, { desc = 'Start cursors on the left edge' })
k({ 'n', 'x' }, 'na', cursors.start_right, { desc = 'Start cursors on the right' })
k({ 'n', 'x' }, 'nA', cursors.start_right, { desc = 'Start cursors on the right' })
k({ 'n' }, '[nc', cursors.prev_cursor, { desc = 'Goto prev cursor' })
k({ 'n' }, ']nc', cursors.next_cursor, { desc = 'Goto next cursor' }) ]]
  --[[ k({ 'n' }, 'ncs', cursors.flash_char, { expr = false, desc = 'Create cursor using flash' })
k({ 'n' }, 'ncw', cursors.flash_word, { expr = false, desc = 'Create selection using flash' }) ]]

  -- k({ 'n' }, '<C-m>', 'mciw*<Cmd>nohl<CR>', { remap = true })

  --[[ vim.keymap.set({ 'n', 'x', 'i' }, "<C-b>", function()
  require("vscode-multi-cursor").addSelectionToNextFindMatch()
end)

vim.keymap.set({ 'n', 'x', 'i' }, "<C-m>", function()
  require("vscode-multi-cursor").addSelectionToPreviousFindMatch()
end) ]]

  -- Import vim-style configuration:

  local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
  vim.cmd.source(vimrc)
end
