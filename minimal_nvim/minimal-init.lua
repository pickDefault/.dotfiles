vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "h" },
	callback = function()
		client_id = vim.lsp.start({
			name = 'clangd',
			cmd = { 'clangd', '--clang-tidy' },
			root_dir = vim.fn.getcwd(),
		})

		vim.lsp.buf_attach_client(0, client_id)

		vim.diagnostic.config({
		  virtual_text = false
		})

      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end

      nmap('<leader>cn', vim.lsp.buf.rename, '[C]hange [N]ame')
      nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
      nmap('gd', vim.lsp.buf.definition, '[G]o to [D]efintion')

      nmap('<leader>cn', vim.lsp.buf.rename, '[C]hange [N]ame')
      nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
      nmap('gd', vim.lsp.buf.definition, '[G]o to [D]efintion')
      nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
      nmap('ge', vim.diagnostic.open_float, 'Open floating diagnostic message')
      nmap('<leader>q', vim.diagnostic.setloclist, 'Open diagnostics list')

	end
	}
)

  -- set highlight on search
  vim.o.hlsearch = false

  -- make line numbers relative
  vim.wo.relativenumber = true

  -- make line numbers default
  vim.wo.number = true

  -- enable mouse mode
  vim.o.mouse = 'a'

  -- sync clipboard between os and neovim.
  --  remove this option if you want your os clipboard to remain independent.
  --  see `:help 'clipboard'`
  vim.o.clipboard = 'unnamedplus'

  -- enable break indent
  vim.o.breakindent = true

  -- save undo history
  vim.o.undofile = true

  -- Case-insensitive searching UNLESS \C or capital in search
  vim.o.ignorecase = true
  vim.o.smartcase = true

  -- Keep signcolumn on by default
  vim.wo.signcolumn = 'yes'

  -- Decrease update time
  vim.o.updatetime = 250
  vim.o.timeoutlen = 300

  -- Set completeopt to have a better completion experience
  vim.o.completeopt = 'menuone,noselect'

  -- NOTE: You should make sure your terminal supports this
  vim.o.termguicolors = true

  -- Personal settings

  -- No timeout for key sequences
  vim.o.timeout = false

  vim.cmd([[colorscheme habamax]])

    -- ignore lock files in general
  vim.cmd([[set wildignore+=*.lock]])

  vim.cmd([[set wildoptions+=fuzzy]])

  -- :vsplit and :split to split window right/below instead of left/above
  vim.cmd([[set splitright]])
  vim.cmd([[set splitbelow]])

  -- [[ Highlight on yank ]]
  -- See `:help vim.highlight.on_yank()`
  local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
  vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
      vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
  })



