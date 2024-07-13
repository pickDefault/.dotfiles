return {
  'smoka7/hydra.nvim',
  config = function()
    local hydra = require('hydra')

    hydra({
      name = "Manage windows",
      mode = "n",
      body = "<C-w>",
      heads = {
        { '+', function() vim.cmd.wincmd("2+") end, { exit = false } },
        { '_', function() vim.cmd.wincmd("2-") end, { exit = false } },
        { '<', function() vim.cmd.wincmd("3<") end, { exit = false } },
        { '>', function() vim.cmd.wincmd("3>") end, { exit = false } },
        { 'J', '<C-w>J',                            { exit = false } },
        { 'K', '<C-w>K',                            { exit = false } },
        { 'L', '<C-w>L',                            { exit = false } },
        { 'H', '<C-w>H',                            { exit = false } },
        { 'j', '<C-w>j',                            { exit = true } },
        { 'k', '<C-w>k',                            { exit = true } },
        { 'l', '<C-w>l',                            { exit = true } },
        { 'h', '<C-w>h',                            { exit = true } },
      }
    })

    hydra({
      name = "Navigate buffers",
      mode = "n",
      body = "<C-b>",
      heads = {
        { 'n', vim.cmd.bnext,     { exit = false, desc = "Next buffer" } },
        { 'p', vim.cmd.bprevious, { exit = false, desc = "Prev buffer" } },
        { 'q', vim.cmd.bdelete,   { exit = false, desc = "Delete buffer" } }
      }
    })

    hydra({
      name = "Fold options",
      mode = "n",
      body = "z",
      heads = {
        { 'a', 'za' },
        { 'A', 'zA' },
        { 'x', 'zx',                         { desc = "Undo folds" } },
        { 'X', 'zX',                         { desc = "Undo folds" } },
        { 'M', require('ufo').closeAllFolds, { desc = "Close all folds" } },
        { 'R', require("ufo").openAllFolds,  { desc = "Open all folds" } },
        { 'k', 'zk' },
        { 'j', 'zj' },
      }
    })

    local lyx_hint = [[

    ]]
    hydra({
      name = 'LaTeX Trig',
      hint = lyx_hint,
      config = {
        buffer = bufnr,
        color = 'pink',
        invoke_on_body = true,
        hint = {
          border = 'rounded'
        },
        on_enter = function()
          vim.cmd 'mkview'
          vim.cmd 'silent! %foldopen!'
          vim.bo.modifiable = false
        end,
        on_exit = function()
          local cursor_pos = vim.api.nvim_win_get_cursor(0)
          vim.cmd 'loadview'
          vim.api.nvim_win_set_cursor(0, cursor_pos)
          vim.cmd 'normal zv'
        end,
      },

      mode = { 'i' },
      body = '<M-t>',
      heads = {
        { 'c', '' }
      }
    })

    -- hydra({
    --   name = "Marks help",
    --   mode = "n",
    --   body = "<leader>mh", -- Marks Help
    --   heads = {},
    --   hint = [[
    -- mx              Set mark x
    -- m,              Set the next available alphabetical (lowercase) mark
    -- m;              Toggle the next avail
    -- dmx             Delete mark x
    -- dm-             Delete all marks on the current line
    -- dm<space>       Delete all marks in the current buffer
    -- m]              Move to next mark
    -- m[              Move to previous mark
    -- m:              Preview mark. This will prompt you for a specific mark to
    --                 preview; press <cr> to preview the next mark.
    --
    -- m[0-9]          Add a bookmark from bookmark group[0-9].
    -- dm[0-9]         Delete all bookmarks from bookmark group[0-9].
    -- m}              Move to the next bookmark having the same type as the bookmark under
    --                 the cursor. Works across buffers.
    -- m{              Move to the previous bookmark having the same type as the bookmark under
    --                 the cursor. Works across buffers.
    -- dm=             Delete the bookmark under the cursor.
    --   ]],
    --   config = {
    --     color = 'amaranth',
    --     invoke_on_body = true,
    --     hint = {
    --       border = 'rounded',
    --       position = 'middle',
    --     },
    --     on_enter = function()
    --       vim.cmd('mkview')
    --       vim.cmd('silent! %foldopen')
    --       vim.bo.modifiable = false
    --     end
    --   }
    --
    -- })

    local cmd = require('hydra.keymap-util').cmd

    local hint = [[
                 _f_: files       _m_: marks
   🭇🬭🬭🬭🬭🬭🬭🬭🬭🬼    _o_: old files   _g_: live grep
  🭉🭁🭠🭘    🭣🭕🭌🬾   _p_: projects    _/_: search in file
  🭅█ ▁     █🭐
  ██🬿      🭊██   _r_: resume
 🭋█🬝🮄🮄🮄🮄🮄🮄🮄🮄🬆█🭀  _h_: vim help    _c_: execute command
 🭤🭒🬺🬹🬱🬭🬭🬭🬭🬵🬹🬹🭝🭙  _k_: keymaps     _;_: commands history
                 _O_: options     _?_: search history
 ^
                 _<Enter>_: Telescope           _<Esc>_
]]

    hydra({
      name = 'Telescope',
      hint = hint,
      config = {
        color = 'teal',
        invoke_on_body = true,
        hint = {
          position = 'middle',
          border = 'rounded',
        },
      },
      mode = 'n',
      body = '<Leader>f?',
      heads = {
        { 'f',       cmd 'Telescope find_files' },
        { 'g',       cmd 'Telescope live_grep' },
        { 'o',       cmd 'Telescope oldfiles',                  { desc = 'recently opened files' } },
        { 'h',       cmd 'Telescope help_tags',                 { desc = 'vim help' } },
        { 'm',       cmd 'MarksListBuf',                        { desc = 'marks' } },
        { 'k',       cmd 'Telescope keymaps' },
        { 'O',       cmd 'Telescope vim_options' },
        { 'r',       cmd 'Telescope resume' },
        { 'p',       cmd 'Telescope projects',                  { desc = 'projects' } },
        { '/',       cmd 'Telescope current_buffer_fuzzy_find', { desc = 'search in file' } },
        { '?',       cmd 'Telescope search_history',            { desc = 'search history' } },
        { ';',       cmd 'Telescope command_history',           { desc = 'command-line history' } },
        { 'c',       cmd 'Telescope commands',                  { desc = 'execute command' } },
        -- { 'u',       cmd 'silent! %foldopen! | UndotreeToggle', { desc = 'undotree' } },
        { '<Enter>', cmd 'Telescope',                           { exit = true, desc = 'list all pickers' } },
        { '<Esc>',   nil,                                       { exit = true, nowait = true } },
      }
    })
  end
}
