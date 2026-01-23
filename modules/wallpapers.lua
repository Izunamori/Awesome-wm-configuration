-- ██╗    ██╗ █████╗ ██╗     ██╗     ██████╗  █████╗ ██████╗ ███████╗██████╗ ███████╗
-- ██║    ██║██╔══██╗██║     ██║     ██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗██╔════╝
-- ██║ █╗ ██║███████║██║     ██║     ██████╔╝███████║██████╔╝█████╗  ██████╔╝███████╗
-- ██║███╗██║██╔══██║██║     ██║     ██╔═══╝ ██╔══██║██╔═══╝ ██╔══╝  ██╔══██╗╚════██║
-- ╚███╔███╔╝██║  ██║███████╗███████╗██║     ██║  ██║██║     ███████╗██║  ██║███████║
--  ╚══╝╚══╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝     ╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝╚══════╝

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

function swap_wallpapers()
    awful.screen.connect_for_each_screen(function(s)
        if s.index == 1 then
            set_rnd_wallpaper(s)
        else
            -- 1 Monitor (other monitors)
            set_wallpaper(s)
        end
    end)
end

local function setup_rnd_wallpapers()
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

local function setup_wallpapers()
    awful.screen.connect_for_each_screen(function(s)
        if s.index == 1 then
            set_wallpaper(s)
        else
            -- 1 Monitor (other monitors)
            set_wallpaper(s)
        end
    end)
end

setup_rnd_wallpapers()
-- setup_wallpapers()