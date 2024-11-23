return {

  "lervag/vimtex",
  dependencies = {
    "evesdropper/luasnip-latex-snippets.nvim",
    "L3MON4D3/LuaSnip",
  },
  lazy = false, -- we don't want to lazy load VimTeX
  config = function()
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local f = ls.function_node
    local extras = require("luasnip.extras")
    local fmt = require("luasnip.extras.fmt").fmt
    local fmta = require("luasnip.extras.fmt").fmta
    local tex = require("luasnip-latex-snippets.luasnippets.tex.utils.conditions")
    local rep = extras.rep
    local c = ls.choice_node
    local sn = ls.snippet_node
    local scaffolding = require("luasnip-latex-snippets.luasnippets.tex.utils.scaffolding")
    local autosnippet = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })
    local d = ls.dynamic_node

    local text = {}

    local function store_selection_keys()
      text = {}
      vim.api.nvim_feedkeys(vim.keycode(require("luasnip").select_keys .. "<Esc>l"), "nix", false)

      local LS_SELECT_RAW, LS_SELECT_DEDENT, TM_SELECTED_TEXT = require("luasnip.util.select").retrieve()
      for _, str in ipairs(TM_SELECTED_TEXT) do
        table.insert(text, str)
      end
    end

    local function get_selection_keys(args, snip)
      local text_copy = text
      text = {}
      return text_copy
    end

    local brackets = {
      a = { "\\langle", "\\rangle" },
      A = { "Angle", "Angle" },
      b = { "brack", "brack" },
      B = { "Brack", "Brack" },
      c = { "brace", "brace" },
      m = { "|", "|" },
      p = { "(", ")" },
    }

    local snip_table = {
      {
        key = "<M-*>",
        snippet = s("*", {
          t('\\cdot')
        })
      },

      {
        key = "<M-f>",
        snippet = s("\\frac", fmt(
          [[
        \frac{{{}}}{{{}}}
        ]],
          { i(1), i(2) }))
      },

      {
        key = "_",
        snippet = s("_", fmta(
          [[
          _{<>}
        ]], { i(1) })
        )
      },
      {
        key = "^",
        snippet = s("^", fmta(
          [[
          ^{<>}
          ]]
          , { i(1) }))
      },
      {
        -- Capital V here actually means shift + v
        key = "<M-V>",
        snippet = s("\\vec",
          fmta([[\vec{<><>}<>]],
            { i(1), f(get_selection_keys), i(2) })
        ),
        actions_before = store_selection_keys,

        mode = { "x", "i" },
      },

      {
        key = "<M-H>",
        snippet = s(
          "\\hat",
          fmta([[\hat{<><>}<>]],
            { i(1), f(get_selection_keys), i(2) })
        ),
        actions_before = store_selection_keys,

        mode = { "x", "i" }
      },

      {
        key = nil,
        snippet = s(
          "\\binom",
          fmta([[\binom{<>}{<>}<>]], { i(1), i(2), i(3) })
        ),
      },

      -- DELIMITERS
      -- {
      --   key = "<M-(>",
      --   snippet = s(
      --     "lr",
      --     fmta([[\left <> <> \right <><>]],
      --       { i(1), i(2), rep(1), i(3) })
      --   )
      -- },
      {
        key = "<M-I>",
        snippet = s(
          "italicize",
          fmta([[
          \textit{<><>}<>
          ]],
            { i(1), f(get_selection_keys), i(2) })
        ),
        actions_before = store_selection_keys,
        mode = { "x", "i" }
      },
      {
        key = "<M-B>",
        snippet = s(
          "italicize",
          fmta([[
          \textbf{<><>}<>
          ]],
            { i(1), f(get_selection_keys), i(2) })
        ),
        actions_before = store_selection_keys,
        mode = { "x", "i" }
      },

      {
        key = nil,
        snippet = autosnippet(
          { trig = "lr([aAbBcmp])", name = "left right", dscr = "left right delimiters", regTrig = true, hidden = true },
          fmta(
            [[
    \left<> <> \right<><>
    ]],
            { f(function(_, snip)
              local cap = snip.captures[1] or 'p'
              return brackets[cap][1]
            end),
              d(1, scaffolding.get_visual),
              f(function(_, snip)
                local cap = snip.captures[1] or 'p'
                return brackets[cap][2]
              end),
              i(0) }),
          { condition = tex.in_math, show_condition = tex.in_math }),
      },

      -- ENVIRONMENTS
      {
        key = nil, -- regular snippet
        snippet = s({ trig = 'beg', name = 'begin/end', dscr = 'begin/end environment (generic)' },
          fmta([[
            \begin{<>}
            <>
            \end{<>}
            ]],
            { i(1), i(0), rep(1) }
          ), { condition = tex.in_text, show_condition = tex.in_text }),
      },

      {
        key = nil,
        snippet = s({ trig = "itemize", name = "itemize", dscr = "bullet points (itemize)" },
          fmta([[
              \begin{itemize}
              \item <>
              \end{itemize}
              ]],
            { c(1, { i(0), sn(nil, fmta(
              [[
        [<>] <>
        ]],
              { i(1), i(0) })) })
            }
          ),
          { condition = tex.in_text, show_condition = tex.in_text }),
      },

      {
        key = nil,
        snippet = s({ trig = "enumerate", name = "enumerate", dscr = "numbered list (enumerate)" },
          fmta([[
              \begin{enumerate}<>
              \item <>
              \end{enumerate}
              ]],
            { c(1, { t(""), sn(nil, fmta(
              [[
              [label=<>]
              ]],
              { c(1, { t("(\\alph*)"), t("(\\roman*)"), i(1) }) })) }),
              c(2, { i(0), sn(nil, fmta(
                [[
              [<>] <>
              ]],
                { i(1), i(0) })) })
            }
          ),
          { condition = tex.in_text, show_condition = tex.in_text }),
      },
      {
        key = "<M-m>",
        snippet = s(
          "mi",
          fmta([[
            $ <><> $<>
          ]],
            { i(1), f(get_selection_keys), i(2) })
        ),
        actions_before = store_selection_keys,
        mode = { "i", "x" }
      },
      {
        key = "<M-M>",
        snippet = s(
          "md",
          fmta([[
            \begin{equation}
            <><>
            \end{equation}
            <>
          ]],
            { i(1), f(get_selection_keys), i(2) })
        ),
        actions_before = store_selection_keys,
        mode = { "i", "x" }
      },
    }

    local snippet_table = {}

    for i, snip in ipairs(snip_table) do
      table.insert(snippet_table, snip.snippet)
    end

    ls.add_snippets("tex", snippet_table)

    local keymapsAuGroup = vim.api.nvim_create_augroup('VimtexKeymaps', { clear = true })
    vim.api.nvim_create_autocmd('BufEnter', {
      pattern = '*.tex',
      group = keymapsAuGroup,
      callback = function(opts)
        -- define mappings for Vimtex

        for i, snip in ipairs(snip_table) do
          if snip.key == nil then
            goto continue
          end
          if snip.mode == nil then
            snip.mode = { 'i' }
          end

          if snip.actions_before == nil then
            snip.actions_before = function() end
          end

          vim.keymap.set(snip.mode, snip.key, function()
            if string.lower(vim.fn.mode()) == 'v' then
              snip.actions_before()
            end
            ls.snip_expand(snip.snippet)
          end, { buffer = opts.buf })
          ::continue::
        end -- for i, snip
      end   -- callback
    })
  end,      -- vimtex config
  init = function()
    -- VimTeX configuration goes here
    require("luasnip").config.setup({
      enable_autosnippets = true
    })

    -- require("luasnip-latex-snippets").setup()

    vim.cmd([[
      " This is necessary for VimTeX to load properly. The "indent" is optional.
      " Note that most plugin managers will do this automatically.
      " note: probably done automatically by lazy so commenting out
      " filetype plugin indent on

      " This enables Vim's and neovim's syntax-related features. Without this, some
      " VimTeX features will not work (see ":help vimtex-requirements" for more
      " info).
      syntax enable

      " Viewer options: One may configure the viewer either by specifying a built-in
      " viewer method:
      let g:vimtex_view_method = 'sioyek'

      " Or with a generic interface:
      " let g:vimtex_view_general_viewer = 'okular'
      " let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

      " Most VimTeX mappings rely on localleader and this can be changed with the
      " following line. The default is usually fine and is the symbol "\".
      let maplocalleader = " "

      let g:vimtex_fold_enabled = 1


      set conceallevel=2
    ]])
  end
}
