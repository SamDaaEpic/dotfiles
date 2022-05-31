local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup")
require("conf.core.bin")
local battery_widget = require("conf.bar.widgets.battery")
------------------
-- Key Bindings --
------------------

modkey = "Mod4"

-- Global Key Bindings
globalkeys = gears.table.join(
	awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              	{description="show help", group="awesome"}),
    	
	awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              	{description = "view previous", group = "tag"}),
    	
	awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
             	{description = "view next", group = "tag"}),
    	
	awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              	{description = "go back", group = "tag"}),

    	awful.key({ modkey,           }, "j",	function ()
		awful.client.focus.byidx( 1) end,
        	{description = "focus next by index", group = "client"}),

    	awful.key({ modkey,           }, "k",	function ()
            	awful.client.focus.byidx(-1) end,
        	{description = "focus previous by index", group = "client"}),
    	
	awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              	{description = "show main menu", group = "awesome"}),


-- Layout manipulation
    	awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1) end,
              	{description = "swap with next client by index", group = "client"}),
    	
	awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1) end,
              	{description = "swap with previous client by index", group = "client"}),

	awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              	{description = "focus the next screen", group = "screen"}),
    	
	awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              	{description = "focus the previous screen", group = "screen"}),
    	
	awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              	{description = "jump to urgent client", group = "client"}),
   	
	awful.key({ modkey,           }, "Tab",	function ()
            	awful.client.focus.history.previous()
            	if client.focus then
                client.focus:raise()
            	end
       		end,
        	{description = "go back", group = "client"}),


