-- ██╗    ██╗██╗██████╗  ██████╗ ███████╗████████╗███████╗
-- ██║    ██║██║██╔══██╗██╔════╝ ██╔════╝╚══██╔══╝██╔════╝
-- ██║ █╗ ██║██║██║  ██║██║  ███╗█████╗     ██║   ███████╗
-- ██║███╗██║██║██║  ██║██║   ██║██╔══╝     ██║   ╚════██║
-- ╚███╔███╔╝██║██████╔╝╚██████╔╝███████╗   ██║   ███████║
--  ╚══╝╚══╝ ╚═╝╚═════╝  ╚═════╝ ╚══════╝   ╚═╝   ╚══════╝

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Widget and layout library
local wibox = require("wibox")
-- local lain = require("lain")


-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

--####################################

--- {{{ My custom widgets }}} ---

--- System monitor widget ---
local sys_monitor = wibox.widget {
    {
        {
            id = 'sys_text',
            text = "System Monitor",
            font = "Google Sans Flex Medium 11",
            widget = wibox.widget.textbox
        },
        left = 10,
        right = 5,
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
                        "Cpu %s%%    %sGpu %s%% %s°C    Mem %s%%",
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

sub_menu_arrow = wibox.widget {
    text = " > ",
    font = "beautiful.font",
    widget = wibox.widget.textbox
}


--- Microphone widget ---
mic = "alsa_input.usb-Focusrite_Scarlett_2i2_USB-00.HiFi__Mic1__source"

-- Widget
local mic_widget = wibox.widget {
    {
        id = "icon",
        text = "(?)", -- начальное состояние
        widget = wibox.widget.textbox,
    },
    widget = wibox.container.margin,
    margins = 4,
}

-- Upd func
function update_mic()
    awful.spawn.easy_async_with_shell(
        "pactl list sources | grep -A 15 '"..mic.."' | grep Mute",
        function(stdout)
            local state = stdout:match("Mute: (%w+)")
            if state == "yes" then
                mic_widget.icon.text = "(X)" -- Off
                awful.spawn.with_shell("aplay /home/izunamori/.config/awesome/sounds/mute.wav")
            else
                mic_widget.icon.text = "(0)" -- On
                awful.spawn.with_shell("aplay /home/izunamori/.config/awesome/sounds/unmute.wav")
            end
        end
    )
end

update_mic()

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

--- {{{Notifications configuration}}} ---

-- STYLE / THEME (polished, modern look)

naughty.config.defaults.font                 = beautiful.font
naughty.config.defaults.fg                   = beautiful.fg_normal
naughty.config.defaults.bg                   = beautiful.bg_normal
naughty.config.defaults.border_color         = beautiful.border_focus
naughty.config.defaults.border_width         = 1
--naughty.config.defaults.shape                = function(cr, w, h)
--    gears.shape.rounded_rect(cr, w, h, 14)
--end
naughty.config.defaults.opacity              = 0.95

naughty.config.defaults.icon_size            = 56
naughty.config.defaults.icon_resize_strategy = "contain"

naughty.config.defaults.margin               = 16
naughty.config.defaults.padding              = 14
naughty.config.defaults.spacing              = 10

-- BEHAVIOR / UX (clean, non-intrusive)
naughty.config.defaults.position       = "top_right"
naughty.config.defaults.screen         = 2
naughty.config.defaults.ontop          = true
naughty.config.defaults.sticky         = true
naughty.config.defaults.ignore_suspend = false

naughty.config.defaults.timeout        = 10
naughty.config.defaults.hover_timeout  = 9999

naughty.config.defaults.max_width      = 600 --420
naughty.config.defaults.max_height     = 500 --220
naughty.config.defaults.width          = nil
naughty.config.defaults.height         = nil

naughty.config.defaults.urgency        = "normal"
naughty.config.defaults.replaces_id    = nil

-- presets for urgency levels
naughty.config.presets.low = {
    fg       = beautiful.fg_minimize,
    bg       = beautiful.bg_normal,
    timeout  = 3
}

naughty.config.presets.normal = {
    fg       = beautiful.fg_normal,
    bg       = beautiful.bg_normal,
    timeout  = 6
}

naughty.config.presets.critical = {
    fg           = beautiful.fg_urgent,
    bg           = beautiful.bg_urgent,
    border_color = beautiful.border_marked,
    timeout      = 0
}

--- Stable with picom lags fix ---
-- Сохраняем оригинальную notify
local original_notify = naughty.notify

-- Флаг блокировки
local notifications_blocked = false

-- Счётчик окон osu!
local open_osu = 0

-- Переопределяем notify через флаг
naughty.notify = function(args)
    if not notifications_blocked then
        return original_notify(args)
    end
end

-- Функции блокировки/разблокировки
local function block_for(c)
    if c.class == "osu!.exe" then
        open_osu = open_osu + 1
        notifications_blocked = true
    end
end

local function unblock_for(c)
    if c.class == "osu!.exe" then
        open_osu = open_osu - 1
        if open_osu <= 0 then
            open_osu = 0
            notifications_blocked = false
        end
    end
end

-- ⚠️ Используем глобальный client, не require
client.connect_signal("manage", block_for)
client.connect_signal("unmanage", unblock_for)

-- Проверка уже существующих окон через таймер
gears.timer {
    timeout = 1,
    single_shot = true,
    autostart = true,
    callback = function()
        for _, c in pairs(client.get()) do
            block_for(c)
        end
    end
}







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
    { "xprop", "alacritty -e sh -c 'xprop | grep -E \"(CLASS|WM_NAME|ROLE|WINDOW_TYPE)\"; read -p \"Press Enter to continue...\"'"},  
    { "Discord Update", terminal .. " -e /home/izunamori/.config/awesome/scripts/functional/discord_update.sh" },
    { "Full update", terminal .. " -e yay -Suy --ignore wireplumber --noconfirm" },
    { "Flatpak update", terminal .. " -e flatpak update"},
    { "git push conf", terminal .. " -e /home/izunamori/.config/awesome/scripts/functional/git_push_dotfiles.sh"},
}

programs = {
    { "Steam", "steam"},
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
menubar.utils.terminal = terminal
menubar.placement = "bottom"
 -- Set the terminal for applications that require it
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
        awful.tag({ "  ✦  ", "  ✦  ", "  >_  "  }, s, awful.layout.layouts[1])
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
    buttons = taglist_buttons,
    }


    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        buttons = tasklist_buttons,

        filter = function(c, screen)
            return awful.widget.tasklist.filter.currenttags(c, screen)
        end,

        source = function()
            local clients = client.get()
            local filtered = {}
            for _, c in ipairs(clients) do
                if awful.widget.tasklist.filter.currenttags(c, s) then
                    table.insert(filtered, c)
                end
            end
            return gears.table.reverse(filtered)
        end,
    }




    -- Create the wibox
    s.mywibox = awful.wibar({
        position = "top",
        screen   = s,
        height   = 26
    })

    s.mywibox:struts {
        top = 26
    }

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
            mic_widget,
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
