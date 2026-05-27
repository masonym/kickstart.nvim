return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		delay = 0,
		spec = {
			{ "<leader>s", group = "[S]earch", mode = { "n", "v" } },
			{ "<leader>t", group = "[T]oggle" },
			{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } }, -- Enable gitsigns recommended keymaps first
			{ "gr", group = "LSP Actions", mode = { "n" } },
		},
	},
}
