-- vim:foldmethod=marker
---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gears     = require("gears")

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}

local t = theme  -- make things more readable
def_font = "Nerd Font Hack Mono "

theme.dir           = os.getenv("HOME") .. "/.config/awesome/theme"

theme.font          = def_font .. "10"
theme.fonti         = def_font .. "italic 10"
theme.fontb         = def_font .. "bold 10"
theme.taglist_font  = def_font .. "16"
theme.bar_icon_font = def_font .. "15"
theme.battwidg_s  = def_font .. "8"
theme.battwidg_l  = theme.bar_icon_font
theme.pacupdate_icon_font = def_font .. "10"
theme.client_border_radius = "10"

-- {{{ Colors
theme.grey      = "#282c34"
theme.lgrey     = "#393e48"
theme.red       = "#BE5056"
theme.lred      = "#e06c75"
theme.green     = "#98c379"
theme.yellow    = "#d19a66"
theme.lyellow   = "#e5c07b"
theme.blue      = "#61afef"
theme.magenta   = "#c678dd"
theme.cyan      = "#56b6c2"
theme.dwhite    = "#979eab"
theme.white     = "#abb2bf"
theme.lwhite    = "#cccccc"

theme.t_grey    = "#282c34" .. "E6"
theme.t_lgrey   = "#393e48" .. "E6"
theme.t_red     = "#BE5056" .. "E6"
theme.t_lred    = "#e06c75" .. "E6"
theme.t_green   = "#98c379" .. "E6"
theme.t_yellow  = "#d19a66" .. "E6"
theme.t_lyellow = "#e5c07b" .. "E6"
theme.t_blue    = "#61afef" .. "E6"
theme.t_magenta = "#c678dd" .. "E6"
theme.t_cyan    = "#56b6c2" .. "E6"
theme.t_dwhite  = "#979eab" .. "E6"
theme.t_white   = "#abb2bf" .. "E6"
theme.t_lwhite  = "#cccccc" .. "E6"
-- }}}

theme.bg_systray    = theme.blue
theme.bg_normal     = t.grey
theme.fg_normal     = t.white
theme.bg_focus      = t.lgrey
theme.fg_focus      = t.lwhite
theme.bg_urgent     = t.magenta
theme.fg_urgent     = t.lgrey
theme.bg_minimize   = t.dwhite
theme.fg_minimize   = "#ffffff"

theme.bg_systray    = theme.lgrey

theme.useless_gap   = dpi(3)
theme.border_width  = dpi(3)
theme.border_normal = t.lgrey
theme.border_focus  = t.magenta
theme.border_marked = t.blue

-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg
-- |group_margin|font|description_font]
-- {{{ hotkeys
theme.hotkeys_bg = theme.grey
theme.hotkeys_fg = theme.white
theme.hotkeys_border_width = theme.border_width
theme.hotkeys_border_color = theme.magenta
--theme.hotkeys_shape = "rounded_rect"
theme.hotkeys_opacity = 0.95
theme.hotkeys_modifier_fg = theme.blue
theme.hotkeys_lable_bg = theme.yellow
theme.hotkeys_lable_fg = theme.gery
theme.hotkeys_group_margin = 16
theme.hotkeys_font = def_font .. "bold 10"
theme.hotkeys_description_font = def_font .. "italic 10"
-- }}}

-- {{{ Bar
theme.bar_bg        = theme.t_grey
theme.bar_fg_dark   = theme.grey
theme.bar_fg_light  = theme.white

-- }}}

-- {{{ Taglist
theme.taglist_border        = theme.lgrey

theme.taglist_bg            = gears.color.transparent
theme.taglist_fg            = theme.lgrey
theme.taglist_bg_focus      = theme.magenta
theme.taglist_fg_focus      = theme.bar_fg_dark
theme.taglist_bg_urgent     = theme.red
theme.taglist_fg_urgent     = theme.bar_fg_dark
theme.taglist_bg_occupied   = gears.color.transparent
theme.taglist_fg_occupied   = theme.dwhite
theme.taglist_bg_empty      = gears.color.transparent
theme.taglist_fg_empty      = theme.lgrey
theme.taglist_bg_volatile   = theme.yellow
theme.taglist_fg_volatile   = theme.bar_fg_dark
-- }}}

-- {{{ Tasklist
theme.tasklist_bg = theme.grey
theme.tasklist_fg = theme.lgrey
theme.tasklsit_bg_focus = theme.magenta
theme.tasklsit_fg_focus = theme.grey
theme.tasklist_bg_urgent = theme.red
theme.tasklist_fg_urgent = theme.grey
-- }}}

-- {{{ Titlebar
theme.titlebar_bg_normal = theme.lgrey
theme.titlebar_fg_normal = theme.lgery
theme.titlebar_bg_focus = theme.grey
theme.titlebar_fg_focus = theme.grey
-- }}}

-- {{{ Notifications
--theme.notification_font
theme.notification_bg = theme.grey
theme.notification_fg = theme.white
--theme.notification_width =
--theme.notification_height =
--theme.notification_margin =
theme.notification_border_color = theme.lgrey
theme.notification_border_width = theme.border_width
theme.notification_opacity = 0.95

-- }}}
-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(20)
theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = theme.dir.."/icons/close_normal.png"
theme.titlebar_close_button_focus  = theme.dir.."/icons/close_focus.png"

theme.titlebar_minimize_button_normal = theme.dir.."/icons/minimize_normal.png"
theme.titlebar_minimize_button_focus  = theme.dir.."/icons/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = theme.dir.."/icons/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir.."/icons/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = theme.dir.."/icons/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = theme.dir.."/icons/maximized_focus_active.png"

theme.wallpaper = themes_path.."default/background.png"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

--theme.awesome_icon = theme_path.."icons/ducky.png"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
