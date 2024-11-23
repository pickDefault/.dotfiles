return {
  'chipsenkbeil/distant.nvim',
  branch = 'v0.3',
  config = function()
    local plugin = require('distant')
    function on_attach()
      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end

      nmap('<leader>cn', vim.lsp.buf.rename, '[C]hange [N]ame')
      nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
      nmap('gd', vim.lsp.buf.definition, '[G]o to [D]efintion')

      -- nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
      -- nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
      -- nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
      -- nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
      -- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
      -- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

      -- See `:help K` for why this keymap
      -- zmochi note: Changed keymap below from 'K' to 'gh'
      -- nmap('gh', function()
      --   vim.lsp.buf.hover()
      --   vim.lsp.buf.hover()
      -- end, 'Hover Documentation')
      -- nmap('<C-k>', function()
      --   vim.lsp.buf.signature_help()
      --   vim.lsp.buf.signature_help()
      -- end, 'Signature Documentation')
      -- Mapping for jumping to hover window in insert mode is in nvim-cmp.lua

      -- Lesser used LSP functionality
      nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
      nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
      nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, '[W]orkspace [L]ist Folders')

      -- Create a command `:Format` local to the LSP buffer
      -- vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
      --   -- vim.lsp.buf.format()
      --   require("conform").format({
      --     lsp_fallback = true,
      --     async = false,
      --     timeout_ms = 50,
      --   })
      -- end, { desc = 'Format current buffer with conform.nvim or LSP if formatter not available' })

      nmap('<leader>cn', vim.lsp.buf.rename, '[C]hange [N]ame')
      nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
      nmap('gd', vim.lsp.buf.definition, '[G]o to [D]efintion')
      nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
      nmap('ge', vim.diagnostic.open_float, 'Open floating diagnostic message')
      nmap('<leader>q', vim.diagnostic.setloclist, 'Open diagnostics list')
      -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
    end

    function on_exit(code, signal, client_id)
      local prefix = '[Client ' .. tostring(client_id) .. ']'
      print(prefix .. ' LSP exited with code ' .. tostring(code))

      -- Signal can be nil
      if signal ~= nil then
        print(prefix .. ' Signal ' .. tostring(signal))
      end
    end

    plugin:setup({
      servers = {
        ['fw'] = {
          launch = {
            cwd = '/home/fw',
            bin = '/home/fw/.local/bin/distant',
          },
          lsp = {
            ['eBPF'] = {
              cmd = { 'clangd --background-index' },
              root_dir = '/home/fw/eBPF',
              file_types = { 'c', 'h' },
              on_attach = on_attach,
              on_exit = on_exit,
            }
          }
        },
        ['turtle'] = {
          launch = {
            cwd = '/home/turtle',
            bin = '/home/turtle/.local/bin/distant'
          },
          lsp = {
            ['opsys_hw4'] = {
              cmd = { '/usr/bin/clangd --background-index' },
              root_dir = '/home/turtle/opsys_hw4',
              file_types = { 'c', 'h' },
              on_exit = function(code, signal, client_id)
                local prefix = '[Client ' .. tostring(client_id) .. ']'
                print(prefix .. ' LSP exited with code ' .. tostring(code))

                -- Signal can be nil
                if signal ~= nil then
                  print(prefix .. ' Signal ' .. tostring(signal))
                end
              end,

              on_attach = on_attach
            }
          }
        }
      }


    })
  end
}