-- Standard Default Awesome Program
    	awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              	{description = "open a terminal", group = "launcher"}),
    	
	awful.key({ modkey, "Control" }, "r", awesome.restart,
              	{description = "reload awesome", group = "awesome"}),
	
	
	awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              	{description = "quit awesome", group = "awesome"}),

    	awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05) end,
              	{description = "increase master width factor", group = "layout"}),
    	
	awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05) end,
              	{description = "decrease master width factor", group = "layout"}),
    	
	awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              	{description = "increase the number of master clients", group = "layout"}),
    	
	awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              	{description = "decrease the number of master clients", group = "layout"}),
    	
	awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true) end,
              	{description = "increase the number of columns", group = "layout"}),
    	
	awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true) end,
              	{description = "decrease the number of columns", group = "layout"}),
    	
	awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1) end,
              	{description = "select previous", group = "layout"}),

     	awful.key({ modkey, "Control" }, "n",
              	function ()
                  	local c = awful.client.restore()
                  	-- Focus restored client
              	    	if c then
                    	c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true})
                  	end
              		end,
              	{description = "restore minimized", group = "client"}),


	              ------------------------------
                      -- Application Key Bindings --
                      ------------------------------

	-- Mail (Thunderbird)
	awful.key({ modkey },            "u",     function ()
		awful.util.spawn("thunderbird") end,
              		{description = "thunderbird", group = "launcher"}),

	-- Take ScreenSHot(flameshot)	
	awful.key({ modkey, "Control"  },            "s",     function ()
		awful.util.spawn("flameshot full --path /home/SamDaaEpic/Pictures/") end,
			{description = "Take A screenshot", group = "launcher"}),

     	-- Rofi
    	awful.key({ modkey },            "r",     function ()
		awful.util.spawn("rofi -no-lazy-grab -show drun -modi drun -theme ~/.config/rofi/launchers/colorful/style_9.rasi") end,
              		{description = "rofi run promt", group = "launcher"}),
    
	-- SamDaaEpic's Config
	awful.key({ modkey, "Control", "Shift" }, "m", function()
		awful.util.spawn(bin .. "my_conf") end,
		awesome.restart,
              	{description = "load normal config", group = "awesome"}),
	
	-- Default Config
	awful.key({ modkey, "Control", "Shift" }, "d", function()
		awful.util.spawn(bin .. "def_conf") end,
		awesome.restart,
              	{description = "load default config", group = "awesome"}),

	-- Chromium
        awful.key({ modkey },            "b",     function ()
        	awful.util.spawn("chromium") end,
              		{description = "Bave Shortcut", group = "launcher"}),

	-- Discord
        awful.key({ modkey },            "d",     function ()
		awful.util.spawn("discord") end,
              		{description = "Discord Shortcut", group = "launcher"}),

	-- Minecraft
        awful.key({ modkey, "Control", },    "m",     function ()
		awful.util.spawn("/home/SamDaaEpic/.config/startmc.sh") end,
              		{description = "Thuar File Manager  Shortcut", group = "launcher"}),
	-- Rhythem box
        awful.key({ modkey, "Control",  },    "Return",     function ()
                awful.util.spawn("rhythmbox") end,
              		{description = "Thuar File Manager  Shortcut", group = "launcher"}),
	-- Thunar File Manager
        awful.key({ modkey, },    "Delete",     function ()
                awful.util.spawn("thunar") end,
              		{description = "Thuar File Manager  Shortcut", group = "launcher"}),

	-- Doom Emacs 
        awful.key({ modkey, },    "e",     function ()
        	awful.util.spawn("emacsclient -c -a 'emacs'") end,
              		{description = "Launch Doom Emacs", group = "launcher"}),

	-- Get color codes
        awful.key({ modkey, },    "Tab",     function ()
        	awful.util.spawn("xcolor-pick") end,
              		{description = "Thuar File Manager  Shortcut", group = "launcher"}),
	  
	-- Get color codes
        awful.key({ modkey, "Control", "Shift", },    "s",     function ()
        	awful.util.spawn("flameshot gui") end,
              		{description = "Flameshot GUI Shortcut", group = "launcher"}),

		      -------------------------------------
                      -- Keyboard MultiMedia Keybindings --
                      -------------------------------------

	-- Brightness decrease
	awful.key({ }, "XF86MonBrightnessDown", function ()
   		awful.util.spawn("brightnessctl s 2500-", false) end),
     
	-- Brightness increase	
	awful.key({ }, "XF86MonBrightnessUp", function ()
   		awful.util.spawn("brightnessctl s +2500", false) end),
	
	-- Keyboard Backlight decrease
	awful.key({ }, "XF86KbdBrightnessDown", function ()
   		awful.util.spawn("brightnessctl --device='smc::kbd_backlight' set 30-", false ) end),

	-- Keyboard Brightness increase	
	awful.key({ }, "XF86KbdBrightnessUp", function ()
		awful.util.spawn("brightnessctl --device='smc::kbd_backlight' set +30", false) end),	
	
	-- Toggle Sink
	awful.key({modkey, "Control", }, "t", function ()
		awful.spawn.easy_async_with_shell(
            	bin .. [["toggle_sink" && pactl get-default-sink ]],
            		function(stdout)
				if stdout:match("bluez") then 
					bluetooth = naughty.notification { title = "Sink: Bluetooth", height = 30 }
					speakers:destroy()
				elseif stdout:match("alsa") then
					speakers = naughty.notification { title = "Sink: Speakers", height = 30 }
					bluetooth:destroy()
				end
		end)

	end),

	-- Volume Increase
	awful.key({ }, "XF86AudioRaiseVolume", function ()
       		awful.util.spawn("amixer -D pulse set Master 9%+", false) end),

	-- Volume Decrease
   	awful.key({ }, "XF86AudioLowerVolume", function ()
       		awful.util.spawn("amixer -D pulse set Master 9%-", false) end),
	
	-- Mute Audio
   	awful.key({ }, "XF86AudioMute", function ()
       		awful.util.spawn("amixer -D pulse set Master toggle", false) end),

	-- Play-Pause MPD Music
	awful.key({ }, "XF86AudioPlay", function () awful.util.spawn("mpc toggle", false) end),

	-- Play-next MPD Music
	awful.key({ }, "XF86AudioNext", function () awful.util.spawn("mpc next", false) end),

	-- Play-previous MPD Music
	awful.key({ }, "XF86AudioPrev", function () awful.util.spawn("mpc prev", false) end),

			-------------------------------
			-- Miscilanious Key Bindings --
			-------------------------------

    	-- Menubar
    	awful.key({ modkey }, "q", function() menubar.show() end,
              	{description = "show the menubar", group = "launcher"}))

	clientkeys = gears.table.join(
    	awful.key({ modkey,           }, "f",
        	function (c)
            	c.fullscreen = not c.fullscreen
            	c:raise()
	
        	end,
        	{description = "toggle fullscrieen", group = "client"}),
    	awful.key({ modkey,           }, "o",    function (c) c:kill() end,
              	{description = "close", group = "client"}),
    
	awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle,
              	{description = "toggle floating", group = "client"}),
    
	awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              	{description = "move to master", group = "client"}),
    
	awful.key({ modkey,           }, "o",      function (c) c:move_to_screen() end,
              	{description = "move to screen", group = "client"}),
    
	awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop end,
              	{description = "toggle keep on top", group = "client"}),
    
	awful.key({ modkey,           }, "n",
        	function (c)
            	c.minimized = true
        	end,
        	{description = "minimize", group = "client"}),
    	
	awful.key({ modkey,           }, "m",
        	function (c)
            	c.maximized = not c.maximized
            	c:raise()
        	end,
        	{description = "(un)maximize", group = "client"}),
    
	awful.key({ modkey, "Control" }, "m",
        	function (c)
            	c.maximized_vertical = not c.maximized_vertical
            	c:raise()
        	end,
        	{description = "(un)maximize vertically", group = "client"}),
    	awful.key({ modkey, "Shift"   }, "m",
        	function (c)
            	c.maximized_horizontal = not c.maximized_horizontal
            	c:raise()
        	end,
        	{description = "(un)maximize horizontally", group = "client"}))

-- Switching Between Tags (1-9)
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

-- Controlling Windows with Mouse
clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey, "Control" }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
       awful.mouse.client.resize(c)
    end)
)

root.keys(globalkeys)
