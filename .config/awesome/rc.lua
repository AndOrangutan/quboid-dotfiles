-- vim:foldmethod=marker
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Useful links
-- https://github.com/lcpz/lain/wiki/Home/c37d44d137c3a163095d155f09372f6da8fb8e51
-- https://awesomewm.org/doc/api/

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local cairo = require("lgi").cairo
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

awesome.register_xproperty("WM_CLASS","string")

-- Include modules
local lain = require("lain")        -- Make widgets do widgety things
-- Lain
local markup = lain.util.markup

--{{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors
    })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err)
        })
        in_error = false
    end)
end
-- }}}

naughty.config.defaults['icon_size'] = 100

-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/mytheme.lua")

corn_radius = 10

-- This is used later as the default terminal and editor to run.
terminal = os.getenv("TERM") or "kitty"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Include modules
local lain = require("lain")        -- Make widgets do widgety things

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.fair,
    awful.layout.suit.floating,
    --awful.layout.suit.tile.left,
    --awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile.top,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    --awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.magnifier,
    --awful.layout.suit.corner.nw,
    --awful.layout.suit.corner.ne,
    --awful.layout.suit.corner.sw,
    --awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu

mymainmenu = awful.menu({
    items = {
        { "Terminal", terminal },
        { "Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
        { "Manual", terminal .. " -e man awesome" },
        { "Restart", awesome.restart },
    }
})
mymainmenu.wibox.shape = function (cr, w, h)
    gears.shape.rounded_rect(cr, 300, h, corn_radius)
end

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Import bar
require('bar')

-- {{{ Wibar
-- Create a wibox for each screen and add it
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

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
--screen.connect_signal("property::geometry", set_wallpaper)

-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "Escape", awesome.quit,
              {description = "quit awesome", group = "awesome"}),
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
--    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
--              {description = "show main menu", group = "awesome"}),
    --awful.key({ modkey, "Shift" }, "p",
    --          function ()
    --              awful.prompt.run {
    --                prompt       = "Run Lua code: ",
    --                textbox      = awful.screen.focused().mypromptbox.widget,
    --                exe_callback = awful.util.eval,
    --                history_path = awful.util.get_cache_dir() .. "/history_eval"
    --              }
    --          end,
    --          {description = "lua execute prompt", group = "awesome"}),

    -- Prompt
    awful.key({ modkey },            "r",     function () awful.spawn.with_shell("rofi -show drun") end,
              {description = "Run Rofi", group = "launcher"}),

    -- Tag stuffs
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    -- Focus Screen
    awful.key({ modkey,         }, "Tab", function () awful.screen.focus_relative( 1) end,
              {description = "Focus the next screen", group = "screen"}),
    awful.key({ modkey, "Shift" }, "Tab", function () awful.screen.focus_relative(-1) end,
              {description = "Focus the previous screen", group = "screen"}),

    -- Master and column manipulation
    awful.key({ modkey    }, "m",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "m",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey,  }, "n",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Shift" }, "n",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),

    -- Swap Layout
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    -- Media Keys
    awful.key({}, "XF86AudioRaiseVolume", function () awful.util.spawn("pactl set-sink-volume @DEFAULT_SINK@ +1%") end,
              {description = "Increase volume by 1%", group = "MediaKeys"}),
    awful.key({}, "XF86AudioLowerVolume", function () awful.util.spawn("pactl set-sink-volume @DEFAULT_SINK@ -1%") end,
              {description = "Decrease volume by 1%", group = "MediaKeys"}),
    awful.key({}, "XF86AudioMute", function () awful.util.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle") end,
              {description = "(Un)Mute audio", group = "MediaKeys"}),
    awful.key({}, "XF86MonBrightnessUp", function () awful.util.spawn("blight -d backlight/amdgpu_bl0 set +5%") end,
              {description = "Increase brightness by 5%", group = "MediaKeys"}),
    awful.key({}, "XF86MonBrightnessDown", function () awful.util.spawn("blight -d backlight/amdgpu_bl0 set -5%") end,
              {description = "Decrease brightness by 5%", group = "MediaKeys"}),
    awful.key({}, "Print", function () awful.util.spawn("flameshot gui") end,
              {description = "Take Screenshot", group = "MediaKeys"})

)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end,
        {description = "Toggle maximized", group = "client"}),
    awful.key({ modkey, "Shift" }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, }, "p",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
        awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),

    -- Move focus by direcction
    awful.key({ modkey,           }, "h", function () awful.client.focus.global_bydirection("left")     end,
            {description = "Move focus left", group = "client"}),
    awful.key({ modkey,           }, "j", function () awful.client.focus.global_bydirection("down")     end,
            {description = "Move focus down", group = "client"}),
    awful.key({ modkey,           }, "k", function () awful.client.focus.global_bydirection("up")       end,
            {description = "Move focus up", group = "client"}),
    awful.key({ modkey,           }, "l", function () awful.client.focus.global_bydirection("right")    end,
            {description = "Move focus right", group = "client"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "h", function () awful.client.swap.global_bydirection("left")      end,
              {description = "Swap with client to left", group = "client"}),
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.global_bydirection("down")      end,
              {description = "Swap with client below", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.global_bydirection("up")        end,
              {description = "Swap with client above", group = "client"}),
    awful.key({ modkey, "Shift"   }, "l", function () awful.client.swap.global_bydirection("right")     end,
              {description = "Swap with client to right", group = "client"}),

    -- Layout control
    awful.key({ modkey, "shift" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),

    -- Resize windows
    awful.key({ modkey, "Control" }, "k", function (c)
        if c.floating then
            c:relative_move( 0, 0, 0, -20)
        else
            awful.client.incwfact(0.0125)
        end
    end,
    {description = "Floating Resize Vertical -", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function (c)
        if c.floating then
            c:relative_move( 0, 0, 0,  20)
        else
            awful.client.incwfact(-0.0125)
        end
    end,
    {description = "Floating Resize Vertical +", group = "client"}),
    awful.key({ modkey, "Control" }, "h", function (c)
        if c.floating then
            c:relative_move( 0, 0, -20, 0)
        else
            awful.tag.incmwfact(-0.0125)
        end
    end,
    {description = "Floating Resize Horizontal -", group = "client"}),
    awful.key({ modkey, "Control" }, "l", function (c)
        if c.floating then
            c:relative_move( 0, 0,  20, 0)
        else
            awful.tag.incmwfact(0.0125)
        end
    end,
    {description = "Floating Resize Horizontal +", group = "client"}),

    -- Moving floating windows
    awful.key({ modkey, "Shift"   }, "Down", function (c)
        c:relative_move(  0,  10,   0,   0) end,
    {description = "Floating Move Down", group = "client"}),
    awful.key({ modkey, "Shift"   }, "Up", function (c)
        c:relative_move(  0, -10,   0,   0) end,
    {description = "Floating Move Up", group = "client"}),
    awful.key({ modkey, "Shift"   }, "Left", function (c)
        c:relative_move(-10,   0,   0,   0) end,
    {description = "Floating Move Left", group = "client"}),
    awful.key({ modkey, "Shift"   }, "Right", function (c)
        c:relative_move( 10,   0,   0,   0) end,
    {description = "Floating Move Right", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

-- Control floating windows with mouse
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
-- }}}


-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
        properties = { border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen,
        }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
            "DTA",  -- Firefox addon DownThemAll.
            "copyq",  -- Includes session name in class.
            "pinentry",
        },
        class = {
            "Arandr",
            "Blueman-manager",
            "Gpick",
            "Kruler",
            "MessageWin",  -- kalarm.
            "Sxiv",
            "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
            "Wpa_gui",
            "veromix",
            "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
            "Event Tester",  -- xev.
        },
        role = {
            "AlarmWindow",  -- Thunderbird's calendar.
            "ConfigManager",  -- Thunderbird's about:config.
            "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
    }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },
    { rule = { name = "Mailspring" },
      properties = { screen = 1, tag = tags[1][7] }
    },
    { rule = { class = "zoom" },
      properties = { screen = 1, tag = tags[1][5] }
    },
    { rule = { class = "discord" },
      properties = { screen = 1, tag = tags[1][8] }
    },
    { rule = { class = "firefox", instance = "startup" }, 
        properties = {screen = 1, tag = tags[1][1] }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
        and not c.size_hints.user_position
        and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
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
            awful.titlebar.widget.closebutton(c),
            awful.titlebar.widget.minimizebutton(c),
            awful.titlebar.widget.maximizedbutton(c),

            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- mythemee
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.iconwidget(c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- turn titlebar on when client is floating
client.connect_signal("property::floating", function(c)
    if c.floating and not c.requests_no_titlebar then
        awful.titlebar.show(c)
    else
        awful.titlebar.hide(c)
    end
end)

-- turn tilebars on when layout is floating
awful.tag.attached_connect_signal(nil, "property::layout", function (t)
    local float = t.layout.name == "floating"
    for _,c in pairs(t:clients()) do
        c.floating = float
    end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

local function apply_shape(draw, shape, outer_shape_args, inner_shape_args)

  local geo = draw:geometry()

  local border = beautiful.base_border_width
  local titlebar_height = border
  --local titlebar_height = titlebar.is_enabled(draw) and beautiful.titlebar_height or border

  local img = cairo.ImageSurface(cairo.Format.A1, geo.width, geo.height)
  local cr = cairo.Context(img)

  cr:set_operator(cairo.Operator.CLEAR)
  cr:set_source_rgba(0,0,0,1)
  cr:paint()
  cr:set_operator(cairo.Operator.SOURCE)
  cr:set_source_rgba(1,1,1,1)

  shape(cr, geo.width, geo.height, outer_shape_args)
  cr:fill()
  draw.shape_bounding = img._native

  cr:set_operator(cairo.Operator.CLEAR)
  cr:set_source_rgba(0,0,0,1)
  cr:paint()
  cr:set_operator(cairo.Operator.SOURCE)
  cr:set_source_rgba(1,1,1,1)

  gears.shape.transform(shape):translate(
    border, titlebar_height
  )(
    cr,
    geo.width-border*2,
    geo.height-titlebar_height-border,
    inner_shape_args
  )
  cr:fill()
  draw.shape_clip = img._native

  img:finish()
end


local pending_shapes = {}
local function round_up_client_corners(c, force, reference)
  if not force and ((
    -- @TODO: figure it out and uncomment
    not beautiful.client_border_radius or beautiful.client_border_radius == 0
  ) or (
    not c.valid
  ) or (
    c.fullscreen
  ) or (
    pending_shapes[c]
  ) or (
    #c:tags() < 1
  )) or beautiful.skip_rounding_for_crazy_borders then
    --clog('R1 F='..(force or 'nil').. ', R='..(reference or '')..', C='.. (c and c.name or '<no name>'), c)
    return
  end
  --clog({"Geometry", c:tags()}, c)
  pending_shapes[c] = true
  delayed_call(function()
    local client_tag = choose_tag(c)
    if not client_tag then
      nlog('no client tag')
      return
    end
    local num_tiled = get_num_tiled(client_tag)
    --clog({"Shape", num_tiled, client_tag.master_fill_policy, c.name}, c)
    --if not force and (c.maximized or (
    if (
      c.maximized or c.fullscreen
    or (
      (num_tiled<=1 and client_tag.master_fill_policy=='expand')
      and not c.floating
      and client_tag.layout.name ~= "floating"
    )) then
      pending_shapes[c] = nil
      --nlog('R2 F='..(force and force or 'nil').. ', R='..reference..', C='.. c.name)
      return
    end
    -- Draw outer shape only if floating layout or useless gaps
    local outer_shape_args = 0
    if client_tag.layout.name == "floating" or client_tag:get_gap() ~= 0 then
      outer_shape_args = beautiful.client_border_radius
    end
    local inner_shape_args = beautiful.client_border_radius*0.75
    --local inner_shape_args = beautiful.client_border_radius - beautiful.base_border_width
    --if inner_shape_args < 0 then inner_shape_args = 0 end
    apply_shape(c, gears.shape.rounded_rect, outer_shape_args, inner_shape_args)
    --clog("apply_shape "..(reference or 'no_ref'), c)
    pending_shapes[c] = nil
    --nlog('OK F='..(force and "true" or 'nil').. ', R='..reference..', C='.. c.name)
  end)
end


-- Startup commands
do
    local cmds =
    {
        "feh --recursive --bg-fill --randomize /usr/share/wallpapers/random",
        "picom --experimental-backend",
        "unclutter sudo",
        "xset r rate 200 25",
        "firefox-beta-bin --class 'startup'",
        "discord",
        "mailspring",
        "dropbox",
        "flameshot",
        "nm-applet",
        "ToggleDesktop"

    }

    for _,i in pairs(cmds) do
        awful.util.spawn(i)
    end
end

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
