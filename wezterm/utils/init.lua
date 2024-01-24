local M = {}

local wezterm = require("wezterm")
local act = wezterm.action
local fmt = wezterm.format

local function is_vim(pane)
	return pane:get_user_vars().IS_NVIM == "true"
end

M.bind_if = function(cond, key, mods, action)
	local function callback(win, pane)
		if cond(pane) then
			win:perform_action(action, pane)
		else
			win:perform_action(act.SendKey({ key = key, mods = mods }), pane)
		end
	end

	return { key = key, mods = mods, action = wezterm.action_callback(callback) }
end

M.is_outside_vim = function(pane)
	return not is_vim(pane)
end

M.toggle_padding = function(window)
	local wide_window_padding = {
		left = "8cell",
		right = "8cell",
		top = "2cell",
		bottom = "2cell",
	}

	local default_window_padding = {
		left = 2,
		right = 0,
		top = 0,
		bottom = 0,
	}

	local overrides = window:get_config_overrides() or {}

	if not overrides.window_background_opacity then
		overrides.window_padding = wide_window_padding
	else
		overrides.window_padding = default_window_padding
	end
	window:set_config_overrides(overrides)
end

M.update_status_bar = function(window, pane)
	local date = wezterm.strftime("%Y-%m-%d %H:%M")

	local info = pane:get_foreground_process_info()

	local cwd = info and info.cwd or "sessionizer"

	cwd = cwd:gsub("^/Users/laurynas%-fp", "~")

	local pane_id = pane:pane_id()

	window:set_right_status(fmt({
		{ Attribute = { Italic = true } },
		{ Text = " " .. pane_id .. " " .. cwd .. " " },
	}) .. fmt({
		{ Text = date },
	}))
	-- show workspace name
	window:set_left_status("  " .. window:active_workspace() .. " ")
end

return M
