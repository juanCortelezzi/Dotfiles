-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

local beautiful = require("beautiful")
local awful = require("awful")
require("awful.autofocus")

-- Error handling module
require("errors")

-- Themes define colours, icons, font and wallpapers.
beautiful.init("/home/wiz/.config/awesome/theme.lua")
beautiful.gap_single_client = true

awesome.set_preferred_icon_size(32)

awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.floating,
  awful.layout.suit.max,
}

require("statusbar")

-- {{{ Key bindings
local mappings = require("mappings")

root.keys(mappings.globalkeys)

require("window.rules").setup(mappings.clientkeys, mappings.clientbuttons)
require("window.signals")
