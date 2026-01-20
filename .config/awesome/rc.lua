-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- ██╗     ██╗██████╗ ███████╗
-- ██║     ██║██╔══██╗██╔════╝
-- ██║     ██║██████╔╝███████╗
-- ██║     ██║██╔══██╗╚════██║
-- ███████╗██║██████╔╝███████║
-- ╚══════╝╚═╝╚═════╝ ╚══════╝

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")
local lain = require("lain")


-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")


--   ####################################
--  ###################################### 
-- ######## {{{ END OF SECTION }}} ########
--  ######################################
--   ####################################





-- ██╗   ██╗ █████╗ ██████╗ ██╗ █████╗ ██████╗ ██╗     ███████╗███████╗
-- ██║   ██║██╔══██╗██╔══██╗██║██╔══██╗██╔══██╗██║     ██╔════╝██╔════╝
-- ██║   ██║███████║██████╔╝██║███████║██████╔╝██║     █████╗  ███████╗
-- ╚██╗ ██╔╝██╔══██║██╔══██╗██║██╔══██║██╔══██╗██║     ██╔══╝  ╚════██║
--  ╚████╔╝ ██║  ██║██║  ██║██║██║  ██║██████╔╝███████╗███████╗███████║
--   ╚═══╝  ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚══════╝╚══════╝

-- Themes define colours, icons, font and .
beautiful.init(".config/awesome/themes/default/theme.lua")

--- {{{ Global Variables }}} ---
terminal = "alacritty"
browser = "firefox"
filemanager = "thunar"
editor = os.getenv("EDITOR") or "/home/izunamori/Documents/Apps/VSCode-linux-x64/code"

--- Default modkey ---
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile.left,
    awful.layout.suit.tile,
   -- awful.layout.suit.tile.bottom,
   -- awful.layout.suit.tile.top,
    awful.layout.suit.floating,
    awful.layout.suit.fair,
    --awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    --awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.magnifier,
    --awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}

--   ####################################
--  ###################################### 
-- ######## {{{ END OF SECTION }}} ########
--  ######################################
--   ####################################





-- ██╗    ██╗██╗██████╗  ██████╗ ███████╗████████╗███████╗
-- ██║    ██║██║██╔══██╗██╔════╝ ██╔════╝╚══██╔══╝██╔════╝
-- ██║ █╗ ██║██║██║  ██║██║  ███╗█████╗     ██║   ███████╗
-- ██║███╗██║██║██║  ██║██║   ██║██╔══╝     ██║   ╚════██║
-- ╚███╔███╔╝██║██████╔╝╚██████╔╝███████╗   ██║   ███████║
--  ╚══╝╚══╝ ╚═╝╚═════╝  ╚═════╝ ╚══════╝   ╚═╝   ╚══════╝

--- {{{ My custom widgets }}} ---

--- System monitor widget ---
local sys_monitor = wibox.widget {
    {
        {
            id = 'sys_text',
            text = "System Monitor",
            font = "beautiful.font",
            widget = wibox.widget.textbox
        },
        left = 10,
        right = 10,
        widget = wibox.container.margin
    },
    widget = wibox.container.background
}

local function update_sys_monitor()
    local cpu_cmd = [[bash -c "top -bn1 | grep 'Cpu(s)' | awk '{print $2+$4}' | cut -d'.' -f1"]]
    local cpu_temp_cmd = [[bash -c "sensors | grep -E '(Package id|Core 0)' | head -1 | awk '{print \$4}' | tr -d '+°C'"]]
    local gpu_cmd = [[bash -c "nvidia-smi --query-gpu=utilization.gpu,temperature.gpu --format=csv,noheader,nounits 2>/dev/null || echo '0,0'"]]
    local ram_cmd = [[bash -c "free | grep Mem | awk '{printf \"%.0f\", \$3/\$2 * 100.0}'"]]
    
    awful.spawn.easy_async(cpu_cmd, function(cpu_usage)
        local cpu = cpu_usage:gsub("%s+", "")
        cpu = cpu:match("%d+") or "0"
        
        awful.spawn.easy_async(cpu_temp_cmd, function(cpu_temp)
            
            awful.spawn.easy_async(gpu_cmd, function(gpu_data)
                local gpu_load, gpu_temp = "0", "0"
                if gpu_data then
                    gpu_load, gpu_temp = gpu_data:match("([^,]+),([^,]+)")
                    gpu_load = gpu_load:gsub("%s+", "") or "0"
                    gpu_temp = gpu_temp:gsub("%s+", "") or "0"
                end
                
                awful.spawn.easy_async(ram_cmd, function(ram_usage)
                    local ram = ram_usage:gsub("%s+", "")
                    ram = ram:match("%d+") or "0"
                                        
                    local text = string.format(
                        "( Cpu %s%%    %sGpu %s%% %s°C    Mem %s%% )",
                        cpu, cpu_temp, gpu_load, gpu_temp, ram
                    )
                    
                    sys_monitor:get_children_by_id('sys_text')[1]:set_text(text)
                end)
            end)
        end)
    end)
