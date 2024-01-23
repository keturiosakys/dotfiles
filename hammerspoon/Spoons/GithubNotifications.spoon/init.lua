--- === GithubNotifications ===
-- This is a simple spoon that shows GitHub notifications in the menu bar.

local M = {}
M.__index = M

M.name = "GithubNotifications"
M.version = "0.1"
M.author = "Laurynas Keturakis <laurynas.keturakis@gmail.com>"
M.license = "MIT - https://opensource.org/licenses/MIT"
M.logger = hs.logger.new("GithubNotifications")

local icon_path = hs.spoons.resourcePath("images/github-mark.png")
local icon = hs.image.imageFromPath(icon_path):setSize({ w = 16, h = 16 })

local gh = os.getenv("HOME") .. "/.nix-profile/bin/gh"

local function update_menubar()
	local args = { "api", "/notifications" }
	local update_task = hs.task.new(gh, function(err, stdout, stderr)
		if err ~= 0 then
			M.logger.e(err .. " " .. stderr)
			return
		end

		local json = hs.json.decode(stdout)

		local menu_data = {}
		local notif_count = nil

		if not json then
			table.insert(menu_data, {
				title = "Error fetching notifications",
				disabled = true,
			})
		else
			for _, notif in pairs(json) do
				local title = notif.subject.title
				local url = notif.subject.url
				url = url:gsub("api.github.com/repos", "github.com")
				url = url:gsub("pulls", "pull")
				local repo = notif.repository.full_name
				local item = {
					title = title .. " - " .. repo,
					fn = function()
						hs.urlevent.openURL(url)
					end,
				}
				table.insert(menu_data, item)
				notif_count = #menu_data
			end
		end
		if #menu_data == 0 then
			table.insert(menu_data, {
				title = "No new notifications",
				disabled = true,
			})
		else
			table.insert(menu_data, {
				title = "-",
				disabled = true,
			})

			table.insert(menu_data, {
				title = "Open GitHub",
				fn = function()
					hs.urlevent.openURL("https://github.com/notifications")
				end,
			})
		end
		if M.menu then
			M.menu:setMenu(menu_data)
			M.menu:setTitle(notif_count)
		end
	end, args)
	update_task:start()
end

function M:start()
	M.logger.i("=== Starting GithubNotifications ===")

	if self.menu then
		self.menu:returnToMenuBar()
	else
		self.menu = hs.menubar.new()
	end

	self.menu:setIcon(icon)
	self.menu:setTooltip("GitHub notifications")
	self.menu:setClickCallback(update_menubar)
	self.menu:autosaveName("GithubNotifications")

	self.timer = hs.timer.new(60, update_menubar)
	self.timer:start()

	update_menubar()

	return self
end

function M:stop()
	if self.menu then
		self.menu:removeFromMenuBar()
	end

	if self.timer then
		self.timer:stop()
	end

	return self
end

return M
