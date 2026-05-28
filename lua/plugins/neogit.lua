return {
	{
		"NeogitOrg/neogit",
		lazy = true,
		dependencies = {
			-- Only one of these is needed.
			"sindrets/diffview.nvim", -- optional
			"esmuellert/codediff.nvim", -- optional

			-- For a custom log pager
			"m00qek/baleia.nvim", -- optional

			-- Only one of these is needed.
			"nvim-telescope/telescope.nvim", -- optional
			"ibhagwan/fzf-lua", -- optional
			"nvim-mini/mini.pick", -- optional
			"folke/snacks.nvim", -- optional
		},
		cmd = "Neogit",
		keys = {
			{ "<leader>gs", "<cmd>Neogit<cr>", desc = "Show Neogit [s]tatus" },
			{ "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Neogit [c]ommit" },
			{ "<leader>gp", "<cmd>Neogit pull<cr>", desc = "Neogit [p]ull" },
			{ "<leader>gP", "<cmd>Neogit push<cr>", desc = "Neogit [P]ush" },
		},
	},
}
