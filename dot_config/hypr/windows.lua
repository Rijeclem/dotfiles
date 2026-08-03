-- for lua to not warn "hl"
---@diagnostic disable: undefined-global

hl.window_rule({
	match = {
		title = "^(ClassProgram)$",
	},
	float = true,
})

hl.window_rule({
	match = {
		class = "^(cs2)$",
	},
	immediate = true,
})

--Small Calculator
hl.window_rule({
	match = {
		class = "^(org\\.gnome\\.Calculator)$",
	},
	float = true,
})

-- MEGASYNC FIX
hl.window_rule({
	match = {
		class = "MEGAsync",
	},
	float = true,
	fullscreen = true,
})

-- AFFINITY EXCEPTION
hl.window_rule({
	match = {
		class = "^(affinity\\.exe)$",
	},
	no_blur = true,
	opaque = true,
})

-- MAPTOOL EXCEPTION
hl.window_rule({
	match = {
		class = "^(.*maptool.*)$",
	},
	no_blur = true,
	opaque = true,
})

-- DaVinci EXCEPTION
hl.window_rule({
	match = {
		class = "^(resolve)$",
	},
	no_blur = true,
	opaque = true,
})

-- Tag Windows and Decorations
-- windowrule = bordercolor rgb(F7768E) rgb(FF9E64) rgb(3B1F2B) rgb(EF4444) 45deg, tag:main
-- windowrule = bordercolor rgb(7AA2F7) rgb(89DDFF) rgb(1E2A3A) rgb(38BDF8) 45deg, tag:secondary
hl.window_rule({
	match = {
		float = 1,
	},
	border_color = "rgb(F7768E) rgb(FF9E64) rgb(3B1F2B) rgb(EF4444) 45deg",
})

hl.window_rule({
	match = {
		xwayland = 1,
	},
	border_color = "rgb(7AA2F7) rgb(89DDFF) rgb(1E2A3A) rgb(38BDF8) 45deg",
})

hl.window_rule({
	match = {
		pin = 1,
	},
	border_size = 1,
	persistent_size = 1,
})

hl.window_rule({
	match = {
		tag = "background",
	},
	border_color = "rgb(1F6F5B) rgb(2A9D8F) rgb(0B2E25) rgb(1F8A70) 45deg",
	opaque = true,
})

hl.window_rule({
	match = {
		class = "obsidian",
	},
	border_color = "rgb(C4B5FD) rgb(E0D7FF) rgb(2B1B4A) rgb(A78BFA) 45deg",
})

hl.window_rule({
	match = {
		class = "wofi",
	},
	border_color = "rgb(FFFFFF) rgb(F5F5F5) rgb(7A7A7A) rgb(C8C8C8) 45deg",
})

hl.window_rule({
	match = {
		class = "^floating-terminal$",
	},
	float = true,
	center = true,
	size = { 800, 600 },
	border_color = "rgb(FFFFFF) rgb(F5F5F5) rgb(7A7A7A) rgb(C8C8C8) 45deg",
})

hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 20,
		border_size = 3,
		col = {
			active_border = { colors = { "rgb(A594F9)", "rgb(CDC1FF)", "rgb(24273A)", "rgb(8aadf4)" }, angle = 45 },
			inactive_border = { colors = { "rgb(24273A)", "rgb(24273A)", "rgb(24273A)", "rgb(27273A)" }, angle = 45 },
		},
		layout = "dwindle",
		resize_on_border = true,
		allow_tearing = true,
	},
	decoration = {
		rounding = 20,
		blur = {
			enabled = true,
			size = 2,
			passes = 2,
			xray = true,
			brightness = 0.5,
			vibrancy = 0.1923,
			vibrancy_darkness = 0.9,
			special = true,
			popups = true,
			input_methods = true,
			input_methods_ignorealpha = 0.5,
		},
		inactive_opacity = 0.7,
		fullscreen_opacity = 1.0,
	},
})
