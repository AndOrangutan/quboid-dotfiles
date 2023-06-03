local gears = require('gears')
local awful = require('awful')

local hotkeys_popup = require('awful.hotkeys_popup')

local modkey = RC.vars.modkey
local terminal = RC.vars.terminal

local _M = {}

function _M.get(globalkeys)
    local globalkeys = gears.table.join(
        awful.key({ modkey }, 's', hotkeys_popup.show_help,
            {description = 'show help', group = 'awesome' }),
        awful.key({ modkey, 'Control' }, "r", awesome.restart,
            { description = 'reload awesome', group = 'awesome' }),
        awful.key({ modkey, 'Shift'   }, 'Escape', awesome.quit,
            { description = 'quit awesome', group = 'awesome' }),
        awful.key({ modkey }, 'x',
            function ()
                awful.prompt.run {
                    prompt       = 'Run Lua code: ',
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. '/history_eval'
                }
            end,
            {description = 'lua execute prompt', group = 'awesome'}),

        awful.key({ modkey }, 'r', function () awful.spawn.with_shell('rofi -show drun') end,
            { description = 'Run Rofi', group = 'launcher' }),
        -- TODO: determine if this is wanted
        awful.key({ modkey }, 'p', function () menubar.show() end,
            {description = 'show menubar', group = 'launcher' }),

        awful.key({ modkey }, 'Left', awful.tag.viewprev,
            { description = 'View previous tag', group = 'tag' }),
        awful.key({ modkey }, 'Right', awful.tag.viewnext,
            { description = 'View next tag', group = ' tag' }),
        awful.key({ modkey }, '.', awful.tag.viewprev,
            { description = 'View previous tag', group = 'tag' }),
        awful.key({ modkey }, '.', awful.tag.viewnext,
            { description = 'View next tag', group = ' tag' }),
        awful.key({ modkey }, 'Escape', awful.tag.history.restore,
            { description = 'Restore previous tag', group = 'tag' }),

        awful.key({ modkey }, 'u', awful.client.urgent.jumpto,
            { description = 'jump to urgent client', group = 'client' }),
        -- Move focus by direcction
        awful.key({ modkey }, 'h', function () awful.client.focus.global_bydirection('left') end,
            { description = 'Move focus left', group = 'client' }),
        awful.key({ modkey }, 'j', function () awful.client.focus.global_bydirection('down') end,
            { description = 'Move focus down', group = 'client' }),
        awful.key({ modkey }, 'k', function () awful.client.focus.global_bydirection('up') end,
            { description = 'Move focus up', group = 'client' }),
        awful.key({ modkey }, 'l', function () awful.client.focus.global_bydirection('right') end,
            { description = 'Move focus right', group = 'client' }),
        -- Layout manipulation
        awful.key({ modkey, 'Shift' }, 'h', function () awful.client.swap.global_bydirection('left') end,
            { description = 'Swap with client to left', group = 'client' }),
        awful.key({ modkey, 'Shift' }, 'j', function () awful.client.swap.global_bydirection('down') end,
            { description = 'Swap with client below', group = 'client' }),
        awful.key({ modkey, 'Shift' }, 'k', function () awful.client.swap.global_bydirection('up') end,
            { description = 'Swap with client above', group = 'client' }),
        awful.key({ modkey, 'Shift' }, 'l', function () awful.client.swap.global_bydirection('right') end,
            { description = 'Swap with client to right', group = 'client' }),
        -- Resize windows
        awful.key({ modkey, 'Control' }, 'k', function (c)
            if c.floating then
                c:relative_move( 0, 0, 0, -20)
            else
                awful.client.incwfact(0.05)
            end
        end,
            { description = 'Floating Resize Vertical -', group = 'client' }),
        awful.key({ modkey, 'Control' }, 'j', function (c)
            if c.floating then
                c:relative_move( 0, 0, 0,  20)
            else
                awful.client.incwfact(-0.05)
            end
        end,
            { description = 'Floating Resize Vertical +', group = 'client' }),
        awful.key({ modkey, 'Control' }, "h", function (c)
            if c.floating then
                c:relative_move( 0, 0, -20, 0)
            else
                awful.tag.incmwfact(-0.05)
            end
        end,
            { description = 'Floating Resize Horizontal -', group = 'client' }),
        awful.key({ modkey, 'Control' }, "l", function (c)
            if c.floating then
                c:relative_move( 0, 0,  20, 0)
            else
                awful.tag.incmwfact(0.05)
            end
        end,
            { description = 'Floating Resize Horizontal +', group = 'client' }),



        awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
            {description = "select next", group = "layout"}),
        awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
            {description = "select previous", group = "layout"}),

        -- Media Keys
        awful.key({}, 'XF86AudioRaiseVolume', function () awful.spawn('pactl set-sink-volume @DEFAULT_SINK@ +1%') end,
            { description = 'Increase volume by 1%', group = 'MediaKeys' }),
        awful.key({}, 'XF86AudioLowerVolume', function () awful.spawn('pactl set-sink-volume @DEFAULT_SINK@ -1%') end,
            { description = 'Decrease volume by 1%', group = 'MediaKeys' }),
        awful.key({}, 'XF86AudioMute', function () awful.spawn('pactl set-sink-mute @DEFAULT_SINK@ toggle') end,
            { description = '(Un)Mute audio', group = 'MediaKeys' }),
        awful.key({}, 'XF86MonBrightnessUp', function () awful.spawn('blight -d backlight/amdgpu_bl0 set +5%') end,
            { description = 'Increase brightness by 5%', group = 'MediaKeys' }),
        awful.key({}, 'XF86MonBrightnessDown', function () awful.spawn('blight -d backlight/amdgpu_bl0 set -5%') end,
            {description = 'Decrease brightness by 5%', group = 'MediaKeys'}),
        awful.key({}, 'Print', function () awful.spawn('flameshot gui') end,
              { description = 'Take Screenshot', group = 'MediaKeys' }),

        awful.key({ modkey }, 'Return', function () awful.spawn(terminal) end,
            { description = 'Open a terminal', group = 'programs' })

    )

    return globalkeys
end

return setmetatable({}, { 
  __call = function(_, ...) return _M.get(...) end 
})
