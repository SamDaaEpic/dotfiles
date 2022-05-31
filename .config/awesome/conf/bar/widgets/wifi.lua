local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful").xresources.apply_dpi
local gears = require("gears")
local signals = require("conf.core.signals")
require("conf.core.icondir")
return function()


wifi_widget  = wibox.widget {
    {
      {
        {
          {
            {
              id = "icon",
	      image = icondir .. "wifi/wifi.svg",
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
        spacing = dpi(10),
    
        id = "audio_layout",
        layout = wibox.layout.fixed.horizontal
      },
      id = "container",
      left = dpi(8),
      right = dpi(-1),
      widget = wibox.container.margin
    },
    bg = "#B0DDB6",
    fg = "#000000",
    widget = wibox.container.background
}


Hover_signal(wifi_widget, "#85EA6D")
wifi_widget:connect_signal(
    "button::press",
    function()
		    wifi_menu = awful.popup{
	widget = wibox.container.background,
	maximum_height = 10,
	maximum_width = 10,

		    }
		    wifi_menu.x = 100
  end
)


        
return wifi_widget
end
