pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")

-- Miscellanous awesome library
local menubar = require("menubar")

RC = {} -- global namespace, on top before require any modules
RC.vars = require("main.user-variables")
modkey = RC.vars.modkey

-- This is a cool way of doing it in lua, but require is just simpler :p
-- local config_path = awful.util.getdir('config') .. '/'
-- dofile(config_path .. 'main/error-handling.lua')

-- Error Handling
require('main.error-handling')

-- Core custom local libraries
local main = {
  layouts = require("main.layouts"),
  tags    = require("main.tags"),
  -- menu    = require("main.menu"),
  -- rules   = require("main.rules"),
}

-- Defined layouts
RC.layouts = main.layouts()

-- Tags mapped to their layout
RC.tags = main.tags

