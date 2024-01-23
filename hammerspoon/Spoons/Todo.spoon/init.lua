local M = {}

M.__index = M

M.name = "Todo"
M.version = "0.1"
M.author = "Laurynas Keturakis <laurynas.keturakis@gmail.com"
M.license = "MIT - https://opensource.org/licenses/MIT"
M.logger = hs.logger.new(M.name)

local excludedApplications = {
	"WezTerm",
}

local keyMap = hs.keycodes.map
local eventTypes = hs.eventtap.event.types

M.todoMode = false
M.trigger = ""
M.todoString = ""

M.resetState = function()
	M.todoMode = false
	M.trigger = ""
	M.todoString = ""
end

-- @param buf "trigger" | "todoString"
local function backspaceChar(buf)
	if #M[buf] > 0 then
		M[buf] = string.sub(M[buf], 1, -2)
	end

	-- TODO: might need to revisit this...
	if #M[buf] == 0 then
		M.resetState()
	end
end

M.onDelete = function()
	if M.todoMode then
		backspaceChar("todoString")
	else
		backspaceChar("trigger")
	end
end

M.onReturn = function()
	if M.todoMode then
		print(M.todoString)
		-- save todo
		M.resetState()
	else
		M.resetState()
	end
end

local function monitor()

	-- TODO: might need to rewite this whole thing with a cursor table and char positions

	local keyDownEvent = hs.eventtap.new("all", function(event)
		local eventType = event:getType(true)
		local focusedApp = hs.application.frontmostApplication():name()

		if excludedApplications[focusedApp] ~= nil then
			-- if the focused app is in our focusedApp list we
			-- exit the monitor and reset the state
			M.resetState()
			return false
		end

		if eventType ~= eventTypes.keyDown or eventTypes.keyUp and M.todoMode then
			M.resetState()
			return false
		elseif eventType ~= eventTypes.keyDown or eventTypes.keyUp and not M.todoMode then
			M.resetState()
			return false
		end

		local keyCode = event:getKeyCode()
		local char = event:getCharacters()

		if keyCode == keyMap["delete"] then
			M.onDelete()
			return false
		end

		if keyCode == keyMap["return"] then
			M.onReturn()
			return false
		end

		if keyCode == keyMap["space"] then
			M.onSpace()
			return false
		end

		if keyCode == keyMap["tab"] or keyCode == keyMap["up"] or keyCode["down"] then
			return false
		end

		M.trigger = M.trigger .. char

		if M.trigger == "TODO" then
			hs.alert.show("TODO")

			M.todoMode = true
			M.todoString = M.trigger
		end

		return false
	end)
	keyDownEvent:start()
end

function M:start()
	monitor()
end

return M
