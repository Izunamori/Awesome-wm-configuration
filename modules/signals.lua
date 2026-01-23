-- ███████╗██╗ ██████╗ ███╗   ██╗ █████╗ ██╗     ███████╗
-- ██╔════╝██║██╔════╝ ████╗  ██║██╔══██╗██║     ██╔════╝
-- ███████╗██║██║  ███╗██╔██╗ ██║███████║██║     ███████╗
-- ╚════██║██║██║   ██║██║╚██╗██║██╔══██║██║     ╚════██║
-- ███████║██║╚██████╔╝██║ ╚████║██║  ██║███████╗███████║
-- ╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝╚══════╝

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")
-- local lain = require("lain")


-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

--####################################

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

--- Centering windows ---
client.connect_signal("manage", function(c)
    if c.floating or awful.client.floating.get(c) then
        awful.placement.centered(c, {
            honor_workarea = true, 
            honor_padding = true  
        })
    end
end)

client.connect_signal("manage", function(c)
    if c.type == "utility" or c.type == "dialog" or c.type == "splash" then return end

    -- Telegram image viewer / override fullscreen windows
    if c.fullscreen or c.name == "Media viewer" or c.name == "Media viever" then
        local g = c.screen.geometry
        c.border_width = 0
        c.floating = false
        c.maximized = false
        c:geometry({
            x = g.x,
            y = g.y,
            width  = g.width,
            height = g.height
        })
    end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

--- My signals ---
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
awful.spawn.with_shell("~/.config/awesome/scripts/autostart.sh")