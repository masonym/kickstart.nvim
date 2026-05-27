-- https://github.com/obsidian-nvim/obsidian.nvim/blob/main/lua/obsidian/config/default.lua
-- defaults
return {
	"obsidian-nvim/obsidian.nvim",
	version = "*", -- use latest release, remove to use latest commit
	---@module 'obsidian'
	---@type obsidian.config
	opts = {
		legacy_commands = false, -- this will be removed in 4.0.0
		workspaces = {
			{
				name = "Notes",
				path = "~/Notes",
			},
			-- can add more here
		},
		templates = {
			folder = "/templates",
		},
		ui = { enable = true },
		footer = { enabled = false },
		note_id_func = function(title)
			return title
		end,
	},
	config = function(_, opts)
		require("obsidian").setup(opts)
		vim.api.nvim_create_autocmd("User", {
			pattern = "ObsidianNoteEnter",
			callback = function(ev)
				local builtin = require("obsidian.api")
				vim.keymap.set(
					"v",
					"<leader>ol",
					builtin.link,
					{ buffer = true, desc = "[O]bsidian Link Visual Selection" }
				)
				vim.keymap.set(
					"n",
					"<leader>ot",
					builtin.new_from_template,
					{ buffer = true, desc = "[O]bsidian New from [T]emplate" }
				)
				vim.keymap.set(
					"v",
					"<leader>ox",
					builtin.extract_note,
					{ buffer = true, desc = "[O]bsidian E[x]tract Selection to Note" }
				)
			end,
		})
	end,
}
