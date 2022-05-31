local wibox = require("wibox")
local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi
local awful = require("awful")


-- Mouse Support For Tasklist
local tasklist_buttons = gears.table.join(awful.button({ }, 1, function (c)
if c == client.focus then
        c.minimized = true
                        else
c:emit_signal("request::activate", "tasklist", {raise = true})
end
end),
        awful.button({ }, 3, function()
                awful.menu.client_list({ theme = { width = 250 } })
end),
                awful.button({ }, 4, function ()
                awful.client.focus.byidx(1)
end),
                awful.button({ }, 5, function ()
                awful.client.focus.byidx(-1)
end))


-- Show Tasklist For Each Screen
awful.screen.connect_for_each_screen(function(s)

-- Create The Tasklist Widget

task_list = awful.widget.tasklist {
    screen   = s,
    filter   = awful.widget.tasklist.filter.currenttags,
    buttons  = tasklist_buttons,
    style    = {
        border_width = 1,
        shape        = gears.shape.rounded_rect,
    },
    layout   = {
        spacing_widget = {
            {
                shape        = gears.shape.rounded_rect,
                widget       = wibox.widget.separator
            },
            valign = "center",
            halign = "center",
            widget = wibox.container.place,
        },
        layout  = wibox.layout.flex.horizontal
    },
    -- Notice that there is *NO* wibox.wibox prefix, it is a template,
    -- not a widget instance.
    widget_template = 
     {
        {
            {
                    {
                        id     = "icon_role",
                        widget = wibox.widget.imagebox,
                    },
                
                layout = wibox.layout.fixed.horizontal,
            },
            left  = 6,
            right = 7,
	    top = dpi(3),
	    bottom = dpi(3),
            widget = wibox.container.margin
        },

        id     = "background_role",
        widget = wibox.container.background,
    },
}

	return task_list
end)
