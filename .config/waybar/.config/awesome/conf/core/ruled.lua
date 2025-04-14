local awful = require("awful")
local gears = require("gears")
local ruled = require("ruled")
require("conf.bindings.keybindings")



-- Ruled
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = {-- border_width = beautiful.broder_width,
                    -- border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
		     border_width = 0,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

--Floating firefox download page
    {rule = {
	  class = "firefox",
	  name= "Library",
	}, properties = {floating =true, placement = awful.placement.centered}
    },

{rule = {
	  name= "Network Settings",
	}, properties = {floating =true, placement = awful.placement.centered, ontop = true}
    },
{rule = {
	  name= "Bluetooth",
	}, properties = {floating =true, placement = awful.placement.centered, ontop = true}
    },
--Floating authentication screen
     {rule = {
	  class = "Lxpolkit",
	  name= "Authentication",
	}, properties = {floating =true, placement = awful.placement.centered}
     },

--spawn firefox on tag WWW
     {rule = {
	  class = "firefox",
	  name= "Mozilla Firefox",
	}, properties = {tag = "WWW"}
     },


     {rule = {
	  class = "Lxpolkit",
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
	  name= "Authentication",
	}, properties = {floating =true, placement = awful.placement.centered}
     },


     {rule = {
	  class = "ArmCord",
	  name= "ArmCord",
	}, properties = {tag = "DISC"}
     },
 

     {rule = {
	  class = "Thunderbird",
	  name= "Mozilla Thunderbird",
	}, properties = {tag = "MAIL"}
     },


   {rule = {
	  class = "Terminator",
	  name= "Terminator Preferences",
	}, properties = {floating =true, placement = awful.placement.centered}
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
	  "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},


}
ruled.notification.connect_signal("request::rules", function()
    -- Add a red background for urgent notifications.
    ruled.notification.append_rule {
        rule       = { urgency = "critical" },
        properties = { bg = "#ff0000", fg = "#ffffff", timeout = 0 }
    }

    -- Or green background for normal ones.
    ruled.notification.append_rule {
        rule       = { urgency = "normal" },
        properties = { bg      = "#CAE9CA", fg = "#000000", icon_size = 60}
    }
end)

