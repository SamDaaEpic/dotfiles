-- Awesome Libs
local awful = require("awful")
local dpi = require("beautiful").xresources.apply_dpi
local gears = require("gears")
local wibox = require("wibox")

require("conf.core.signals")

return function(s)
  local systray = wibox.widget {
    {
      {
        wibox.widget.systray(),
        widget = wibox.container.margin,
        id = 'st'
      },
      strategy = "exact",
      layout = wibox.container.constraint,
      id = "container"
    },
    widget = wibox.container.background,
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 5)
    end,
    bg = "#CAE9CA"
  }

  awesome.connect_signal("systray::update", function()
    local num_entries = awesome.systray()

    if num_entries == 0 then
      systray.container.st:set_margins(0)
    else
      systray.container.st:set_margins(dpi(3.4))
    end
  end)

  systray.container.st.widget:set_base_size(dpi(20))

  return systray
end
