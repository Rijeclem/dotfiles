return {

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
}
