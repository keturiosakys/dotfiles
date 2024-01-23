local M = {}

--[[local function debuggingYabai(err, _, stderr)
	print("finished yabai")
	if err then
		print(stderr)
	end
end]]

local managerMode = hs.hotkey.modal.new("option", "x", "manager")

local function yabai(commands)
	local args = { "-m" }

	for _, arg in ipairs(commands) do
		table.insert(args, arg)
	end

	local yabai_task = hs.task.new("/opt/homebrew/bin/yabai", nil, args)

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

local function register(mod, key, msg, callback)
	local f = function()
		callback()
		managerMode:exit()
	end

	managerMode:bind(mod, key, msg, f)
end

function M:init()
	hs.loadSpoon("AppLauncher")
	spoon.AppLauncher:bindHotkeys({
		d = "Discord",
		f = "Finder",
		q = "Tot",
	})

	local screen = hs.screen.mainScreen()
	local spaces = hs.spaces.spacesForScreen(screen)

	managerMode:bind("", "escape", nil, function()
		managerMode:exit()
	end)

	managerMode:bind("", "1", nil, function()
		moveToSpace(spaces, 1)
		managerMode:exit()
	end)
	managerMode:bind("", "2", nil, function()
		moveToSpace(spaces, 2)
		managerMode:exit()
	end)
	managerMode:bind("", "3", nil, function()
		moveToSpace(spaces, 3)
		managerMode:exit()
	end)
	managerMode:bind("", "4", nil, function()
		moveToSpace(spaces, 4)
		managerMode:exit()
	end)

	managerMode:bind("", "h", nil, function()
		yabaiDirectional("focus", "left")
		managerMode:exit()
	end)
	managerMode:bind("", "j", nil, function()
		yabaiDirectional("focus", "down")
		managerMode:exit()
	end)
	managerMode:bind("", "k", nil, function()
		yabaiDirectional("focus", "up")
		managerMode:exit()
	end)
	managerMode:bind("", "l", nil, function()
		yabaiDirectional("focus", "right")
		managerMode:exit()
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
end

return M
