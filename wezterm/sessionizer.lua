local wezterm = require("wezterm")
local act = wezterm.action
local json = require("utils.json")

local M = {}

local fd = "/etc/profiles/per-user/laurynas-fp/bin/fd"
local rootPath = "/Users/laurynas-fp/Code"

M.resetCacheAndToggle = function(window, pane)
	wezterm.GLOBAL.projects = ""
	M.toggle(window, pane)
end

M.toggle = function(window, pane)
	local projects = {}

	if wezterm.GLOBAL.projects == "" or wezterm.GLOBAL.projects == nil then
		local success, stdout, stderr = wezterm.run_child_process({
			fd,
			"-H",
			"-I",
			"-td",
			"^.git$",
			rootPath,
		})

		if not success then
			wezterm.log_error("Failed to run fd: " .. stderr)
			return
		end

		for line in stdout:gmatch("([^\n]*)\n?") do
			local project = line:gsub("/.git/$", "")
			local label = project
			local id = project:gsub(".*/", "")
			table.insert(projects, { label = tostring(label), id = tostring(id) })
		end

		local encoded = json.encode(projects)

		print(encoded)

		wezterm.GLOBAL.projects = encoded
	else
		projects = json.decode(wezterm.GLOBAL.projects)
	end

	window:perform_action(
		act.InputSelector({
			action = wezterm.action_callback(function(win, _, id, label)
				if not id and not label then
					wezterm.log_info("Cancelled")
				else
					wezterm.log_info("Selected " .. label)
					win:perform_action(
						act.SwitchToWorkspace({ name = id, spawn = { cwd = label } }),
						pane
					)
				end
			end),
			fuzzy = true,
			title = "Select project",
			choices = projects,
		}),
		pane
	)
end

return M

--[[local root_success, root_stdout, root_stderr = wezterm.run_child_process({
		fd,
		".",
		"/Users/laurynas-fp/Code",
		"--max-depth=1",
	})

	if not root_success then
		wezterm.log_error("Failed to run fd: " .. root_stderr)
		return
	end

	local function trim(s)
		return (s:gsub("^%s*(.-)%s*$", "%1"))
	end

	for line in root_stdout:gmatch("([^\n]*)\n?") do
		local project = trim(line)
		local label = project
		project = project:gsub("/$", "")

		local id = project:match("/([^/]+)$")
		print("project: " .. project)
		print("id: " .. id)
		table.insert(projects, { label = tostring(label), id = tostring(id) })
	end]]