end

local sys_timer = gears.timer({
    timeout = 1,
    call_now = true,
    autostart = true,
    callback = update_sys_monitor
})

--- Pipe separator ---
tbox_separator = wibox.widget {
    text = " | ",
    font = "beautiful.font",
    widget = wibox.widget.textbox
}

--- Space separator ---
space_separator = wibox.widget {
    text = "  ",
    font = "beautiful.font",
    widget = wibox.widget.textbox
}

--- {{{ Other widgets }}} ---

local cmus = require "awesome-wm-widgets.cmus-widget.cmus"
local logout_menu_widget = require "awesome-wm-widgets.logout-menu-widget.logout-menu"
local volume_widget = require('awesome-wm-widgets.volume-widget.volume')
local ram_widget = require("awesome-wm-widgets.ram-widget.ram-widget")
local cpu_widget = require("awesome-wm-widgets.cpu-widget.cpu-widget")
local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")

local hotkeys_popup = require("awful.hotkeys_popup")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

scripts = {
    { "xprop", "alacritty -e sh -c 'xprop | grep -E \"(CLASS|WM_NAME|ROLE)\"; read -p \"Press Enter to continue...\"'"},  
    { "Discord Update", terminal .. " -e /home/izunamori/.config/awesome/scripts/discord_update.sh" },
    { "Full update", terminal .. " -e yay -Suy --ignore wireplumber --noconfirm" },
    { "Flatpak update", terminal .. " -e flatpak update"},
}

programs = {
    { "OBS-Studio", "obs"},
    { "Helvum", "helvum"},
}

mymainmenu = awful.menu({ items = { { "Awesome", myawesomemenu, beautiful.awesome_icon },                                    
                                    { "  Scripts", scripts },
                                    { "  Programs", programs },
                                    -- { "FGG", "chromium https://hub.f.gg/"},                                                                     
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibar 
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) 
                        t:view_only()
                        -- awful.screen.focus(t.screen)
                    end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

awful.screen.connect_for_each_screen(function(s)

    --- Tags ---
    if s.index == 1 then
        -- 1 Monitor
        awful.tag({ "  ✦  ", "  ✦  ", "  ✦  ", "  ✦  ", "  ✦  " }, s, awful.layout.layouts[1])
    else
        -- 1 Monitor (other monitors)
        awful.tag({ "  ✦  ", "  ✦  "  }, s, awful.layout.layouts[1])
    end

    --- {{{ Sys tray }}} ---
    
    --- Icons size ---
    local mysystray = wibox.widget.systray()
    mysystray:set_base_size(20)
    
    local centered_systray = wibox.container.place(mysystray)
    centered_systray.valign = "center"
    ------------------------

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    --- Add widgets to wibar ---
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            sys_monitor,
            mykeyboardlayout,
            mytextclock,
            calendar_widge,
            space_separator,
            centered_systray,
            space_separator,
            -- cpu_widget(),
            -- space_separator,
            -- ram_widget(),
            -- logout_menu_widget(),
        },
    }
end)

--   ####################################
--  ###################################### 
-- ######## {{{ END OF SECTION }}} ########
--  ######################################
--   ####################################





-- ██╗    ██╗ █████╗ ██╗     ██╗     ██████╗  █████╗ ██████╗ ███████╗██████╗ ███████╗
-- ██║    ██║██╔══██╗██║     ██║     ██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗██╔════╝
-- ██║ █╗ ██║███████║██║     ██║     ██████╔╝███████║██████╔╝█████╗  ██████╔╝███████╗
-- ██║███╗██║██╔══██║██║     ██║     ██╔═══╝ ██╔══██║██╔═══╝ ██╔══╝  ██╔══██╗╚════██║
-- ╚███╔███╔╝██║  ██║███████╗███████╗██║     ██║  ██║██║     ███████╗██║  ██║███████║
--  ╚══╝╚══╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝     ╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝╚══════╝

