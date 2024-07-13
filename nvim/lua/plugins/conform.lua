return {
  'stevearc/conform.nvim',
  event = { "BufReadPre", "BufNewFile" },
  opts = {},
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        c = { "clang_format" },
        h = { "clang_format" }, -- c/cpp header file
        cpp = { "clang_format" },
        python = { "autopep8" },
        markdown = { "marksman" },
        sh = { "shfmt" },
        bash = { "shfmt" },
      },

      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      },
    })

    vim.api.nvim_create_user_command("Format", function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ["end"] = { args.line2, end_line:len() },
        }
      end
      require("conform").format({ async = true, lsp_fallback = true, range = range })
    end, { range = true })
  end
}
