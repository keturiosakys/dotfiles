local M = {}

M.colors = {
	background = "#282a3a",
	foreground = "#eaf2f1",
	cursor_bg = "#eaf2f1",
	cursor_border = "#eaf2f1",
	visual_bell = "#b2b9bd",
	-- selection_fg = "#eaf2f1",
	selection_bg = "rgb(255 215 109 / 20%)",
	tab_bar = {
		background = "#1a1b26",
		active_tab = {
			bg_color = "#282a3a",
			fg_color = "#ffffff",
			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = "#1a1b26",
			fg_color = "#a9b1d6",
		},
		new_tab = {
			bg_color = "#1a1b26",
			fg_color = "#a9b1d6",
		},
		inactive_tab_hover = {
			bg_color = "#1a1b26",
			fg_color = "#ffffff",
			intensity = "Bold",
		},
		new_tab_hover = {
			bg_color = "#1a1b26",
			fg_color = "#ffffff",
			intensity = "Bold",
		},
	},

	ansi = {
		"#535763",
		"#ff657a",
		"#bad761",
		"#ffd76d",
		"#ff9b5e",
		"#c39ac9",
		"#9cd1bb",
		"#eaf2f1",
	},
	brights = {
		"#535763",
		"#ff657a",
		"#bad761",
		"#ffd76d",
		"#ff9b5e",
		"#c39ac9",
		"#9cd1bb",
		"#eaf2f1",
	},

	quick_select_label_bg = { Color = "rgb(255 215 109 / 10%)" },
	quick_select_match_bg = { Color = "rgb(255 215 109 / 10%)" },
	quick_select_label_fg = { Color = "#ff657a" },
}

return M
