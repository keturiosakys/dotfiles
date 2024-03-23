local M = {}

--[[local function debuggingYabai(err, _, stderr)
	print("finished yabai")
	if err then
		print(stderr)
	end
end]]

local function yabai(commands)
	local args = { "-m" }

	for _, arg in ipairs(commands) do
		table.insert(args, arg)
	end

	local yabai_task = hs.task.new("/etc/profiles/per-user/laurynas-fp/bin/yabai", nil, args)

	yabai_task:start()
end

local directionalMapping = {
	["left"] = "west",
	["down"] = "south",
	["up"] = "north",
	["right"] = "east",
}

local directionalCommand = {
	["focus"] = "--focus",
	["swap"] = "--swap",
	["warp"] = "--warp",
}

local function moveToSpace(spaces, num)
	local win = hs.window.frontmostWindow()
	if win then
		local res, err = hs.spaces.moveWindowToSpace(win, spaces[num])
		if not res then
			print(err)
		end
	end
end

local function yabaiDirectional(cmd, direction)
	local cmd = { "window", directionalCommand[cmd], directionalMapping[direction] }

	yabai(cmd)
end

function M:init()
	hs.loadSpoon("AppLauncher")
	spoon.AppLauncher:bindHotkeys({
		-- for one hits
		["return"] = "WezTerm",
		q = "Tot",
		f = "Finder",
		o = "Obsidian",
	}, {
		-- for holds
		a = "Arc",
	}, { "alt" })

	local screen = hs.screen.mainScreen()
	local spaces = hs.spaces.spacesForScreen(screen)
	local managerMode = hs.hotkey.modal.new("option", "x", "manager")

	-- local function register(mod, key, msg, callback)
	-- 	return managerMode:bind(mod, key, msg, function ()
	-- 		callback()
	-- 		managerMode:exit()
	-- 	end)
	-- end

	managerMode:bind("", "escape", nil, function()
		managerMode:exit()
	end)

	hs.hotkey.bind({ "option", "shift" }, "1", function()
		moveToSpace(spaces, 1)
	end)
	hs.hotkey.bind({ "option", "shift" }, "2", function()
		moveToSpace(spaces, 2)
	end)
	hs.hotkey.bind({ "option", "shift" }, "3", function()
		moveToSpace(spaces, 3)
	end)
	hs.hotkey.bind({ "option", "shift" }, "4", function()
		moveToSpace(spaces, 4)
	end)
	hs.hotkey.bind({ "option", "shift" }, "5", function()
		moveToSpace(spaces, 5)
	end)
	hs.hotkey.bind({ "option", "shift" }, "6", function()
		moveToSpace(spaces, 6)
	end)
	hs.hotkey.bind({ "option", "shift" }, "7", function()
		moveToSpace(spaces, 7)
	end)


	hs.hotkey.bind({ "option", "shift" }, "h", nil, function()
		yabaiDirectional("focus", "left")
	end)
	hs.hotkey.bind({ "option", "shift" }, "j", nil, function()
		yabaiDirectional("focus", "down")
	end)
	hs.hotkey.bind({ "option", "shift" }, "k", nil, function()
		yabaiDirectional("focus", "up")
	end)
	hs.hotkey.bind({ "option", "shift" }, "l", nil, function()
		yabaiDirectional("focus", "right")
	end)

	hs.hotkey.bind({ "option" }, "w", nil, function()
		yabai({ "space", "--layout", "bsp" })
	end)
	hs.hotkey.bind({ "option" }, "t", nil, function()
		yabai({ "space", "--layout", "stack" })
	end)
	hs.hotkey.bind({ "option", "shift" }, "space", nil, function()
		yabai({ "window", "--toggle", "float" })
	end)

	managerMode:bind("", "space", nil, function()
		yabai({ "space", "--layout", "bsp" })
		managerMode:exit()
	end)
	managerMode:bind("shift", "space", nil, function()
		yabai({ "space", "--layout", "stack" })
		managerMode:exit()
	end)

	managerMode:bind("", "t", nil, function()
		yabai({ "window", "--toggle", "float" })
		managerMode:exit()
	end)

	managerMode:bind("", "=", nil, function()
		yabai({ "space", "--balance" })
		managerMode:exit()
	end)
end

return M
