return {
  -- Autocompletion
  'hrsh7th/nvim-cmp',
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    "L3MON4D3/LuaSnip",

    'saadparwaiz1/cmp_luasnip',

    -- Adds LSP completion capabilities
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',

    -- zmochi: Display function signature as you're writing
    { 'hrsh7th/cmp-nvim-lsp-signature-help' },
  },

  config = function()
    -- [[ Configure nvim-cmp ]]
    -- See `:help cmp`
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.config.setup {}

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
        sources = {
          {
            name = 'buffer',
            option = {
              keyword_length = 3,

            },
          },
          {
            name = 'path',
            option = {
              trailing_slash = false,
            }
          }
        }
      },
      mapping = cmp.mapping.preset.insert {
        -- ['<C-n>'] = cmp.mapping.select_next_item(),
        -- ['<C-p>'] = cmp.mapping.select_prev_item(),
        -- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
        -- Focuses the hover window that appears when you start writing a keyword
        ['<C-k>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            vim.cmd.stopinsert()
            vim.lsp.buf.hover()
            vim.defer_fn(function() vim.cmd.wincmd("w") end, 100)
          else
            fallback()
          end               -- if cmp.visible()...
        end, { 'i', 's' }), -- function(fallback)
        -- ['<C-CR>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<C-n>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { 'i', 's' }), -- 's' for SELECT mode?
        ['<C-p>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { 'i', 's' }),

        ['<Tab>'] = cmp.mapping(function(fallback)
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
      enabled = function()
        -- disable completion in comments
        local context = require 'cmp.config.context'
        -- keep command mode completion enabled when cursor is in a comment
        if vim.api.nvim_get_mode().mode == 'c' then
          return true
        else
          return not context.in_treesitter_capture("comment")
              and not context.in_syntax_group("Comment")
        end
      end,
      sources = {
        { name = 'nvim_lsp' },
        -- zmochi: Display function signature as you're writing
        { name = 'nvim_lsp_signature_help' }, -- https://github.com/hrsh7th/cmp-nvim-lsp-signature-help
        { name = 'luasnip' },
      },
    }
  end
}
