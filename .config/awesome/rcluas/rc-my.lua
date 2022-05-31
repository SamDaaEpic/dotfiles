pcall(require, "luarocks.loader")                       
require("awful.autofocus")
require("conf.bar.bar")
require("conf.core.ruled")
require("conf.theme.wallpaper")
require("conf.bindings.keybindings")
require("conf.core.autostart")
require("conf.core.errors")
require("conf.core.signals")
require("conf.core.layouts")
require("conf.core.notifications")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
--Make floating windows appear in the middle of the screen
client.connect_signal ("property::floating", function (c) awful.placement.centered (c) end)
gears.timer {
	timeout = 30,
	autostart = true,
	callback = function() collectgarbage() end
}
--diable window snapping
awful.mouse.snap.edge_enabled = false
awful.mouse.resize.set_mode("live")
beautiful.init("/home/SamDaaEpic/.config/awesome/conf/theme/theme.lua")
