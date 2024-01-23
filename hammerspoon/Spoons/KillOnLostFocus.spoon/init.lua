local M = {}

M.__index = M

M.name = "KillOnLostFocus"
M.version = "0.1"
M.author = "Laurynas Keturakis <laurynas.keturakis@gmail.com"
M.license = "MIT - https://opensource.org/licenses/MIT"
M.logger = hs.logger.new(M.name)

function M:start()
	hs.window.filter.default:subscribe(hs.window.filter.windowFocused, function(_, appInFocus, _)
		local app = hs.application.get("DeepL")
		if app:title() ~= appInFocus then
			-- TODO: add some cleverness around checking if the app is not hidden in the first place
			app:hide()
		end
	end)
end

return M
