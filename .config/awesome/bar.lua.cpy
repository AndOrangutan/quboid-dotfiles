-- vim:foldmethod=marker
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

local gears     = require("gears")
local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
--local naughty   = require("naughty")
local menubar   = require("menubar")
local dpi = require("beautiful.xresources").apply_dpi

local bar_margin = dpi(16)
local bar_border = dpi(1)
-- Modules
lain = require("lain")

-- Space savings
local markup = lain.util.markup

-- {{{ Menu
--mymainmenu = awful.menu({
--    items = {
--        { " ﲵ  Open terminal", terminal },
--        { "   Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
--        { " ﴬ  Manual", terminal .. " -e man awesome" },
--        { " פֿ  Edit config", editor_cmd .. " " .. awesome.conffile },
--        { " ﰇ  Restart", awesome.restart },
--        { " 窱 Quit", function() awesome.quit() end },
--    }
--})
--mymainmenu.wibox.shape = function (cr, w, h)
--    local t = 10000
--    gears.shape.rounded_rect(cr, t, h, corn_radius)
--end

-- Launcher Icon that uses mymainmenu

-- }}}

-- {{{ Taglist
local taglist_buttons = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
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
-- }}}

-- {{{ Clock and Date
mytextclock = wibox.widget {
    {
        id = "clock",
        widget = wibox.widget.textclock("%m/%d/%y %H:%M")
    },
    widget = wibox.container.margin,
    left = 8,
    right = 8,
    shape = gears.shape.rounded_bar
--    widget:set_markup(markup.fontfg(theme.font, theme.blue,))
}
-- }}}

-- {{{ Pacage Updates
pacupdates = awful.widget.watch( 'bash -c "checkupdates | wc -l"', 60,
    function(widget, stdout)
        local opvar = stdout
        local color = "#ffaf5f"
        if stdout == "" then
            opvar = "0"
        else
--            color = red
        end
        widget:set_markup(markup.fontfg("Nerd Font Hack Mono", color, "  " .. opvar .. " "))

        return
    end)
-- }}}

-- {{{ Battery
mybattery = lain.widget.bat{
    battery = "CMB0",
    settings = function()
        battery = "CMB0"
        widget:set_markup(markup.fontfg("Nerd Font Hack Mono", "#ffffff", "bat " .. bat_now.perc))
    end,
    style = {
        shape = gears.shape.rounded_bar
    },
}
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

---- Enable scroll wheel against the top of the screen to change tag view
--local top_of_screen_buttons = gears.table.join(
--    awful.button(
--        {},
--        5,
--        function(t)
--            awful.tag.viewnext(t.screen)
--        end
--    ),
--    awful.button(
--        {},
--        4,
--        function(t)
--            awful.tag.viewprev(t.screen)
--        end
--    )
--)

awful.screen.connect_for_each_screen(function(s)

    -- {{{ Per-screen widgets

    -- Each screen has its own tag table.
    tags = {
        names = { "", "", "", "", "", "", "", "", ""  },
        layouts = { awful.layout.suit.tile, awful.layout.suit.tile, awful.layout.suit.tile, awful.layout.suit.tile, awful.layout.suit.tile, awful.layout.suit.tile, awful.layout.suit.tile, awful.layout.suit.tile, awful.layout.suit.tile }
    }
--    for s = 1, screen_count() do
--        -- Each screen has its own tag table.
--    tags[s] = awful.tag(tags.names, s, tags.layout)

    tags[1] = awful.tag(tags.names, s, tags.layouts)
    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({ }, 1, function () awful.layout.inc( 1) end),
        awful.button({ }, 3, function () awful.layout.inc(-1) end),
        awful.button({ }, 4, function () awful.layout.inc( 1) end),
        awful.button({ }, 5, function () awful.layout.inc(-1) end)
        )
    )
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        style = {
            shape = gears.shape.rounded_bar
        },
        layout = {
            spacing = 0,
            spacing_widget = {
                color = beautiful.yellow,
                shape = gears.shape.rounded_bar
            },
            layout = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                {
                    {
                        bg = beautiful.yellow,
                        shape = '',
                        widget = wibox.container.background,
                    },
                    {
                        {
                            id = 'icon_role',
                            widget = wibox.widget.imagebox,
                        },
                        margins = 0,
                        widget = wibox.container.margin,
                    },
                    {
                        id = 'text_role',
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.align.horizontal,
                },
                left = 10,
                right = 10,
                widget = wibox.container.margin
            },
            id = 'background_role',
            widget = wibox.container.background
        }
    }

    -- Create simple separator widget
    separator = wibox.widget.textbox(" ")

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        style   = {
            bg_normal   = gears.color.transparent,
            fg_normal   = beautiful.dwhite,
            bg_focus    = beautiful.magenta,
            fg_focus    = beautiful.grey,
            bg_urgent   = beautiful.red,
            fg_urgent   = beautiful.grey,
            font        = beautiful.fonti,
            shape       = gears.shape.rounded_bar,
        },
        layout  = {
            spacing_widget = {
                {
                    forced_width    = 5,
                    forced_height   = 24,
                    thickness       = 1,
                    color           = beautiful.yellow,
                    widget          = separator
                },
                valign = "center",
                halign = "center",
                widget = wibox.container.place,
            },
            spacing = 48,
            layout  = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                {
                    {
                        {
                            id     = 'icon_role',
                            widget = wibox.widget.imagebox,
                        },
                        margins = 2,
                        widget  = wibox.container.margin,
                    },
                    {
                        id     = 'text_role',
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left  = 16,
                right = 15,
                widget = wibox.container.margin
            },
            id     = 'background_role',
            widget = wibox.container.background,
        },
    }
    -- }}}

    -- {{{ Systray
    s.mysystray = wibox.widget.systray()
    -- }}}

    -- Create the wibox
    s.mywibox = awful.wibar{
        widgth      = "100%",
        height      = dpi(24),
        ontop       = true,
        position    = "top",
        shape       = gears.shape.roundded_rect,
        screen      = s,
        expand      = true,
        bg          = gears.color.transparent,
        visable     = true
    }
    -- Add widgets to the wibox
    s.mywibox:setup {
        --layout = wibox.layout.align.horizontal,
        { -- Seperator
            bg              = gears.color.transparent,
            orientation     = "horizontal",
            thickness       = 0,
            forced_height   = beautiful.useless_gap * 2,
            buttons         = top_of_screen_buttons,
            widget          = wibox.widget.separator
        },
        {
            layout = wibox.layout.align.horizontal,
            {   -- Left bar
                {
                    {
                        s.mytaglist,
                        left    = bar_margin,
                        right   = bar_margin,
                        widget  = wibox.container.background
                    },
                    bg          = beautiful.bar_bg,
                    shape       = gears.shape.rounded_bar,
                    shape_border_width  = bar_border,
                    shape_border_color  = beautiful.taglist_border,
                    widget      = wibox.container.background
                },
                left    = beautiful.useless_gap * 2,
                right   = beautiful.useless_gap * 2,
                widget = wibox.container.margin
            }, {   -- Middle Bar
                {
                    {
                        {
                            layout = wibox.layout.align.horizontal,
                            expand = "outside",
                            separator,
                            s.mytasklist,
                            separator,
                        },
                        left    = bar_margin,
                        right   = bar_margin,
                        widget  = wibox.container.margin
                    },
                    bg                  = beautiful.t_grey,
                    shape               = gears.shape.rounded_bar,
                    shape_border_width  = bar_border,
                    shape_border_color  = beautiful.bar_bg,
                    widget              = wibox.container.background
                },
                left    = beautiful.useless_gap,
                right   = beautiful.useless_gap,
                widget  = wibox.container.margin,
            },
            {   -- Right Bar
                {
                    {
                        {
                            layout = wibox.layout.fixed.horizontal,
                            {
                                s.mysystray,
                                bg      = beautiful.bg_systray,
                                top     = 2,
                                bottop  = 2,

                                widget  = wibox.container.margin
                            },
                            separator,
                            mybattery,
                            separator,
                            separator,
                            {
                                s.mylayoutbox,
                                margin  = 4,
                                widget  = wibox.container.margin
                            },
                        },
                        left    = bar_margin,
                        right   = bar_margin,
                        widget  = wibox.container.margin
                    },
                    bg              = beautiful.bar_bg,
                    shape           = gears.shape.rounded_bar,
                    shape_border_width  = bar_border,
                    shape_border_color  = beautiful.lgrey,
                    widget              = wibox.container.background
                },
                left    = beautiful.useless_gap,
                right   = beautiful.useless_gap * 2,
                widget  = wibox.container.margin
            },
        },
        widget = wibox.layout.align.vertical
    }
end)