--- Default func for wallpapers ---                                      
local function set_wallpaper(s)
math.randomseed(os.time())
    -- Wallpaper
    if beautiful.wallpaper then
    
        local wallpaper = "/home/izunamori/Pictures/Wallpaper/1.png"
        
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.fit(wallpaper, s)
    end
end

---  Func for random wallpapers ---
local function set_rnd_wallpaper(s)
math.randomseed(os.time())
    -- Wallpaper
    if beautiful.wallpaper then
    
        local wallpaper = "/home/izunamori/Pictures/Wallpaper/osu/"..math.random(492)..""
        
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.fit(wallpaper, s)
    end
end

local function setup_wallpapers()
    awful.screen.connect_for_each_screen(function(s)
        if s.index == 1 then
                  set_rnd_wallpaper(s)
        else
            -- 1 Monitor (other monitors)
            set_wallpaper(s)
        end
    end)
end

local function setup_wallpapers_automatic()
    awful.screen.connect_for_each_screen(function(s)
        if s.index == 1 then
            -- 1 Monitor
            local wallpaper_timer = gears.timer {
              timeout = 60, 
              call_now = true, 
              autostart = true, 
              callback = function()
                  set_rnd_wallpaper(s)
              end
          }
        else
            -- 1 Monitor (other monitors)
            set_wallpaper(s)
        end
    end)
end

setup_wallpapers_automatic()

--   ####################################
--  ###################################### 
-- ######## {{{ END OF SECTION }}} ########
--  ######################################
--   ####################################





-- ██████╗ ██╗███╗   ██╗██████╗ ███████╗
-- ██╔══██╗██║████╗  ██║██╔══██╗██╔════╝
-- ██████╔╝██║██╔██╗ ██║██║  ██║███████╗
-- ██╔══██╗██║██║╚██╗██║██║  ██║╚════██║
-- ██████╔╝██║██║ ╚████║██████╔╝███████║
-- ╚═════╝ ╚═╝╚═╝  ╚═══╝╚═════╝ ╚══════╝

--- Mouse binds ---
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

