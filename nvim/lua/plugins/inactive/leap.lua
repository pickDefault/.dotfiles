return {
  'ggandor/leap.nvim',
  dependencies = {
    {
      'ggandor/flit.nvim',
      config = function()
        require('flit').setup()
      end
    },
    'tpope/vim-repeat'
  },
  config = function()
    local leap = require('leap')
    leap.create_default_mappings()
    vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap)')
    vim.keymap.set({ 'n', 'x', 'o' }, 'gs', '<Plug>(leap-from-window)')
    leap.opts.labels = 'abcdefghijklmnopqrstuvwxyz'
    leap.opts.case_sensitive = false
  end
}
