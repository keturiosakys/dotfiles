--- === AppLauncher ===
---
--- Simple spoon for launching apps with single letter hotkeys.
---
--- Example configuration using SpoonInstall.spoon:
--- ```
--- spoon.SpoonInstall:andUse("AppLauncher", {
---   hotkeys = {
---     c = "Calendar",
---     d = "Discord",
---     f = "Firefox Developer Edition",
---     n = "Notes",
---     p = "1Password 7",
---     r = "Reeder",
---     t = "Kitty",
---     z = "Zoom.us",
---   }
--- })
--- ```
---
--- Download: [https://github.com/Hammerspoon/Spoons/raw/master/Spoons/AppLauncher.spoon.zip](https://github.com/Hammerspoon/Spoons/raw/master/Spoons/AppLauncher.spoon.zip)

local M = {}
M.__index = M

-- Metadata
M.name = "AppLauncher"
M.version = "1.0.0"
M.author = "Mathias Jean Johansen <mathias@mjj.io>"
M.homepage = "https://github.com/Hammerspoon/Spoons"
M.license = "ISC - https://opensource.org/licenses/ISC"

--- AppLauncher.modifiers
--- Variable
--- Modifier keys used when launching apps
---
--- Default value: `{"ctrl", "alt"}`
M.modifiers = { "alt" }

--- AppLauncher:bindHotkeys(mapping)
--- Method
--- Binds hotkeys for AppLauncher
---
--- Parameters:
---  * mapping - A table containing single characters with their associated app
function M:bindHotkeys(toggleMapping, holdMapping, modifiers)
	M.modifiers = modifiers or M.modifiers

	for key, app_name in pairs(toggleMapping) do
		hs.hotkey.bind(M.modifiers, key, function()
			local app = hs.application.get(app_name)
			local focused = hs.application.frontmostApplication()
			if app and app == focused then
				app:hide()
			else
				hs.application.launchOrFocus(app_name)
			end
		end)
	end

	for key, app_name in pairs(holdMapping) do
		hs.hotkey.bind(M.modifiers, key, function()
			local app = hs.application.get(app_name)
			local focused = hs.application.frontmostApplication()
			if app and app ~= focused then
				hs.application.launchOrFocus(app_name)
			end
		end, function()
			local app = hs.application.get(app_name)
			if app then
				app:hide()
			end
		end, nil)
	end
end

return M
