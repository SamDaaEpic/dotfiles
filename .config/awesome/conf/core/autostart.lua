local awful = require("awful")
--awful.spawn.with_shell("mpc clear; mpc load My-Fav-Songs")
--awful.spawn.with_shell("killall musnify-mpd && musnify-mpd")
--awful.spawn.with_shell("killall nm-applet; sleep 3; nm-applet")
awful.spawn.with_shell("killall lxpolkit; sleep 3; lxpolkit")
--awful.spawn.with_shell("nm-applet")
awful.spawn.with_shell("blueman-applet")
awful.spawn.with_shell("xfce4-power-manager")
awful.spawn.with_shell("picom")
awful.spawn.with_shell("killall flameshot; flameshot")
awful.spawn.with_shell("killall pasystray; sleep 3; pasystray")
--awful.spawn.with_shell("/usr/bin/emacs --daemon")
--awful.spawn.with_shell("picom")

