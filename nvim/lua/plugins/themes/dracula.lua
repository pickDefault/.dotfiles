return {
  "Mofiqul/dracula.nvim",
  config = function()
    require("dracula").setup({
      -- show the '~' characters after the end of buffers
      show_end_of_buffer = false, -- default false
      -- use transparent background
      transparent_bg = false,     -- default false
      -- set custom lualine background color
      lualine_bg_color = nil,     -- default nil
      -- set italic comment
      italic_comment = false,     -- default false
      -- overrides the default highlights with table see `:h synIDattr`
      overrides = {},
      -- You can use overrides as table like this
      -- overrides = {
      --   NonText = { fg = "white" }, -- set NonText fg to white
      --   NvimTreeIndentMarker = { link = "NonText" }, -- link to NonText highlight
      --   Nothing = {} -- clear highlight of Nothing
      -- },
      -- Or you can also use it like a function to get color from theme
      -- overrides = function (colors)
      --   return {
      --     NonText = { fg = colors.white }, -- set NonText fg to white of theme
      --   }
      -- end,

    })   -- dracula.setup
  end
}
