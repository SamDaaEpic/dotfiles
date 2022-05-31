--------------------------------
-- This is the battery widget --
--------------------------------

-- Awesome Libs
local awful = require("awful")
local dpi = require("beautiful").xresources.apply_dpi
local gears = require("gears")
local naughty = require("naughty")
local watch = awful.widget.watch
local wibox = require("wibox")
require("conf.core.signals")

-- Icon directory path
local icondir = awful.util.getdir("config") .. "conf/icons/battery/"

-- Returns the battery widget
return function()
   local   battery_widget = wibox.widget {
        {
            {
                {
                    {
                        {
                            id = "icon",
                            widget = wibox.widget.imagebox,
                        },
                        id = "icon_layout",
                        widget = wibox.container.place
                    },
                    id = "icon_margin",
                    top = dpi(2),
                    widget = wibox.container.margin
                },
                spacing = dpi(10),
                {
                    visible = false,
                    align = 'center',
                    valign = 'center',
                    id = "label",
                    widget = wibox.widget.textbox
                },
                id = "battery_layout",
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
          --  gears.shape.rounded_rect(cr, width, height, 5)
        --end,
        widget = wibox.container.background
    }


    local last_battery_check = os.time()
    local notify_critical_battery = true

    local battery_warning = function()
        naughty.notify({
            icon = gears.color.recolor_image(icondir .. "battery-alert.png", color["White"]),
            app_name = "System notification",
            title = "Battery is low",
            message = "Battery is almost battery_labelempty",
            urgency = "critical"
        })
    end

    local update_battery = function(status)
        awful.spawn.easy_async_with_shell(
            [[sh -c "upower -i $(upower -e | grep BAT) | grep percentage | awk '{print \$2}' |tr -d '\n%'"]],
            function(stdout)
                local battery_percentage = tonumber(stdout)
                if not battery_percentage then
                    return
                end
                battery_widget.container.battery_layout.spacing = dpi(5)
                battery_widget.container.battery_layout.label.visible = true
                battery_widget.container.battery_layout.label:set_text(math.ceil(battery_percentage) .. '%')
                local icon = 'battery'
                if status == 'fully-charged' or status == 'charging' and battery_percentage == 100 then
                    icon = icon .. '-' .. 'charging'
                    battery_widget.container.battery_layout.icon_margin.icon_layout.icon:set_image(gears.surface.load_uncached(icondir .. icon .. '.png'))
                    return
                end
                if battery_percentage > 0 and battery_percentage < 10 and status == 'discharging' then
                    icon = icon .. '-' .. 'alert'
                    if (os.difftime(os.time(), last_battery_check) > 300 or notify_critical_battery) then
                        last_battery_check = os.time()
                        notify_critical_battery = false
                        battery_warning()
                    end
                    battery_widget.container.battery_layout.icon_margin.icon_layout.icon:set_image(gears.surface.load_uncached(icondir .. icon .. '.png'))
                    return
                end

                if battery_percentage > 0 and battery_percentage < 10 then
                    icon = icon .. '-' .. status .. '-' .. 'outline'
                elseif battery_percentage >= 10 and battery_percentage < 20 then
                    icon = icon .. '-' .. '10' .. '-' .. status
                elseif battery_percentage >= 20 and battery_percentage < 30 then
                    icon = icon .. '-' .. '20' .. '-' .. status
                elseif battery_percentage >= 30 and battery_percentage < 40 then
                    icon = icon .. '-' .. '30' .. '-' .. status
                elseif battery_percentage >= 40 and battery_percentage < 50 then
                    icon = icon .. '-' .. '40' .. '-' .. status
                elseif battery_percentage >= 50 and battery_percentage < 60 then
                    icon = icon .. '-' .. '50' .. '-' .. status
                elseif battery_percentage >= 60 and battery_percentage < 70 then
                    icon = icon .. '-' .. '60' .. '-' .. status
                elseif battery_percentage >= 70 and battery_percentage < 80 then
                    icon = icon .. '-' .. '70' .. '-' .. status
                elseif battery_percentage >= 80 and battery_percentage < 90 then
                    icon = icon .. '-' .. '80' .. '-' .. status
                elseif battery_percentage >= 90 and battery_percentage < 100 then
                    icon = icon .. '-' .. '90' .. '-' .. status
                end

                battery_widget.container.battery_layout.icon_margin.icon_layout.icon:set_image(gears.surface.load_uncached(icondir .. icon .. '.png'))

            end
        )
    end

    Hover_signal(battery_widget, "#85EA6D")





        battery_widget:connect_signal("button::press", function(_,_,_,button)
            if (button == 1) then awful.spawn("xfce4-power-manager-settings") end
        end)
        battery_widget:connect_signal("button::press", function(_,_,_,button)
if (button == 3) then		    
        awful.spawn.easy_async_with_shell(
            [[ upower -i $(upower -e | grep BAT) | grep "time to " ]],
            function(stdout)

                local rem_time = ""
                if stdout:match("hour") then
                    rem_time = "Hours"
             	  else
                    rem_time = "Minutes"
                end
            local bat_time = stdout:match("%d+,%d") or stdout:match("%d+.%d") or ""

	if stdout:match("empty") then
		naughty.notify { title = "Remaining battery time: " .. math.ceil(bat_time) .. " " .. rem_time,
				height = 28
				}
	elseif stdout:match("time to full") then
		naughty.notify { title =  "Battery fully charged in: " .. math.ceil(bat_time) .. " " .. rem_time,
				height = 28,
				}
	end

end)


        awful.spawn.easy_async_with_shell(
            [[ upower -i $(upower -e | grep BAT) | grep "percentage" ]],
            function(stdout)
	if stdout:match("100") then
	naughty.notify{	title = "Your Battery Is Fully Charged"	}
	end
	    end)
end
        end)
   -- battery_widget:connect_signal(
     --   'button::press',
       -- function()
         --   awful.spawn("xfce4-power-manager-settings")
        --end
    --)


    watch(
        [[sh -c "upower -i $(upower -e | grep BAT) | grep state | awk '{print \$2}' | tr -d '\n'"]],
        5,
        function(widget, stdout)
            local status = stdout:gsub('%\n', '')
            if status == nil or status == '' then
                battery_widget.container.battery_layout.spacing = dpi(0)
                battery_widget.container.battery_layout.label.visible = false
               -- battery_tooltip:set_text('No battery found')
                battery_widget.container.battery_layout.icon_margin.icon_layout.icon:set_image(gears.surface.load_uncached(gears.color.recolor_image(icondir .. 'battery-off' .. '.png')))
            end
            update_battery(status)
        end
    )

    return battery_widget
end
