local awful = require("awful")

local _M = {}

-- TODO: use similar idea to have icons change to respective numbers on the leader part of `<leader>#`
--- https://www.reddit.com/r/awesomewm/comments/n9f6ta/changing_tag_icons_on_different_occasions/


function _M.get ()
    local tags = {}

    local tagpairs = {
        names = {
            '1',
            '2',
            '3',
            '4',
            '5',
            '6',
            '7',
            '8',
            '9',
        },
        layout = {
            RC.layouts[1],
            RC.layouts[1],
            RC.layouts[1],
            RC.layouts[1],
            RC.layouts[1],
            RC.layouts[1],
            RC.layouts[1],
            RC.layouts[1],
            RC.layouts[1],
        },
    }

    awful.screen.connect_for_each_screen(function(s)
        tags[s] = awful.tag(tagpairs.names, s, tagpairs.layout)
    end)

    return tags
end

return setmetatable(
    {}, 
    { __call = function(_, ...) return _M.get(...) end }
)
