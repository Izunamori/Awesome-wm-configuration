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
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			maximized = false,
			maximized_horizontal = false,
			maximized_vertical = false,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
		},
	},

	--- {{{ Tag rules }}} ---

	--- 1 Monitor ---

	{ -- 1 tag
		rule_any = {
			class = {
				"osu!",
				"RimWorldLinux",
				"steam_app_*",
				"Terraria.bin.x86_64",
				"gamescope",
				"factorio",
				"portal2_linux",
			},
		},
		properties = { tag = screen[1].tags[1], screen = 1 },
	},

	{ -- 2 tag
		rule_any = { class = {
			"v2rayN",
			"OpenTabletDriver.UX",
      "obsidian"
		} },
		properties = { tag = screen[1].tags[2], screen = 1 },
	},

	{ -- 3 tag
		rule_any = { class = {
			"firefox",
		} },
		properties = { tag = screen[1].tags[3], screen = 1 },
	},

	{ -- 4 tag
		rule_any = { class = {
			"jetbrains-rider",
			"Code",
			"nvim",
		} },
		properties = { tag = screen[1].tags[4], screen = 1 },
	},

	{ -- 5 tag
		rule_any = { class = {
			"Steam",
		}, name = {
			"Steam",
		} },
		properties = { tag = screen[1].tags[5], screen = 1 },
	},

	--- 2 Monitor ---

	{ -- 1 tag
		rule_any = {
			class = {
				"discord",
				"TelegramDesktop",
				"AyuGram",
				"vesktop",
			},
      name = {
        "Projector"
      }
		},
		properties = { tag = screen[2].tags[1], screen = 2 },
	},

	{ -- 2 tag
		rule_any = {
			class = {
				"TeamSpeak",
			},
      name = {
        "OBS"
      },
		},
		properties = { tag = screen[2].tags[2], screen = 2 },
	},

	{ -- 3 tag
		rule_any = {
			class = {
				"Nvidia-settings",
			},
		},
		properties = { tag = screen[2].tags[3], screen = 2 },
	},

	--- obs scene projector ------------
	{
		rule_any = {
			name = {
        "Projector"
			},
		},
		properties = { fullscreen = false },
	},
	------------------------------------

	--- Minimized clients ---
	{
		rule_any = {
			class = {
				"Nvidia-settings",
			},
		},
		properties = { minimized = true },
	},

	--- Floating clients ---
	{
		rule_any = {
			instance = {
				"DTA", -- Firefox addon DownThemAll.
				"copyq", -- Includes session name in class.
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
				"MessageWin", -- kalarm.
				"Sxiv",
				"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
				"Wpa_gui",
				"veromix",
				"OpenTabletDriver.UX",
				"xtightvncviewer",
				"pavucontrol",
				"satty",
				"qBittorrent",
				"Lutris",
				"firefox",
				"steam",
				"Throne",
			},

			-- Note that the name property shown in xprop might be set slightly after creation of the client
			-- and the name shown there might not match defined rules here.
			name = {
				"Event Tester",
				"Friends List",
				"Geometry Dash",
				"Steam Settings",
			},
			role = {
				"AlarmWindow", -- Thunderbird's calendar.
				"ConfigManager", -- Thunderbird's about:config.
				"pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
			},
		},
		properties = { floating = true },
	},

	--- Fullscreen clients ---
	{
		rule_any = {
			instance = {},
			class = {
				"PhotoQt",
				-- "imv",
				--"Terraria.bin.x86_64",
				"satty",
				"gamescope",
			},
			name = {},
		},
		properties = { fullscreen = true },
	},

	--- No border ---
	{
		rule_any = {
			instance = {},
			class = {
				"Terraria.bin.x86_64",
				"steam",
				"discord",
				"AyuGramDesktop",
			},
			name = {},
		},
		properties = { border_width = 0 },
	},

	--- Ontop ---
	{
		rule_any = {
			instance = {},
			class = {
				"satty",
			},
			name = {
				"satty",
			},
		},
		properties = { ontop = true },
	},

	--- Maximized clients ---
	{
		rule_any = {
			instance = {},
			class = {
				"Terraria.bin.x86_64      ",
			},
			name = {},
		},
		properties = { maximized = true },
	},

	{ -- tile clients override
		rule_any = {
			class = {
				"tile",
			},
			name = {},
		},
		properties = { floating = false },
	},

	{ -- 2240x1260
		rule_any = {
			class = {
				"firefox",
			},
			name = {},
		},
		properties = {
			floating = true,
			width = 2240,
			height = 1260,
		},
	},
	{ -- 2240x1260
		rule_any = {
			class = {
				"nvim",
			},
			name = {},
		},
		properties = {
			floating = true,
			width = 2350,
			height = 1260,
		},
	},
	{ -- 1920x1080
		rule_any = {
			class = {},
			name = {
				"Steam",
				"mpv",
			},
		},
		properties = {
			floating = true,
			width = 1920,
			height = 1080,
		},
	},
	{ -- 1200x1000
		rule_any = {
			class = {
				"OpenTabletDriver.UX",
			},
			name = {
				"Steam Settings",
			},
		},
		properties = {
			floating = true,
			width = 1200,
			height = 1000,
		},
	},
	{ -- 1000x800
		rule_any = {
			class = {
				"filemanager_float",
				"Thunar",
			},
			name = {},
		},
		properties = {
			floating = true,
			width = 1300,
			height = 800,
		},
	},
	{ -- 1000x600
		rule_any = {
			class = {
				"Alacritty",
			},
			name = {},
		},
		properties = {
			floating = true,
			width = 1000,
			height = 600,
		},
	},
	{ -- 800x600
		rule_any = {
			class = {
				"    ",
			},
			name = {},
		},
		properties = {
			floating = true,
			width = 800,
			height = 600,
		},
	},

	{ -- gaps ~18px
		rule = { class = "discord" },
		properties = {
			floating = true, -- нужно, чтобы можно было задать размер и позицию
			width = 1500,
			height = 1052,
			x = 0, -- позиция по X
			y = 308, -- позиция по Y
		},
	},
	{
		rule = { class = "AyuGramDesktop" },
		properties = {
			floating = true, -- нужно, чтобы можно было задать размер и позицию
			width = 420,
			height = 1052,
			x = 1500, -- позиция по X
			y = 308, -- позиция по Y
		},
	},

	-- { -- gaps ~18px
	--     rule = { class = "discord" },
	--     properties = {
	--         floating = true,        -- нужно, чтобы можно было задать размер и позицию
	--         width = 1463,
	--         height = 1017,
	--         x = 18,                -- позиция по X
	--         y = 325,                 -- позиция по Y
	--     }
	-- },
	-- {
	--     rule = { class = "AyuGramDesktop" },
	--     properties = {
	--         floating = true,        -- нужно, чтобы можно было задать размер и позицию
	--         width = 400,
	--         height = 1017,
	--         x = 1500,                -- позиция по X
	--         y = 325,                 -- позиция по Y
	--     }
	-- },
}
