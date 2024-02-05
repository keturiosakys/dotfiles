hs.loadSpoon("ReloadConfiguration")
spoon["ReloadConfiguration"]:start()

hs.loadSpoon("GithubNotifications")
spoon["GithubNotifications"]:start()

hs.loadSpoon("AppLauncher")

hs.loadSpoon("KillOnLostFocus")
spoon["KillOnLostFocus"]:start()

local keybinds = require("keybinds")
keybinds:init()
