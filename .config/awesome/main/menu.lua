local awful = require('awful')
local hotkeys_popup = require('awful.hotkeys_popup').widget
local beautiful = require('beautiful')

local M = {}
local _M = {}

-- reading
-- https://awesomewm.org/apidoc/popups%20and%20bars/awful.menu.html

local terminal = RC.vars.terminal

local editor = os.getenv('EDITOR') or 'vim'
local editor_cmd = terminal .. ' -e ' .. editor

M.power = {
    { "Shutdown/Logout", "oblogout" },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end},
}

function _M.get()
    local menu_items = {
        { 'hotkey menu', function ()
            hotkeys_popup.show_help(nil, awful.screen.focused())
        end },
        -- { 'Browser', term },
        -- { "Browser", "firefox", awful.util.getdir("config") .. "firefox.png" },
        { "Browser", "firefox" },
        { 'Terminal', terminal },
        { 'Power', M.power, beautiful.awesome_subicon }
    }

    return menu_items
end


return setmetatable(
  {}, 
  { __call = function(_, ...) return _M.get(...) end }
)
