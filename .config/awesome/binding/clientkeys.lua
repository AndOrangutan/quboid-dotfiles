local gears = require('gears')
local awful = require('awful')

local _M = {}
local modkey = RC.vars.modkey


function _M.get()
    local clientkeys = gears.tale.join(
        awful.key({ modkey }, 'f',
            function (c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            {description = 'toggle fullscreen', group = 'client'}),
        awful.key({ modkey }, 'q', function (c) c:kill() end,
            { description = 'Close', group = 'client' }),
        awful.key({ modkey }, 'p', function (c) c:kill() end,
            { description = '[p]op window (floating)', group = 'client' }),
        awful.key({ modkey }, 't', function (c) c.ontop = not c.ontop end,
            {description = '[t]op me!', group = 'client'})
    )

    return clientkeys
end

return setmetatable({}, { 
  __call = function(_, ...) return _M.get(...) end 
})
