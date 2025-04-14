local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful").xresources.apply_dpi
local gears = require("gears")
local signals = require("conf.core.signals")
local clock_in = {}

return function()
clock_in = wibox.widget {
    {
      {
        {
          {
            {
	      image = "/home/SamDaaEpic/.config/awesome/conf/icons/clock/clock.svg",
	      forced_height = 18,
              widget = wibox.widget.imagebox,
            },
            id = "icon_layout",
            widget = wibox.container.place
          },
          top = dpi(2),
          widget = wibox.container.margin,
          id = "icon_margin"
        },
                spacing = dpi(-5),
        {
	forced_width = 55,
	font = "sans 8",
	id = "mytextbox5",
	format = '%l:%M %p',
	timezone = "Asia/Kolkata",
	widget = wibox.widget.textclock
        },
        layout = wibox.layout.fixed.horizontal
      },
      id = "container",
      left = dpi(8),
      right = dpi(8),
      widget = wibox.container.margin
    },
    bg = "#CAE9CA",
    fg = "#000000",
    --shape = function(cr, width, height)
     -- gears.shape.rounded_rect(cr, width, height, 5)
    --end,
    widget = wibox.container.background
  }


Hover_signal(clock_in, "#85EA6D")







return clock_in
end
