return {
  -- Add indentation guides even on blank lines -- zmochi note: maybe remove?
  'lukas-reineke/indent-blankline.nvim',
  -- Enable `lukas-reineke/indent-blankline.nvim`
  -- See `:help ibl`
  main = 'ibl',
  opts = {},
  config = function ()

    local highlight = {
      -- "CursorColumn",
      "Whitespace",
    }
    require("ibl").setup {
      indent = { highlight = highlight, char = "" },
      whitespace = {
        highlight = highlight,
        remove_blankline_trail = false,
      },
      scope = { enabled = false },
    }
  end
}
