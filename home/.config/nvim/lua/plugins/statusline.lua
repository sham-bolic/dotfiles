return {
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		opts = {
			options = { theme = "rose-pine" },
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff" },
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { "diagnostics", "filetype" },
				lualine_y = { "location" },
				lualine_z = { "progress" },
			},
		},
	},
}