--- Key binds ---
globalkeys = gears.table.join(

---------------- {{{ My (custom) key binds }}} ----------------

    --- screenshots ---
    awful.key({ modkey, "Shift" }, "s", function () awful.util.spawn(".config/awesome/scripts/maim.sh") end,
        {description = "| скриншот области", group = "Screenshots"}),
    awful.key({ modkey, "Shift" }, "f", function () awful.util.spawn("/home/izunamori/.config/awesome/scripts/maim_fullscreen.sh") end,
        {description = "| скриншот всей рабочей области (все мониторы)", group = "Screenshots"}),

    --- programs/scripts ---
    awful.key({ modkey, "Shift" }, "w", function () awful.util.spawn(setup_wallpapers()) end, 
        {description = "| поменять обои", group = "Programs/scripts"}),
    awful.key({ modkey }, "b", function () awful.util.spawn(browser) end,
        {description = "| запустить Firefox", group = "Programs/scripts"}),
    awful.key({ modkey, "Mod1" }, "g", function () awful.util.spawn("/home/izunamori/.config/awesome/scripts/gamma.sh") end,
        {description = "| поменять гамму монитора", group = "Programs/scripts"}),
    awful.key({ modkey }, "o", function () awful.util.spawn("/home/izunamori/.local/bin/lazertweaks %U") end,
        {description = "| запустить osu!Lazer", group = "Programs/scripts"}),
    awful.key({ modkey, "Mod1" }, "o", function () awful.util.spawn("/home/izunamori/Git/osu-winello/osu-wine") end,
        {description = "| запустить osu! (Wine)", group = "Programs/scripts"}),
    awful.key({ modkey, "Shift" }, "o", function () awful.util.spawn("otd-gui") end,
        {description = "| запустить OpenTabletDriver", group = "Programs/scripts"}),
    awful.key({ modkey, "Shift" }, "v", function () awful.util.spawn("v2rayn") end,
        {description = "| запустить V2RayN", group = "Programs/scripts"}),
    awful.key({ modkey, "Control", "Shift" }, "v", function () awful.util.spawn("/home/izunamori/.config/awesome/scripts/kill_v2rayN") end,
        {description = "| убить процесс V2RayN", group = "Programs/scripts"}),
    awful.key({ modkey }, "c", function () awful.util.spawn(".config/awesome/scripts/colorpicker.sh") end,
        {description = "| запустить Colorpicker", group = "Programs/scripts"}),
    awful.key({ modkey }, "e", function () awful.util.spawn(filemanager) end,
        {description = "| запустить файловый менеджер", group = "Programs/scripts"}),
    awful.key({ modkey }, "/", function () awful.util.spawn(editor) end,
        {description = "| запустить VS Code", group = "Programs/scripts"}),
    awful.key({ "Control", "Shift" }, "Escape", function () awful.util.spawn(terminal .. " -e btop") end,
        {description = "| запустить Btop (системный монитор)", group = "Programs/scripts"}),

    --- monitor focus swap ---
    awful.key({ modkey }, "Tab", function()
        local current = awful.screen.focused()
        local other_screen = nil
        
        for s in screen do
            if s ~= current then
                other_screen = s
                break
            end
        end
        
        if other_screen then
            awful.screen.focus(other_screen)
        else
            awful.screen.focus(screen[1])
        end
    end,
    {description = "| переключить фокус на другой монитор", group = "Window management"}),

    --- Sites ---
    awful.key({ "Mod1", "Mod4", "Control" }, "a", function () awful.util.spawn(browser .. " https://aur.archlinux.org/") end,
        {description = "| открыть AUR", group = "Sites"}),
    awful.key({ "Mod1", "Mod4", "Control" }, "t", function () awful.util.spawn(browser .. " https://translate.yandex.ru/") end,
        {description = "| открыть Переводчик", group = "Sites"}),
    awful.key({ "Mod1", "Mod4", "Control" }, "c", function () awful.util.spawn(browser .. " https://chatgpt.com/") end,
        {description = "| открыть ChatGPT", group = "Sites"}),
    awful.key({ "Mod1", "Mod4", "Control" }, "d", function () awful.util.spawn(browser .. " https://chat.deepseek.com/") end,
        {description = "| открыть DeepSeek", group = "Sites"}),
    awful.key({ "Mod1", "Mod4", "Control" }, "y", function () awful.util.spawn(browser .. " https://www.youtube.com/feed/playlists") end,
        {description = "| открыть YouTube", group = "Sites"}),
    awful.key({ "Mod1", "Mod4", "Control" }, "o", function () awful.util.spawn(browser .. " https://osu.ppy.sh/users/34742400") end,
        {description = "| открыть профиль osu!", group = "Sites"}),
    awful.key({ "Mod1", "Mod4", "Control" }, "g", function () awful.util.spawn(browser .. " https://github.com/") end,
        {description = "| открыть GitHub", group = "Sites"}),
    
    --- media ---
    awful.key({ }, "XF86AudioPlay", function () awful.util.spawn("playerctl play-pause") end,
        {description = "| воспроизвести/пауза", group = "Media"}),
    awful.key({ }, "XF86AudioNext", function () awful.util.spawn("playerctl next") end,
        {description = "| следующий трек", group = "Media"}),
    awful.key({ }, "XF86AudioPrev", function () awful.util.spawn("playerctl previous") end,
        {description = "| предыдущий трек", group = "Media"}),

    --- window management ---

    -- focus
    awful.key({ modkey, "Mod1" }, "w", function () awful.client.focus.bydirection("up") end,
        {description = "| фокус на окно выше", group = "Window management"}),
    awful.key({ modkey, "Mod1" }, "a", function () awful.client.focus.bydirection("left") end,
        {description = "| фокус на окно слева", group = "Window management"}),
    awful.key({ modkey, "Mod1" }, "s", function () awful.client.focus.bydirection("down") end,
        {description = "| фокус на окно ниже", group = "Window management"}),
    awful.key({ modkey, "Mod1" }, "d", function () awful.client.focus.bydirection("right") end,
        {description = "| фокус на окно справа", group = "Window management"}),

    -- resize
    awful.key({ modkey, "Control" }, "a", function () awful.tag.incmwfact(0.05) end,
        {description = "| увеличить ширину главного окна", group = "Window management"}),
    awful.key({ modkey, "Control" }, "d", function () awful.tag.incmwfact(-0.05) end,
        {description = "| уменьшить ширину главного окна", group = "Window management"}),

---------------------------------------------------------

    awful.key({ modkey, }, "h", hotkeys_popup.show_help,
        {description = "| показать горячие клавиши", group = "Awesome"}),
    awful.key({ modkey, }, "Left", awful.tag.viewprev,
        {description = "| предыдущий тег", group = "Tag"}),
    awful.key({ modkey, }, "Right", awful.tag.viewnext,
        {description = "| следующий тег", group = "Tag"}),
    awful.key({ modkey, }, "Escape", awful.tag.history.restore,
        {description = "| вернуться к предыдущему тегу", group = "Tag"}),

    awful.key({ "Mod1", }, "Tab",
        function ()
            awful.client.focus.byidx(1)
        end,
        {description = "| следующий клиент", group = "Window management"}
    ),
    -- awful.key({ modkey, }, "k",
    --     function ()
    --         awful.client.focus.byidx(-1)
    --     end,
    --     {description = "| предыдущий клиент", group = "Window management"}
    -- ),
    awful.key({ modkey, }, "w", function () mymainmenu:show() end,
        {description = "| показать главное меню", group = "Awesome"}),

    -- Standard program
    awful.key({ modkey, }, "Return", function () awful.spawn(terminal) end,
        {description = "| запустить терминал", group = "Programs/scripts"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
        {description = "| перезагрузить Awesome", group = "Awesome"}),

    awful.key({ modkey, "Control" }, "n",
        function ()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:emit_signal(
                    "request::activate", "key.unminimize", {raise = true}
                )
            end
        end,
        {description = "| восстановить свернутое окно", group = "Window management"}),

    -- Prompt
    awful.key({ modkey }, "p", function () awful.screen.focused().mypromptbox:run() end,
        {description = "| запустить команду", group = "Launcher"}),

    awful.key({ modkey, "Control", "Shift" }, "l",
        function ()
            awful.prompt.run {
                prompt = "Run Lua code: ",
                textbox = awful.screen.focused().mypromptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. "/history_eval"
            }
        end,
        {description = "| выполнить Lua код", group = "Awesome"}),

    -- Menubar
    awful.key({ modkey }, "a", function() menubar.show() end,
        {description = "| показать меню приложений", group = "Launcher"})

)

clientkeys = gears.table.join(
    awful.key({ modkey, }, "r",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "| переключить полноэкранный режим", group = "Window management"}),
    awful.key({ modkey, }, "q", function (c) c:kill() end,
        {description = "| закрыть окно", group = "Window management"}),
    awful.key({ modkey, }, "f", awful.client.floating.toggle,
        {description = "| переключить плавающий режим", group = "Window management"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
        {description = "| переместить в главное окно", group = "Window management"}),
    awful.key({ modkey, }, "o", function (c) c:move_to_screen() end,
        {description = "| переместить на другой экран", group = "Window management"}),
    awful.key({ modkey, }, "t", function (c) c.ontop = not c.ontop end,
        {description = "| переключить 'поверх всех окон'", group = "Window management"}),
    awful.key({ modkey, }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end,
        {description = "| свернуть окно", group = "Window management"}),
    awful.key({ modkey, }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end,
        {description = "| переключить максимизацию", group = "Window management"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end,
        {description = "| переключить вертикальную максимизацию", group = "Window management"}),
    awful.key({ modkey, "Shift" }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end,
        {description = "| переключить горизонтальную максимизацию", group = "Window management"})
)

-- Bind all key numbers to tags (1-5) - исправлено на 5 тегов
for i = 1, 5 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
            function ()
                local focused_screen = awful.screen.focused()
                local tag = focused_screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            {description = "| переключиться на тег", group = "Tag"}),
        
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
            function ()
                local focused_screen = awful.screen.focused()
                local tag = focused_screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            {description = "| показать/скрыть тег", group = "Tag"}),
        
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
            function ()
                if client.focus then
                    local focused_screen = awful.screen.focused()
                    local tag = focused_screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            {description = "| переместить окно на тег", group = "Tag"}),
        
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
            function ()
                if client.focus then
                    local focused_screen = awful.screen.focused()
                    local tag = focused_screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            {description = "| прикрепить/открепить окно к тегу", group = "Tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)

--   ####################################
--  ###################################### 
-- ######## {{{ END OF SECTION }}} ########
--  ######################################
--   ####################################





-- ██████╗ ██╗   ██╗██╗     ███████╗███████╗
-- ██╔══██╗██║   ██║██║     ██╔════╝██╔════╝
-- ██████╔╝██║   ██║██║     █████╗  ███████╗
-- ██╔══██╗██║   ██║██║     ██╔══╝  ╚════██║
-- ██║  ██║╚██████╔╝███████╗███████╗███████║
-- ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝╚══════╝

--- Rules for all clients ---

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     maximized = false,
                     maximized_horizontal = false,
                     maximized_vertical = false,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.centered -- +awful.placement.no_overlap+awful.placement.no_offscreen
                    }
    },

    --- {{{ Tag rules }}} ---

    --- 1 Monitor ---
    {
        rule = { class = "osu!" },
        properties = { tag = screen[1].tags[1], screen = 1 }
    },
    {
        rule = { class = "steam_app_*" },
        properties = { tag = screen[1].tags[1], screen = 1 }
    },
    {
        rule = { class = "v2rayN" },
        properties = { tag = screen[1].tags[2], screen = 1 }
    },
    {
        rule = { class = "obs" },
        properties = { tag = screen[1].tags[2], screen = 1 }
    },
    {
        rule = { class = "firefox" },
        properties = { tag = screen[1].tags[3], screen = 1 }
    },  
    {
        rule = { class = "jetbrains-rider" },
        properties = { tag = screen[1].tags[4], screen = 1 }
    },
    {
        rule = { class = "Code" },
        properties = { tag = screen[1].tags[4], screen = 1 }
    },
    {
        rule = { name = "Steam" },
        properties = { tag = screen[1].tags[5], screen = 1 }
    },
    {
        rule = { name = "Media viever" },
        properties = { tag = screen[1].tags[2], screen = 1 }
    },

    --- 2 Monitor ---
    {
        rule = { class = "discord", },
        properties = { tag = screen[2].tags[2], screen = 2 }
    },
    {
        rule = { class = "TeamSpeak", },
        properties = { tag = screen[2].tags[2], screen = 2 }
    },
    {
        rule = { class = "vesktop", },
        properties = { tag = screen[2].tags[2], screen = 2 }
    },
    {
        rule = { class = "TelegramDesktop" },
        properties = { tag = screen[2].tags[1], screen = 2 }
    },
    {
        rule = { class = "AyuGram" },
        properties = { tag = screen[2].tags[1], screen = 2 }
    },
    
    --- Floating clients ---
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "mpv",
          "v2rayN",  
          "Arandr",
          "ElyPrismLauncher", 
          "photoqt",
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
          "Event Tester",
          "Friends List",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
    }, properties = { floating = true }},

    --- Fullscreen clients ---
    { rule_any = {
        instance = {},
        class = {
            "PhotoQt",
            "imv",
        },
        name = {
            "Media viever",
        },
    }, properties = { fullscreen = true }},

    --- Maximized clients ---
    { rule_any = {
        instance = {},
        class = {
            "    ",
        },
        name = {
            "Media viever",
        },
    }, properties = { maximized = true }},
}

