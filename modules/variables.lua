-- ██╗   ██╗ █████╗ ██████╗ ██╗ █████╗ ██████╗ ██╗     ███████╗███████╗
-- ██║   ██║██╔══██╗██╔══██╗██║██╔══██╗██╔══██╗██║     ██╔════╝██╔════╝
-- ██║   ██║███████║██████╔╝██║███████║██████╔╝██║     █████╗  ███████╗
-- ╚██╗ ██╔╝██╔══██║██╔══██╗██║██╔══██║██╔══██╗██║     ██╔══╝  ╚════██║
--  ╚████╔╝ ██║  ██║██║  ██║██║██║  ██║██████╔╝███████╗███████╗███████║
--   ╚═══╝  ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚══════╝╚══════╝

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

-- Themes define colours, icons, font and .
beautiful.init(".config/awesome/themes/default/theme.lua")

--- {{{ Global Variables }}} ---
terminal = "alacritty"
browser = "firefox"
filemanager = "thunar"
editor = terminal .. " --class nvim -o font.size=18 -e nvim"
microphone = "alsa_input.usb-Focusrite_Scarlett_2i2_USB-00.HiFi__Mic1__source"

--- Default modkey ---
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
	awful.layout.suit.tile.left,
	awful.layout.suit.tile,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.tile.top,
	awful.layout.suit.floating,
	awful.layout.suit.fair,
	awful.layout.suit.fair.horizontal,
	awful.layout.suit.spiral,
	awful.layout.suit.spiral.dwindle,
	awful.layout.suit.max,
	awful.layout.suit.max.fullscreen,
	awful.layout.suit.magnifier,
	awful.layout.suit.corner.nw,
	awful.layout.suit.corner.ne,
	awful.layout.suit.corner.sw,
	awful.layout.suit.corner.se,
}
