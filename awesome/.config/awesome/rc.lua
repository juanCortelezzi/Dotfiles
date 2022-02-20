-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local awful = require("awful")
require("awful.autofocus")

-- Theme handling library
local beautiful = require("beautiful")

-- NOTE: might wanna take this out
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- Error handling module
require("errors")

-- Themes define colours, icons, font and wallpapers.
beautiful.init("/home/wiz/.config/awesome/theme.lua")
beautiful.useless_gap = 3
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
local globalkeys = mappings.globalkeys
local clientkeys = mappings.clientkeys
local clientbuttons = mappings.clientbuttons

root.keys(globalkeys)

require("window.rules").setup(clientkeys, clientbuttons)
require("window.signals")
