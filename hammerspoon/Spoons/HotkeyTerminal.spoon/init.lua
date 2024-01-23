-- https://github.com/asmagill/hs._asm.undocumented.spaces

local M = {}
M.__index = M

M.name = "HotkeyTerminal"
M.version = "0.1"
M.author = "Laurynas Keturakis <laurynas.keturakis@gmail.com"
M.license = "MIT - https://opensource.org/licenses/MIT"
M.logger = hs.logger.new(M.name)

local spaces = require("hs.spaces")
local TERM_NAME = "WezTerm"

local function move_window(terminal, space)
	-- move to main space
	local win = nil
	while win == nil do
		win = terminal:mainWindow()
	end
	local fullScreen = not win:isStandard()
	if fullScreen then
		hs.eventtap.keyStroke("cmd", "return", 0, terminal)
	end
	spaces.moveWindowToSpace(win, space)

	if not fullScreen then
		local yabai_refresh = hs.task.new("/opt/homebrew/bin/yabai", nil, { "-m", "config", "layout", "bsp" })
		yabai_refresh:start()
	end

	if fullScreen then
		hs.eventtap.keyStroke("cmd", "return", 0, terminal)
	end

	win:focus()
end

function M:toggle()
	local terminal = hs.application.get(TERM_NAME)
	if terminal ~= nil and terminal:isFrontmost() then
		terminal:hide()
	else
		local space = spaces.activeSpaceOnScreen()
		if terminal == nil and hs.application.launchOrFocus(TERM_NAME) then
			local app_watcher = nil
			app_watcher = hs.application.watcher.new(function(name, event, app)
				if event == hs.application.watcher.launched and name == TERM_NAME then
					app:hide()
					move_window(app, space)
					app_watcher:stop()
				end
			end)
			app_watcher:start()
		end
		if terminal ~= nil then
			move_window(terminal, space)
		end
	end
end

function M:start()
	hs.window.filter.default:subscribe(hs.window.filter.windowFocused, function(_, _)
		local terminal = hs.application.get(TERM_NAME)
		local win = nil
		while win == nil do
			win = terminal:mainWindow()
		end
		local fullScreen = not win:isStandard()
		if fullScreen and terminal ~= nil then
			terminal:hide()
		end
	end)
end

return M
