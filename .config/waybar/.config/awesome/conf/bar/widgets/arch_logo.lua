local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")
require("conf.core.icondir")
local arch_logo = {}

return function()
	power_menu = awful.menu({ items = { { "Logout", "killall --user SamDaaEpic", beautiful.awesome_icon },{ "Lock", "xfce4-screensaver-command -l" }, { "Reboot", "reboot"}, { "Shutdown", "shutdown now" }}})
	
	arch_logo = awful.widget.launcher({ 	image = icondir .. "arch_logo/arch_logo.png",
						menu = power_menu
						})

	return arch_logo
end

