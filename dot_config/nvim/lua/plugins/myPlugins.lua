return {
	{
		"folke/flash.nvim",
		keys = {
			{ "s", false, mode = { "n", "x", "o" } },
			{ "S", false, mode = { "n", "x", "o" } },

			{
				"<Space><Space>",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
		},
	},
	{ "nvim-tree/nvim-web-devicons", opts = {} },

	{
		"3rd/image.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("image").setup({
				backend = "kitty", -- use "kitty" if you're on Kitty terminal
				integrations = {
					markdown = {
						enabled = true,
						clear_in_insert_mode = false,
						download_remote_images = true,
						only_render_image_at_cursor = false,
						filetypes = { "markdown", "vimwiki" },
					},
				},
				max_width_window_percentage = 50,
				max_height_window_percentage = 50,
				window_overlap_clear_enabled = true,
				window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
			})
		end,
	},

	{
		"nvim-mini/mini.move",
		options = {
			reindent_linewise = false, -- 👈 THIS is the key
		},
	},

	{
		"epwalsh/obsidian.nvim",
		version = "*",
		lazy = true,
		ft = "markdown",
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",

			-- see below for full list of optional dependencies 👇
		},
		opts = {
			workspaces = {
				{
					name = "BASENOTE",
					path = "~/MEGA/BASENOTE",
				},
			},

			-- see below for full list of options 👇
		},
	},

	{
		"folke/noice.nvim",
		opts = {
			messages = {
				enabled = true,
			},
			notify = {
				enabled = true,
			},
		},
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				theme = "auto",
				globalstatus = true,
			},

			sections = {

				lualine_y = {
					"progress",
					"location",
				},

				lualine_z = { "searchcount" },
			},
		},
	},
}
