-- ██████╗ ██╗   ██╗██╗     ███████╗███████╗
-- ██╔══██╗██║   ██║██║     ██╔════╝██╔════╝
-- ██████╔╝██║   ██║██║     █████╗  ███████╗
-- ██╔══██╗██║   ██║██║     ██╔══╝  ╚════██║
-- ██║  ██║╚██████╔╝███████╗███████╗███████║
-- ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝╚══════╝

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Widget and layout library
local wibox = require("wibox")
-- local lain = require("lain")


-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
 
local menubar = require("menubar")

--####################################

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
                     placement = awful.placement.no_overlap + awful.placement.no_offscreen
                    }
    },

    --- {{{ Tag rules }}} ---

    --- 1 Monitor ---

    { -- 1 tag
        rule_any = { class = {
            "osu!",
            "RimWorldLinux",
            "steam_app_*",
            "Terraria.bin.x86_64",
            "gamescope"
        } },
        properties = { tag = screen[1].tags[1], screen = 1 }
    },

    { -- 2 tag
        rule_any = { class = {
            "v2rayN",
            "OpenTabletDriver.UX"
        } },
        properties = { tag = screen[1].tags[2], screen = 1 }
    },

    { -- 3 tag
        rule_any = { class = {
            "firefox"
        } },
        properties = { tag = screen[1].tags[3], screen = 1 }
    },

    { -- 4 tag
        rule_any = { class = {
            "jetbrains-rider",
            "Code"
        } },
        properties = { tag = screen[1].tags[4], screen = 1 }
    },

    { -- 5 tag
        rule_any = { class = {
            "Steam"  
        },
        name = {
            "Steam",
        }, },
        properties = { tag = screen[1].tags[5], screen = 1 }
    },

    --- 2 Monitor ---

    { -- 1 tag
        rule_any = { class = {
            "discord",
            "TelegramDesktop",
            "AyuGram",
        } },
        properties = { tag = screen[2].tags[1], screen = 2 }
    },

    { -- 2 tag
        rule_any = { class = {
            "TeamSpeak",
            "obs",
        } },
        properties = { tag = screen[2].tags[2], screen = 2 }
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
          "OpenTabletDriver.UX",
          "xtightvncviewer",
          "pavucontrol",
          "satty"
        },

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",
          "Friends List",
          "Geometry Dash"
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
            "Terraria.bin.x86_64",
            "satty",
            "gamescope"
        },
        name = {},
    }, properties = { fullscreen = true }},

    { rule_any = {
        instance = {},
        class = {
            "satty"
        },
        name = {
            "satty"
        },
    }, properties = { ontop = true }},

    --- Maximized clients ---
    { rule_any = {
        instance = {},
        class = { "          "},
        name = {},
    }, properties = { maximized = true }},

    --- Window size rules ---
    { -- 1200x1000
        rule_any = { class = {
            "OpenTabletDriver.UX"
        } },
        properties = {
            floating = true,
            width = 1200,
            height = 1000
            }
    },

    { -- 1920x1080
        rule_any = { class = {
            "     "
        } },
        properties = {
            floating = true,
            width = 1920,
            height = 1080
            }
    },



{
    rule = { class = "YandexMusic" },
    properties = {},
    callback = function(c)
        local last_tag = nil
        local minimize_timer = nil
        
        local function update_minimize_state()
            local current_tag = awful.screen.focused().selected_tag
            local is_on_current_tag = false
            
            -- Проверяем, есть ли окно на текущем теге
            for _, t in ipairs(c:tags()) do
                if t == current_tag then
                    is_on_current_tag = true
                    break
                end
            end
            
            if not is_on_current_tag then
                c.minimized = true
            else
                c.minimized = false
            end
            
            last_tag = current_tag
        end
        
        local function debounced_update()
            if minimize_timer then
                minimize_timer:stop()
            end
            
            minimize_timer = gears.timer {
                timeout = 0.1,
                single_shot = true,
                callback = update_minimize_state
            }
            minimize_timer:start()
        end
        
        -- Инициализация при создании окна
        update_minimize_state()
        
        -- Отслеживаем смену тегов окна
        c:connect_signal("property::tags", debounced_update)
        
        -- Отслеживаем смену активного тега
        tag.connect_signal("property::selected", function(t)
            if t.screen == c.screen then
                debounced_update()
            end
        end)
        
        -- Очистка при закрытии окна
        c:connect_signal("unmanage", function()
            if minimize_timer then
                minimize_timer:stop()
            end
        end)
    end
}



    
}