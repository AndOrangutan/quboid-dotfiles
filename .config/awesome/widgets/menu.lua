local _M = {}

local awful = require'awful'
local hotkeys_popup = require'awful.hotkeys_popup'
local beautiful = require'beautiful'

local apps = require'config.apps'

_M.menu_power = {
   { 'Logout', awesome.logout },
   { 'Restart', awesome.restart },
   { 'Quit', awesome.quit },

}

_M.mainmenu = awful.menu{
   items = { A = 
      { 'hotkeys', function() hotkeys_popup.show_help(nil, awful.screen.focused()) end},
      { 'Apps', apps.menu_apps, beautiful.awesome_icon },
      { 'manual', apps.manual_cmd},
      { 'Power Control', _M.menu_power, beautiful.awesome_icon },
   }
}

_M.launcher = awful.widget.launcher{
   image = beautiful.awesome_icon,
   menu = _M.mainmenu
}

return _M