--   ####################################
--  ###################################### 
-- ######## {{{ END OF SECTION }}} ########
--  ######################################
--   ####################################





-- ███████╗██╗ ██████╗ ███╗   ██╗ █████╗ ██╗     ███████╗
-- ██╔════╝██║██╔════╝ ████╗  ██║██╔══██╗██║     ██╔════╝
-- ███████╗██║██║  ███╗██╔██╗ ██║███████║██║     ███████╗
-- ╚════██║██║██║   ██║██║╚██╗██║██╔══██║██║     ╚════██║
-- ███████║██║╚██████╔╝██║ ╚████║██║  ██║███████╗███████║
-- ╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝╚══════╝

-- Signal function to execute when a new client appears.
local urgent_exclude = {
    class = {
        AYUGRAMDESKTOP = true,
        DISCORD = true,
    },
    instance = {}
}

client.connect_signal("property::urgent", function(c)
    if not c.urgent then return end

    local class = c.class and string.upper(c.class)
    local instance = c.instance and string.upper(c.instance)

    if (class and urgent_exclude.class[class])
       or (instance and urgent_exclude.instance[instance]) then
        c.urgent = false
        return
    end

    local t = c.first_tag
    if t then
        awful.screen.focus(t.screen)
        t:view_only()
        c:emit_signal("request::activate", "urgent", { raise = true })
    end

    c.urgent = false
end)



-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

--- My signals ---
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
awful.spawn.with_shell("~/.config/awesome/scripts/autostart.sh")

--   ####################################
--  ###################################### 
-- ######## {{{ END OF SECTION }}} ########
--  ######################################
--   ####################################
