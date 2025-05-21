return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			require("ibl").setup()
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = { theme = "catppuccin" },
			})
		end,
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		keys = {
			{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer", silent = true },
			{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer", silent = true },
			{ "<S-x>", "<cmd>bd<cr>", desc = "Close current buffer", silent = true },
		},
		config = function()
			require("bufferline").setup({
				options = {
					diagnostics = "nvim_lsp",
					diagnostics_indicator = function(count, level)
						local icon = level:match("error") and " " or " "
						return " " .. icon .. count
					end,
				},
			})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		keys = {
			{
				"<leader>gb",
				"<cmd>Gitsigns toggle_current_line_blame<cr>",
				desc = "GIT toggle line blame",
				silent = true,
			},
		},
		config = function()
			require("gitsigns").setup({
				current_line_blame = true,
			})
		end,
	},
	{ "tpope/vim-fugitive" },
	{
		"sindrets/diffview.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		keys = {
			{ "<leader>gs", "<cmd>G<cr>", desc = "GIT Fugitive status", silent = true },
			{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open GIT diff view", silent = true },
			{ "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Close GIT diff view", silent = true },
		},
		config = function()
			require("diffview").setup()
		end,
	},
}
