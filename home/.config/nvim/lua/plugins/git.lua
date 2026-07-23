return {
	{
		"NeogitOrg/neogit",
		dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
		keys = {
			{
				"<leader>g",
				function()
					require("neogit").open()
				end,
				desc = "Neogit",
			},
			{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff View (repo)" },
			{ "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Close Diff View" },
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "BufWinEnter",
		opts = { current_line_blame = true }, -- who last touched this line
		keys = {
			{
				"<leader>gp",
				function()
					require("gitsigns").preview_hunk()
				end,
				desc = "Preview Hunk",
			},
			{
				"<leader>gx",
				function()
					require("gitsigns").toggle_deleted()
				end,
				desc = "Toggle Deleted Lines",
			},
			{
				"]h",
				function()
					require("gitsigns").next_hunk()
				end,
				desc = "Next Hunk",
			},
			{
				"[h",
				function()
					require("gitsigns").prev_hunk()
				end,
				desc = "Prev Hunk",
			},
		},
	},
}
