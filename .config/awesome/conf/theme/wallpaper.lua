local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

-- Select Wallpaper
gears.wallpaper.maximized("/home/SamDaaEpic/.config/awesome/conf/theme/wallpapers/Wallpaper36.jpg", s)

-- Wallpaper Function
local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Reset Wallpaer When Screen Resolution Changes
screen.connect_signal("property::geometry", set_wallpaper)

-- Set Wallaper
set_wallpaper(s)



