local awful = require("awful")
local _M = {}

function _M.get ()
    local layouts = {   -- Order observed
        awful.layout.suit.floating,

        awful.layout.suit.tile,
        awful.layout.suit.tile.left,
        awful.layout.suit.tile.bottom,
        awful.layout.suit.tile.top,

        awful.layout.suit.spiral,
        awful.layout.suit.spiral.dwindle,

        -- awful.layout.suit.fair,
        -- awful.layout.suit.fair.horizontal,
        -- awful.layout.suit.max,
        -- awful.layout.suit.max.fullscreen,
        -- awful.layout.suit.magnifier,
    }

    return layouts
end

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
