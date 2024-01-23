local wezterm = require("wezterm")
local act = wezterm.action

local rose_pine = require("colors/rose-pine").colors()
local rose_pine_palette = require("colors/rose-pine").get_palette()
local update_status_bar = require("utils").update_status_bar
local toggle_padding = require("utils").toggle_padding

local keys = require("keybinds")

wezterm.on("update-status", update_status_bar)

wezterm.on("toggle-padding", toggle_padding)

wezterm.on("get-pane-id", function(window, pane)
	local pane_id = pane:pane_id()
	window:copy_to_clipboard(pane_id)
end)

return {
	default_cursor_style = "BlinkingBar",
	max_fps = 240,
	animation_fps = 1,
	cursor_blink_ease_in = "Constant",
	cursor_blink_ease_out = "Constant",
	status_update_interval = 500,
	cursor_thickness = 3,
	default_cwd = "/Users/laurynas-fp/Code",
	exit_behavior = "Close",
	window_close_confirmation = "NeverPrompt",
	native_macos_fullscreen_mode = false,
	quick_select_patterns = {
		"[A-Za-z0-9-_]{22}",
	},
	window_padding = {
		left = 2,
		right = 0,
		top = 0,
		bottom = 0,
	},
	colors = rose_pine,
	command_palette_fg_color = rose_pine.foreground,
	command_palette_bg_color = rose_pine.background,
	ui_key_cap_rendering = "AppleSymbols",
	command_palette_font_size = 16.0,
	use_fancy_tab_bar = false,
	tab_bar_at_bottom = true,
	hide_tab_bar_if_only_one_tab = false,
	enable_scroll_bar = false,
	adjust_window_size_when_changing_font_size = false,
	font_size = 14.0,
	line_height = 1.1,
	font = wezterm.font("Berkeley Mono Variable"),
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
	mouse_bindings = {
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "NONE",
			action = act.CompleteSelection("ClipboardAndPrimarySelection"),
		},
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "SUPER",
			action = act.OpenLinkAtMouseCursor,
		},
		{
			event = { Down = { streak = 1, button = "Left" } },
			mods = "SUPER",
			action = act.Nop,
		},
	},
	leader = { key = "x", mods = "CTRL", timeout_milliseconds = 1000 },
	keys = keys,
}
