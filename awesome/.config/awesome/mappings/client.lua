local gears = require("gears")
local awful = require("awful")
local modkey = require("constants").modkey

local M = {}

M.setup = function()
  return gears.table.join(
    awful.key({ modkey }, "b", function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end, { description = "toggle fullscreen", group = "client" }),

    awful.key({ modkey }, "q", function(c)
      c:kill()
    end, { description = "close", group = "client" }),

    awful.key({ modkey, "Control" }, "Return", function(c)
      c:swap(awful.client.getmaster())
    end, { description = "move to master", group = "client" }),

    awful.key({ modkey }, "t", function(c)
      c.ontop = not c.ontop
    end, { description = "toggle keep on top", group = "client" }),

    awful.key({ modkey }, "n", function(c)
      -- The client currently has the input focus, so it cannot be
      -- minimized, since minimized clients can't have the focus.
      c.minimized = true
    end, { description = "minimize", group = "client" })
  )
end

return M
