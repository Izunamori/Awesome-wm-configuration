---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local shape = require("gears.shape")
local themes_path = gfs.get_themes_dir()

local theme = {}

theme.font          = "Google Sans Flex Medium 11"

theme.bg_normal     = "#0f0f0fff"
theme.bg_focus      = "#32323288"
theme.bg_urgent     = "#7f7f7f00"
theme.bg_minimize   = "#45454500"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#bdbdbdff"
theme.fg_focus      = "#ffffffff"
theme.fg_urgent     = "#bdbdbdff"
theme.fg_minimize   = "#797979ff"

theme.useless_gap   = dpi(2)
theme.border_width  = dpi(1)
theme.border_normal = "#1717177d"
theme.border_focus  = "#464646ff"
theme.border_marked = "#1717177d"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
theme.taglist_bg_focus = "#32323288"

-- Generate taglist squares:
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- theme.taglist_squares_sel   = "/home/izunamori/.config/awesome/themes/default/taglist/squarefw.png"
-- theme.taglist_squares_unsel = "/home/izunamori/.config/awesome/themes/default/taglist/squarew.png"

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = "~/.config/awesome/themes/default/submenu.png"
theme.menu_height = dpi(35)
theme.menu_width  = dpi(160)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = themes_path.."default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = themes_path.."default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path.."default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path.."default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path.."default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path.."default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path.."default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = themes_path.."default/titlebar/maximized_focus_active.png"

theme.wallpaper = "/home/izunamori/Pictures/Wallpaper/1.png"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

-- Hotkeys popup theme
theme.hotkeys_font             = "theme.font Bold 12"
theme.hotkeys_description_font = "theme.font"

theme.hotkeys_bg               = theme.bg_normal        -- тёмный фон
theme.hotkeys_fg               = theme.fg_normal        -- основной текст

theme.hotkeys_border_color     = "#454545ff"        -- рамка
theme.hotkeys_border_width     = 2

theme.hotkeys_modifiers_fg     = theme.fg_minimize        -- цвет модификаторов (Ctrl, Alt, Shift)
theme.hotkeys_label_bg         = "#bcc3ceff"        -- фон заголовка группы
theme.hotkeys_label_fg         = "#1e1e2e"        -- текст заголовка

theme.hotkeys_group_margin     = 20               -- отступ между группами
theme.hotkeys_group_spacing    = 8                -- расстояние между строками в группе
theme.hotkeys_label_margin     = 10                -- внутренний отступ ярлыка
theme.hotkeys_opacity          = 10             -- прозрачность

-- rounded corners
local gears = require("gears")
--theme.hotkeys_shape            = gears.shape.rounded_rect
--theme.hotkeys_label_shape      = gears.shape.rounded_rect

-- Generate Awesome icon:
theme.awesome_icon = "~/.config/awesome/themes/default/egor.png"


-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = Adwaita
return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80