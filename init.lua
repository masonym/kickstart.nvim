vim.g.mapleader = "<Space>"
vim.g.localleader = "<Space>"

require("config.lazy")
vim.opt.laststatus = 3
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- This automatically sets the current `cwd` to the file's directory whenever I open a buffer
-- This exists for cases when I need to use `sudo -E nvim`. The -E is to retain environment, aka all of my customizations and plugins.
-- Retaining environment means we also retain current working directory, so telescope's find_files function will not search in the correct working directory.

-- vim.api.nvim_create_autocmd("BufEnter", {
--   callback = function()
--     local bufname = vim.api.nvim_buf_get_name(0)
--     -- Skip special buffers: unnamed, URI-style (health://, term://, etc.)
--     if bufname == "" or bufname:match("^%w+://") then
--       return
--     end
--     -- Skip non-file buffers
--     if vim.bo.buftype ~= "" then
--       return
--     end
--     vim.cmd.cd(vim.fn.expand("%:p:h"))
--   end,
-- })

-- split navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- clear highlights on search
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "<leader>n", vim.diagnostic.goto_next, { desc = "Go to [N]ext diagnostic" })
vim.keymap.set("n", "<leader>p", vim.diagnostic.goto_prev, { desc = "Go to [P]revious diagnostic" })
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Open diagnostic [C]ode" })

-- indentation stuff
vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting

-- case insensitive search unless more than one capital letter in search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- line numbers and relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- dont show mode; its in the status line
vim.opt.showmode = false

-- set conceal level
vim.opt.conceallevel = 2

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- highlight which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Delete word forward in insert mode (runs Ctrl-O to run 1 normal mode command then dw)
vim.keymap.set("i", "<C-d>", "<C-o>dw", { noremap = true })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- TODO: hello
