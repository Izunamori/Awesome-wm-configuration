-- ██████╗ ██╗███╗   ██╗██████╗ ███████╗
-- ██╔══██╗██║████╗  ██║██╔══██╗██╔════╝
-- ██████╔╝██║██╔██╗ ██║██║  ██║███████╗
-- ██╔══██╗██║██║╚██╗██║██║  ██║╚════██║
-- ██████╔╝██║██║ ╚████║██████╔╝███████║
-- ╚═════╝ ╚═╝╚═╝  ╚═══╝╚═════╝ ╚══════╝

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

local hotkeys_popup = require("awful.hotkeys_popup")
-- require("awful.hotkeys_popup.keys")

local key_cooldown = 0.1  -- время задержки в секундах (300мс)
local active_keys = {} 

--####################################

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
    awful.key({ modkey, "Shift" }, "s", function () awful.util.spawn(".config/awesome/scripts/screenshots/maim.sh") end,
        {description = "| скриншот области", group = "Screenshots"}),
    awful.key({ modkey, "Shift" }, "f", function () awful.util.spawn("/home/izunamori/.config/awesome/scripts/screenshots/maim_fullscreen.sh") end,
        {description = "| скриншот всей рабочей области (все мониторы)", group = "Screenshots"}),

    --- programs/scripts ---
    awful.key({ modkey, "Shift" }, "w", function () awful.util.spawn(swap_wallpapers()) end, 
        {description = "| поменять обои", group = "Programs/scripts"}),
    awful.key({ modkey }, "b", function () awful.util.spawn(browser) end,
        {description = "| запустить Firefox", group = "Programs/scripts"}),
    awful.key({ modkey, "Mod1" }, "g", function () awful.util.spawn("/home/izunamori/.config/awesome/scripts/functional/gamma.sh") end,
        {description = "| поменять гамму монитора", group = "Programs/scripts"}),
    awful.key({ modkey }, "o", function () awful.util.spawn("/home/izunamori/.local/bin/lazertweaks %U") end,
        {description = "| запустить osu!Lazer", group = "Programs/scripts"}),
    awful.key({ modkey, "Mod1" }, "o", function () awful.util.spawn("/home/izunamori/Git/osu-winello/osu-wine") end,
        {description = "| запустить osu! (Wine)", group = "Programs/scripts"}),
    awful.key({ modkey, "Shift" }, "o", function () awful.util.spawn("otd-gui") end,
        {description = "| запустить OpenTabletDriver", group = "Programs/scripts"}),
    awful.key({ modkey, "Shift" }, "v", function () awful.util.spawn("v2rayn") end,
        {description = "| запустить V2RayN", group = "Programs/scripts"}),
    awful.key({ modkey, "Control", "Shift" }, "v", function () awful.util.spawn("/home/izunamori/.config/awesome/scripts/functional/kill_v2rayN") end,
        {description = "| убить процесс V2RayN", group = "Programs/scripts"}),
    awful.key({ modkey }, "c", function () awful.util.spawn(".config/awesome/scripts/functional/colorpicker.sh") end,
        {description = "| запустить Colorpicker", group = "Programs/scripts"}),
    awful.key({ modkey }, "e", function () awful.util.spawn(filemanager) end,
        {description = "| запустить файловый менеджер", group = "Programs/scripts"}),
    awful.key({ modkey }, "/", function () awful.util.spawn(editor) end,
        {description = "| запустить VS Code", group = "Programs/scripts"}),
    awful.key({ "Control", "Shift" }, "Escape", function () awful.util.spawn(terminal .. " -e btop") end,
        {description = "| запустить Btop (системный монитор)", group = "Programs/scripts"}),
    awful.key({ modkey, "Mod1" }, "r", function () awful.util.spawn("obs") end,
        {description = "| запустить OBS Studio", group = "Programs/scripts"}),
    awful.key({ modkey, "Shift" }, "p", function () awful.util.spawn("/home/izunamori/.config/awesome/scripts/functional/toggle_comp.sh") end,
        {description = "| выкл/вкл композитор", group = "Programs/scripts"}),

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
    awful.key({ "Mod1", "Mod4", "Control" }, "m", function () awful.util.spawn(browser .. " https://mail.yandex.ru/") end,
        {description = "| открыть Яндекс почту", group = "Sites"}),
    
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

    -- move
    awful.key({ "Control", "Mod1" }, "w", function (c) awful.client.swap.bydirection("up", c) end,
        {description = "| переместить окно вверх", group = "Window management"}),
    awful.key({ "Control", "Mod1" }, "a", function (c) awful.client.swap.bydirection("left", c) end,
        {description = "| переместить окно влево", group = "Window management"}),
    awful.key({ "Control", "Mod1" }, "s", function (c) awful.client.swap.bydirection("down", c) end,
        {description = "| переместить окно вниз", group = "Window management"}),
    awful.key({ "Control", "Mod1" }, "d", function (c) awful.client.swap.bydirection("right", c) end,
        {description = "| переместить окно вправо", group = "Window management"}),

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
    awful.key({ modkey, }, "Return", function () awful.spawn(terminal) awful.spawn("xkb-switch -s us") end,
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
        {description = "| свернуть окно", group = "Window management"}),

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
    awful.key({ modkey }, "a", function()
        awful.spawn("xkb-switch -s us", false)
        awful.spawn("rofi -show drun")
        -- menubar.show()
    end, {description = "| показать меню приложений", group = "Launcher"})

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