local M = {}

function M:start()

	print(hs.inspect(hs.uielement))
	print(hs.inspect(hs.uielement.watcher))

	--local watcher = hs.uielement:newWatcher(function (element, event)
	--	print("element: ", element)
	--	print("element role: ", element:role())
	--	print("event :", event)
	--end)
	--
	--watcher:start()
end

return M
