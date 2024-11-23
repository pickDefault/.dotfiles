return {
  -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim

    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    -- { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

    -- Additional lua configuration, makes nvim stuff amazing!
    'folke/neodev.nvim',
  },
  -- opts = {
  --   servers = {
  --     clangd = {
  --       mason = false,
  --       capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
  --       cmd = { "clangd", "--log=verbose", }
  --     }
  --   }
  -- },
  config = function()
    -- require('neodev').setup()
    -- local capabilities = require('cmp_nvim_lsp').default_capabilities();
    -- local lspconfig = require("lspconfig");
    --
    -- lspconfig.clangd.setup({
    --   capabilities = capabilities,
    --   cmd = {
    --     'clangd',
    --     '--clang-tidy',
    --     '--log=verbose',
    --   },
    --   filetypes = { "c", "h", "cpp", "hpp" },
    -- })
    --
    -- lspconfig.lua_ls.setup({})
    -- lspconfig.pylsp.setup({
    --   capabilities = capabilities,
    --   filetypes = { "py", "python" },
    --   settings = {
    --     pylsp = {
    --       plugins = {
    --         jedi_completion = { fuzzy = true },
    --         pylint = { enabled = true, executable = "pylint" },
    --         pyflakes = { enbaled = false },
    --         pycodestyle = { enabled = false }
    --       }
    --     }
    --   }
    -- })
    -- lspconfig.marksman.setup({
    --   capabilities = capabilities,
    -- })
    -- lspconfig.jdtls.setup({})
    -- lspconfig.jsonls.setup({
    --   capabilities = capabilities,
    -- })
    -- lspconfig.yamlls.setup({
    --   capabilities = capabilities,
    -- })
    -- lspconfig.texlab.setup({
    --   capabilities = capabilities,
    --   filetypes = { "latex", "tex" },
    -- })
    --
    --
    -- local nmap = function(keys, func, desc)
    --   if desc then
    --     desc = 'LSP: ' .. desc
    --   end
    --
    --   vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    -- end

    -- nmap('<leader>cn', vim.lsp.buf.rename, '[C]hange [N]ame')
    -- nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    -- nmap('gd', vim.lsp.buf.definition, '[G]o to [D]efintion')
    -- nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    -- nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    -- nmap('ge', vim.diagnostic.open_float, 'Open floating diagnostic message')
    -- nmap('<leader>q', vim.diagnostic.setloclist, 'Open diagnostics list')
    -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    -- nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    -- nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    -- nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
    -- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    -- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    -- nmap('gh', function()
    --   vim.lsp.buf.hover()
    --   vim.lsp.buf.hover()
    -- end, 'Hover Documentation')
    -- Mapping for jumping to hover window in insert mode is in nvim-cmp.lua

    -- Lesser used LSP functionality
    -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    -- nmap('<leader>wl', function()
    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, '[W]orkspace [L]ist Folders')

    -- vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    --   -- vim.lsp.buf.format()
    --   require("conform").format({
    --     lsp_fallback = true,
    --     async = false,
    --     timeout_ms = 50,
    --   })
    -- end, { desc = 'Format current buffer with conform.nvim or LSP if formatter not available' })
    --

    -- Should be set automatically:
    -- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
    -- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })


    -- Make error message not appear automatically following the code that causes error
    -- From https://stackoverflow.com/questions/69290794/nvim-lsp-change-lspconfig-diagnostic-message-location
  end,
}
