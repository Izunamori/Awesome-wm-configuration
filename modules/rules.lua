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
            "steam_app_*"
        } },
        properties = { tag = screen[1].tags[1], screen = 1 }
    },

    { -- 2 tag
        rule_any = { class = {
            "v2rayN",
            "obs",
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
        } },
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
        name = {},
    }, properties = { fullscreen = true }},

    --- Maximized clients ---
    { rule_any = {
        instance = {},
        class = {},
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
}