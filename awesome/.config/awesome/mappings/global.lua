local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local constants = require("constants")

local modkey = constants.modkey

local M = {}
M.setup = function()
  return gears.table.join(
    awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
    -- awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),

    awful.key({ modkey }, "j", function()
      awful.client.focus.byidx(1)
    end, { description = "focus next by index", group = "client" }),

    awful.key({ modkey }, "k", function()
      awful.client.focus.byidx(-1)
    end, { description = "focus previous by index", group = "client" }),

    awful.key({ modkey, "Shift" }, "j", function()
      awful.client.swap.byidx(1)
    end, { description = "swap with next client by index", group = "client" }),

    awful.key({ modkey, "Shift" }, "k", function()
      awful.client.swap.byidx(-1)
    end, { description = "swap with previous client by index", group = "client" }),

    -- awful.key({ modkey, "Control" }, "j", function()
    --   awful.screen.focus_relative(1)
    -- end, { description = "focus the next screen", group = "screen" }),
    --
    -- awful.key({ modkey, "Control" }, "k", function()
    --   awful.screen.focus_relative(-1)
    -- end, { description = "focus the previous screen", group = "screen" }),

    awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),

    -- awful.key({ modkey }, "Tab", function()
    --   awful.client.focus.history.previous()
    --   if client.focus then
    --     client.focus:raise()
    --   end
    -- end, { description = "go back", group = "client" }),

    awful.key({ modkey }, "Return", function()
      awful.spawn(constants.terminal)
    end, { description = "open a terminal", group = "launcher" }),

    awful.key({ modkey, "Shift" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
    awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),
    awful.key({ modkey, "Shift" }, "x", function()
      awful.prompt.run({
        prompt = "Run Lua code: ",
        textbox = awful.screen.focused().mypromptbox.widget,
        exe_callback = awful.util.eval,
        history_path = awful.util.get_cache_dir() .. "/history_eval",
      })
    end, { description = "lua execute prompt", group = "awesome" }),

    awful.key({ modkey }, "l", function()
      awful.tag.incmwfact(0.05)
    end, { description = "increase master width factor", group = "layout" }),

    awful.key({ modkey }, "h", function()
      awful.tag.incmwfact(-0.05)
    end, { description = "decrease master width factor", group = "layout" }),

    awful.key({ modkey, "Shift" }, "h", function()
      awful.tag.incnmaster(1, nil, true)
    end, { description = "increase the number of master clients", group = "layout" }),

    awful.key({ modkey, "Shift" }, "l", function()
      awful.tag.incnmaster(-1, nil, true)
    end, { description = "decrease the number of master clients", group = "layout" }),

    -- awful.key({ modkey, "Control" }, "h", function()
    --   awful.tag.incncol(1, nil, true)
    -- end, { description = "increase the number of columns", group = "layout" }),
    --
    -- awful.key({ modkey, "Control" }, "l", function()
    --   awful.tag.incncol(-1, nil, true)
    -- end, { description = "decrease the number of columns", group = "layout" }),

    awful.key({ modkey, "Control" }, "n", function()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        c:emit_signal("request::activate", "key.unminimize", { raise = true })
      end
    end, { description = "restore minimized", group = "client" }),

    -- Set layouts
    awful.key({ modkey }, "t", function()
      awful.layout.set(awful.layout.suit.tile)
    end, { description = "set layout to tiling", group = "layout" }),

    awful.key({ modkey }, "m", function()
      awful.layout.set(awful.layout.suit.max)
    end, { description = "set layout to monocle", group = "layout" }),

    awful.key({ modkey }, "f", function()
      awful.layout.set(awful.layout.suit.floating)
    end, { description = "set layout to floating", group = "layout" }),

    -- awful.key({}, "XF86MonBrightnessUp", function()
    --   awful.client.focus.byidx(1)
    -- end, { description = "increase volume", group = "client" }),
    --
    -- awful.key({}, "XF86MonBrightnessDown", function()
    --   awful.client.focus.byidx(1)
    -- end, { description = "decrease volume", group = "client" }),

    awful.key({ modkey }, "w", function()
      awful.spawn(constants.browser)
    end, { description = "open browser", group = "client" }),

    -- Prompt
    awful.key({ modkey }, "r", function()
      awful.util.spawn_with_shell("dmenu_run")
    end),

    awful.key({ modkey }, "space", function()
      awful.util.spawn_with_shell("dmenu_run")
    end, { description = "run prompt", group = "launcher" })
  )
end

return M
