hs.loadSpoon("ReloadConfiguration")
spoon["ReloadConfiguration"]:start()

hs.loadSpoon("GithubNotifications")
spoon["GithubNotifications"]:start()

--hs.loadSpoon("HotkeyTerminal")
--hs.hotkey.bind({ "alt" }, "return", function()
--	spoon["HotkeyTerminal"]:toggle()
--end)

hs.loadSpoon("AppLauncher")

local hotkeys = {
	["return"] = "WezTerm",
	q = "Tot",
	f = "Finder",
	o = "Obsidian"
}

spoon["AppLauncher"]:bindHotkeys(hotkeys)

--hs.loadSpoon("SpaceCounter")
--spoon["SpaceCounter"]:start()

hs.loadSpoon("KillOnLostFocus")
spoon["KillOnLostFocus"]:start()

--hs.loadSpoon("Todo")
--spoon["Todo"]:start()

--local keybinds = require("keybinds")
--keybinds:init()
