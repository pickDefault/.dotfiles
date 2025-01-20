vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.cmd([[filetype on]])

function add_lsp(args) -- args contain filetypes, name, cmd, callback and root_dir
	local filetypes = args.filetypes
	local name = args.name
	local cmd = args.cmd
	local callback = args.callback
	-- if root_dir not provided, set to cwd
	local root_dir = args.root_dir or vim.fn.getcwd()

	vim.api.nvim_create_autocmd("BufEnter", {
		pattern = filetypes,
		callback = function()
			client_id = vim.lsp.start({
				name = name,
				cmd = cmd,
				root_dir = root_dir
			})

			vim.lsp.buf_attach_client(0, client_id)

			if callback then
				callback()
			end
		end
	})
end

add_lsp({
	filetypes = {"*.xml"},
	name = 'lemminx',
	cmd = { 'java', '-jar', '/home/fw/vscode-xml/extension/server/org.eclipse.lemminx-0.29.0-uber.jar' },
	callback = function()
		vim.cmd([[set filetype=xml]])
	end
})

add_lsp({
	filetypes = { "*.c", "*.h", "*.cpp", "*.hpp" },
	name = 'clangd',
	cmd = { 'clangd', '--clang-tidy' },
	callback = function()
		vim.opt.tabstop = 4;
		vim.opt.shiftwidth = 4;
	end


--		local function auto_complete_popup()
--		  local col = vim.fn.col('.')
--		  local line = vim.fn.getline('.')
--		  if vim.fn.pumvisible() then
--			return
--		  end
--		  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-x><C-o>", true, false, true), "n", true)
--		end
--
--		vim.api.nvim_create_autocmd({ "InsertCharPre" }, {
--		  callback = auto_complete_popup,
--		  group = vim.api.nvim_create_augroup("LSPAutocomplete", { clear = true }),
--		})

		--local autocmp_key = vim.api.nvim_replace_termcodes('<C-x><C-o>', true, false, true)
		--vim.api.nvim_create_autocmd({ "InsertCharPre" }, {
		--	pattern = { "*.c", "*.h" },
		--	callback = function()
		--		if string.match(vim.v.char, "[%w%c\\._\\-\\>]") ~= nil and vim.fn.pumvisible() ~= 1 then
		--			vim.api.nvim_feedkeys(autocmp_key, 'n', true)
		--		end
		--	end
		--})

})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		vim.diagnostic.config({
			virtual_text = false
		})

		local nmap = function(keys, func, desc)
			if desc then
				desc = 'LSP: ' .. desc
			end

			vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
		end

		nmap(']d', vim.diagnostic.goto_next, 'Go to next diagnostic')
		nmap('[d', vim.diagnostic.goto_prev, 'Go to prev diagnostic')
		nmap('<leader>cn', vim.lsp.buf.rename, '[C]hange [N]ame')
		nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
		nmap('gd', vim.lsp.buf.definition, '[G]o to [D]efintion')
		nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
		nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
		nmap('ge', vim.diagnostic.open_float, 'Open floating diagnostic message')
		nmap('<leader>q', vim.diagnostic.setloclist, 'Open diagnostics list')
		nmap('K', vim.lsp.buf.hover, 'Open diagnostics list')

		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
		vim.api.nvim_buf_create_user_command(ev.buf, 'Fmt', function() vim.lsp.buf.format() end, { desc = 'Format buffer' })
	end
})

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
vim.o.completeopt = 'menuone,noinsert,menu'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Personal settings

-- No timeout for key sequences
vim.o.timeout = false

vim.cmd([[colorscheme habamax]])

-- ignore lock files in general
vim.cmd([[set wildignore+=*.lock]])

vim.cmd([[set wildoptions+=fuzzy]])

vim.o.foldmethod = "indent"
vim.o.foldenable = false

-- :vsplit and :split to split window right/below instead of left/above
vim.cmd([[set splitright]])
vim.cmd([[set splitbelow]])

vim.g.netrw_winsize = 30
vim.g.netrw_liststyle = 3

-- Moving between buffers
vim.keymap.set({ 'n' }, ']b', '<CMD>bn<CR>', { desc = "Go to next buffer" })
vim.keymap.set({ 'n' }, '[b', '<CMD>bp<CR>', { desc = "Go to prev buffer" })

-- Moving between tabs
vim.keymap.set({ 'n' }, ']t', '<CMD>tabnext<CR>', { desc = "Go to next tab" })
vim.keymap.set({ 'n' }, '[t', '<CMD>tabprev<CR>', { desc = "Go to prev tab" })

vim.keymap.set({ 't' }, '<C-_>', '<C-\\><C-n>', { desc = "switch to normal mode in neovim terminal" })

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
