return {
  "L3MON4D3/LuaSnip",
  -- follow latest release.
  version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  -- install jsregexp (optional!).
  build = "make install_jsregexp",
  dependencies = {
    {
      -- Adds a number of user-friendly snippets
      -- 'rafamadriz/friendly-snippets',
    }
  },
  config = function()
  end
}
