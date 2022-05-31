local awful = require("awful")
local gears = require("gears")
local beautiful =  require("beautiful")
local wibox = require("wibox")
require("conf.core.icondir")
-- Taglist Mouse Support
local taglist_buttons = gears.table.join(
	awful.button({ }, 1, function(t) t:view_only() end),
        awful.button({ modkey }, 1, function(t)
                        if client.focus then
                        client.focus:move_to_tag(t)
                        end
                	end),
	awful.button({ }, 3, awful.tag.viewtoggle),
        awful.button({ modkey }, 3, function(t)
                        if client.focus then
                        client.focus:toggle_tag(t)
                        end
                        end),
	awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
        awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)


-- Show Taglist For Each Screen
--"""
-- Tags??????

awful.screen.connect_for_each_screen(function(s)
awful.tag.add("",  {
     layout             = awful.layout.suit.tile.left,
     --selected		= true,
     screen             = s,
 })
 awful.tag.add(" ", {
     layout             = awful.layout.suit.tile.left,
     screen             = s,
 })
 awful.tag.add("", {
     layout             = awful.layout.suit.tile.left,
     screen             = s,
 })

 awful.tag.add("", {
     layout             = awful.layout.suit.tile.left,
     screen             = s,
 })


 awful.tag.add(" ", {
     layout             = awful.layout.suit.tile.left,
     screen             = s,
 })

 awful.tag.add("", {
     layout             = awful.layout.suit.tile.left,
     screen             = s,
 })
-- Create the taglist widget
    tag_list = awful.widget.taglist { 
	screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
	layout = wibox.layout.fixed.horizontal
    }
end)
