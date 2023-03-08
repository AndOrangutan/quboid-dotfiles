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
local bar_border = dpi(2)
-- Modules
local lain = require("lain")

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

-- {{{ Clock and Date
local clockicon = wibox.widget.textbox(
    string.format('<span color="%s" font="'..beautiful.bar_icon_font..'"></span>', beautiful.grey)
)
local mytextclock = wibox.widget.textclock("%H:%M")
local mytextcal = wibox.widget.textclock("%m/%d/%y")

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

-- {{{ Pacage Updates
pacicon =  wibox.widget.textbox(
    string.format('<span color="%s" font="'..beautiful.pacupdate_icon_font.. '"></span>', beautiful.grey)
)
pacupdates = awful.widget.watch( 'bash -c "checkupdates | wc -l"', 300,
    function(widget, stdout)
        local opvar = stdout
        if stdout == "" then
            opvar = "None"
        end
        widget:set_markup(markup.fontfg("Nerd Font Hack Mono", beautiful.grey, opvar))

        return
    end)
-- }}}

-- {{{ Battery
local batticon_s = {
    "",
    "",
    "",
    "",
}
local batticon_d = {
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " "
}
local batticon_c = {
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
}
batticon = lain.widget.bat{
    battery = "BAT0",
    settings = function()
        local bn = bat_now
        local icon = batticon_s[1]        -- stores icon

        local indx = tonumber(bn.perc) // 10

        if bn.status == "N/A" then
            icon = batticon_s[2]
            widget:set_markup(markup.fontfg(beautiful.battwidg_s, beautiful.grey, icon))
        elseif bn.status == "Discharging" then
            icon = batticon_d[indx+1]
            widget:set_markup(markup.fontfg(beautiful.battwidg_s, beautiful.grey, icon))
        elseif bn.status == "Charging" then
            icon = batticon_c[indx+1]
            widget:set_markup(markup.fontfg(beautiful.battwidg_l, beautiful.grey, icon))
        elseif bn.status == "Full" then
            icon = batticon_d[12]
            widget:set_markup(markup.fontfg(beautiful.battwidg_s, beautiful.grey, icon))
        end
    end,
}
mybattery = lain.widget.bat{
    battery = "BAT0",
    settings = function()
        battery = "CMB0"
        local bn = bat_now
        local percy = ""                -- stores string after icon

        if bn.status == "N/A" then
            percy = ""
        elseif bn.status == "Discharging" then
            percy = " ".. bn.perc .."%"
        elseif bn.status == "Charging" then
            percy = " " .. bn.time
        elseif bn.status == "Full" then
            percy = ""
        end

        widget:set_markup(markup.fontfg(beautiful.font, beautiful.grey, percy))
    end,
}
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ CPU
cpuicon =  wibox.widget.textbox(
    string.format('<span color="%s" font="'..beautiful.bar_icon_font.. '"></span>', beautiful.grey)
)
mycpu = lain.widget.cpu{
    timeout = 2,
    settings = function()
        local temp = string.format("%02d", cpu_now.usage)
        temp = string.format("%3s", temp)
        widget:set_markup(markup.fontfg(beautiful.font, beautiful.grey, temp .. "%"))
    end,
}
-- }}}

-- {{{ Memory

memicon =  wibox.widget.textbox(
    string.format('<span color="%s" font="'..beautiful.bar_icon_font.. '">﬙</span>', beautiful.grey)
)

mymem = lain.widget.mem{
    timeout = 2,
    settings = function()
        local temp = string.format("%5s", mem_now.used)
        widget:set_markup(markup.fontfg(beautiful.font, beautiful.grey, temp .. "M"))
    end,
}
-- }}}

-- {{{ Pulse
local pulsicon_s = {
    "婢",
    "奄",
    "奔",
    "墳",
    "墳",
}
local pulseicon = lain.widget.pulse{
    timeout = 1,
    settings = function()
        local vicon = ""
        local vn = volume_now

        if vn.muted == "yes" then
            vicon = pulsicon_s[1]
        elseif vn.muted == "no" then
            vicon = pulsicon_s[4]
        elseif vn.muted == "N/A" then
            vicon = pulsicon_s[1]
        end
        widget:set_markup(markup.fontfg(beautiful.bar_icon_font, beautiful.grey, vicon))
    end,
}
local mypulse = lain.widget.pulse{
    timeout = 1,
    settings = function()
        local vn = volume_now
        local vlevel = ""

        if tonumber(vn.left) == tonumber(vn.right) then
            vlevel = string.format("%2s", vn.left) .. "%"
        else
            vlevel = string.format("%2s", vn.left) .. "-" .. string.format("%2s", vn.right) .. "%"
        end

        widget:set_markup(markup.fontfg(beautiful.font, beautiful.grey, vlevel))
    end,
}
-- }}}

-- Enable scroll wheel against the top of the screen to change tag view
local top_of_screen_buttons = gears.table.join(
    awful.button(
        {},
        5,
        function(t)
            awful.tag.viewnext(t.screen)
        end
    ),
    awful.button(
        {},
        4,
        function(t)
            awful.tag.viewprev(t.screen)
        end
    )
)

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
                color = beautiful.grey,
                shape = gears.shape.rounded_bar
            },
            layout = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                {
                    {
                        bg = beautiful.grey,
                        shape = gears.shape.rounded_bar,
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
    -- Create divider widget
    divider = wibox.widget.textbox("|")

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        style   = {
            bg_normal   = beautiful.lgrey,
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
                    color           = beautiful.grey,
                    widget          = separator
                },
                valign = "center",
                halign = "center",
                widget = wibox.container.place,
            },
            spacing = 4,
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
                        margins = 4,
                        widget  = wibox.container.margin,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left  = 4,
                right = 4,
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
local bar_section_spacer = dpi(128+64+16)
    -- Create the wibox
    s.mywibox = awful.wibar{
        widgth      = "100%",
        height      = dpi(24),
        ontop       = false,
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
        { -- Separator
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
                        {
                            layout = wibox.layout.align.horizontal,
                            separator,

                            s.mytaglist,
                        },
                        left    = bar_margin,
                        right   = bar_margin,
                        widget  = wibox.container.background
                    },
                    bg              = beautiful.bar_bg,
                    shape           = gears.shape.rounded_bar,
                    shape_border_width  = bar_border,
                    shape_border_color  = beautiful.lgrey,
                    widget              = wibox.container.background
                },
                left    = beautiful.useless_gap * 2,
                right   = bar_section_spacer,
                widget = wibox.container.margin
            },
            {   -- Middle Bar
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
                        widget  = wibox.container.background
                    },
                    bg                  = beautiful.bar_bg,
                    shape               = gears.shape.rounded_bar,
                    shape_border_width  = bar_border,
                    shape_border_color  = beautiful.grey,
                    widget              = wibox.container.background
                },
                left    = bar_section_spacer,
                right   = bar_section_spacer,
                widget  = wibox.container.margin,
            },
            {   -- Right Bar
                {
                    {
                        {
                            layout = wibox.layout.fixed.horizontal,
                            separator,
                            {
                                {
                                    layout = wibox.layout.fixed.horizontal,
                                    separator,
                                    s.mysystray,
                                    separator,
                                },
                                bg      = beautiful.bg_systray,
                                top     = 2,
                                bottop  = 2,
                                shape   = gears.shape.rounded_bar,
                                widget  = wibox.container.background,
                            },
                            separator,
                            { -- pacupdates
                                {
                                    layout = wibox.layout.fixed.horizontal,
                                    separator,
                                    pacicon,
                                    separator,
                                    pacupdates,
                                    separator,
                                },
                                bg      = beautiful.green,
                                shape   = gears.shape.rounded_bar,
                                widget  = wibox.container.background,
                            },
                            separator,
                            {
                                {
                                    layout = wibox.layout.fixed.horizontal,
                                    separator,
                                    pulseicon,
                                    separator,
                                    mypulse,
                                    separator,
                                },
                                bg = beautiful.lyellow,
                                shape = gears.shape.rounded_bar,
                                widget = wibox.container.background,
                            },
                            separator,
                            {
                                {
                                    layout = wibox.layout.fixed.horizontal,
                                    separator,
                                    cpuicon,
                                    separator,
                                    mycpu,
                                    separator,
                                    memicon,
                                    separator,
                                    mymem,
                                    separator,
                                },
                                bg = beautiful.lred,
                                shape = gears.shape.rounded_bar,
                                widget = wibox.container.background,
                            },
                            separator,
                            {
                                {
                                    layout = wibox.layout.fixed.horizontal,
                                    batticon,
                                    mybattery,
                                    separator,
                                },
                                bg = beautiful.yellow,
                                shape = gears.shape.rounded_bar,
                                widget = wibox.container.background,
                            },
                            separator,
                            { -- clock and date
                                {
                                    layout = wibox.layout.fixed.horizontal,
                                    separator,
                                    clockicon,
                                    separator,
                                    mytextcal,
                                    separator,
                                    mytextclock,
                                    separator,
                                },
                                margin  = 4,
                                bg      = beautiful.blue,
                                fg      = beautiful.grey,
                                shape   = gears.shape.rounded_bar,
                                widget  = wibox.container.background,
                            },
                            separator,
                            { -- layoutbox
                                {
                                    layout = wibox.layout.fixed.horizontal,
                                    separator,
                                    s.mylayoutbox,
                                    separator,
                                },
                                margin  = 4,
                                bg      = gears.color.transparent,
                                shape   = gears.shape.rounded_bar,
                                widget  = wibox.container.background,
                            },
                            separator,
                        },
                        left    = beautiful.useless_gap * 2,
                        right   = beautiful.useless_gap * 2,
                        widget  = wibox.container.margin
                    },
                    bg              = beautiful.bar_bg,
                    shape           = gears.shape.rounded_bar,
                    shape_border_width  = bar_border,
                    shape_border_color  = beautiful.lgrey,
                    widget              = wibox.container.background
                },
                left    = bar_section_spacer,
                right   = beautiful.useless_gap * 2,
                widget  = wibox.container.margin
            },
        },
        widget = wibox.layout.align.vertical
    }
end)
