return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  dependencies = {
    'nvim-treesitter/nvim-treesitter'
  },
  config = function()
    require("nvim-treesitter.configs").setup({

      textobjects = {
        -- lsp_interop = {
        --   enable                = true,
        --   border                = 'none',
        --   floating_preview_opts = {},
        --   peek_definition_code  = {
        --     ["<leader>df"] = "@function.outer",
        --   }
        -- },
        select = {
          enable = true,

          lookahead = true,

          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
            ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
            ["=h"] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
            ["=l"] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

            ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
            ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

            ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
            ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

            ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
            ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

            ["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
            ["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

            ["am"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
            ["im"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },

            ["aC"] = { query = "@class.outer", desc = "Select outer part of a class" },
            ["iC"] = { query = "@class.inner", desc = "Select inner part of a class" },

            ["ac"] = { query = "@comment.outer", desc = "Select outer part of a comment" },
            ["ic"] = { query = "@comment.inner", desc = "Select inner part of a comment" },
          },
          include_surrounding_whitespace = true,
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>sn"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>sp"] = "@parameter.inner",
          }
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]f"] = { query = "@call.outer", desc = "Next function call start" },
            ["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
            ["]c"] = { query = "@class.outer", desc = "Next class start" },
            ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
            ["]l"] = { query = "@loop.outer", desc = "Next loop start" },
            ["]a"] = { query = "@parameter.inner", desc = "Next parameter start" },

            -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
            -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
            ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
            ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
          },
          goto_next_end = {
            ["]F"] = { query = "@call.outer", desc = "Next function call end" },
            ["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
            ["]C"] = { query = "@class.outer", desc = "Next class end" },
            ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
            ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
            ["]A"] = { query = "@parameter.inner", desc = "Next parameter end" },
          },
          goto_previous_start = {
            ["[f"] = { query = "@call.outer", desc = "Prev function call start" },
            ["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
            ["[c"] = { query = "@class.outer", desc = "Prev class start" },
            ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
            ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
            ["[a"] = { query = "@parameter.inner", desc = "Prev parameter start" },
          },
          goto_previous_end = {
            ["[F"] = { query = "@call.outer", desc = "Prev function call end" },
            ["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
            ["[C"] = { query = "@class.outer", desc = "Prev class end" },
            ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
            ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
            ["[A"] = { query = "@parameter.inner", desc = "Prev parameter end" },
          },
        },
      }
    })
  end,

}
