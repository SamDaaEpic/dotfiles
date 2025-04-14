local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful").xresources.apply_dpi
local gears = require("gears")
local signals = require("conf.core.signals")
require("conf.core.icondir")
return function()


bluetooth_widget  = wibox.widget {
    {
      {
        {
          {
            {
              id = "icon",
	      image = icondir .. "bluetooth/bluetooth.svg",
	      forced_height = 25,
              widget = wibox.widget.imagebox,
            },
            id = "icon_layout",
            widget = wibox.container.place
          },
          top = dpi(2),
          widget = wibox.container.margin,
          id = "icon_margin"
        },
        spacing = dpi(10),
    
        id = "audio_layout",
        layout = wibox.layout.fixed.horizontal
      },
      id = "container",
      left = dpi(4),
      right = dpi(2),
      widget = wibox.container.margin
    },
    bg = "#B0DDB6",
    fg = "#000000",
    widget = wibox.container.background
}


Hover_signal(bluetooth_widget, "#85EA6D")
bluetooth_widget:connect_signal(
    "button::press",
    function()
	    awful.spawn("blueberry")
  end
)


return bluetooth_widget
end
