return {
	"tpope/vim-sensible",
	"tpope/vim-commentary",
	{
		'folke/tokyonight.nvim',
		-- enabled = false,
		lazy = false,
		priority = 1000,
		opts = {
			style = "night",
			transparent = false,
			styles = {

			},
			on_colors = function(colors)
				colors.border = colors.blue0
				colors.StatusLine = colors.blue0
			end,
		},
		config = function(_, opts)
			require('tokyonight').setup(opts)
			vim.cmd[[colorscheme tokyonight]]
		end,
	},
}
