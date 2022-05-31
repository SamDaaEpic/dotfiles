local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
require("conf.bar.widgets.taglist")
require("conf.bar.widgets.tasklist")
local arch_logo = require("conf.bar.widgets.arch_logo")
local systray = require("conf.bar.widgets.systray")
local clock_in = require("conf.bar.widgets.clock_in")
local battery_widget = require("conf.bar.widgets.battery")
local audio_widget = require("conf.bar.widgets.audio")
local wifi_widget = require("conf.bar.widgets.wifi")
local bluetooth_widget = require("conf.bar.widgets.bluetooth")
local signals = require("conf.core.signals")

terminal = "alacritty"

left_bar = awful.popup {
	widget = wibox.container.background,
 	position = "bottom",
  	maximum_height = 30,
  	bg = "00000000",
	screen = s, 
}

center_bar = awful.popup ({
	widget = wibox.container.background,
	position  = "bottom",
	bg = "#CAE9CA",
	minimum_height = 30,
	minimum_width = 193,
	opacity = 0,
	screen = s,
    	shape = function(cr, width, height)
     	gears.shape.rounded_rect(cr, width, height, 12)
    	end,
})


right_bar = awful.popup ({
	widget = wibox.container.background,
	position  = "bottom",
	bg = "#CAE9CA",
	minimum_height = 30,
	maximum_width = 323,
	screen = s,
	shape = gears.shape.rounded_rect,
})

left_bar.x = 30
left_bar.y = 848
center_bar.x = 624
center_bar.y = 848
right_bar.x = 1093
right_bar.y = 848

    left_bar:struts {
	bottom = 45
    }

    center_bar:struts {
	bottom = 45
    }

    right_bar:struts {
	bottom = 45
    }

left_bar:setup {
widget = wibox.widget {
	-- Arch Logo Widget
	{ arch_logo(),
      	forced_width = 30,
      	widget = wibox.container.background,
     	shape = function(cr,w,h)
      		return gears.shape.rounded_rect(cr,w,h,12)
     	end
    	},
  
	-- Systray Widget
      	{ systray(),
	maximum_height = 20,
      	widget = wibox.container.background,
	shape = function(cr,w,h)
        	return gears.shape.rounded_rect(cr,w,h,12)
     	end
    	},

	-- Task List Widgets
    	{ task_list,
      	maximum_height = 35,
      	widget = wibox.container.background,
      	shape = function(cr,w,h)
        	return gears.shape.rounded_rect(cr,w,h,12)
      	end
    	},
    	widget = wibox.layout.fixed.horizontal,
    	spacing = 10, --gap size
  	},
}

    
center_bar:setup {
        layout = wibox.layout.align.horizontal,

	{
	tag_list,
	layout = wibox.layout.fixed.horizontal,
        },
    }


right_bar:setup {
        layout = wibox.layout.align.horizontal,
        { -- Right widgets
	-- Wifi widget
	wifi_widget(),
	-- Bluetooth widget
	bluetooth_widget(),
	-- Audio Widget
	audio_widget(),
	-- Battery Widget
	battery_widget(),
	-- Eastern Time Widget
	--clock_et,
	-- Indian Time Widget
	clock_in(),
	layout = wibox.layout.fixed.horizontal,
        },
    }
