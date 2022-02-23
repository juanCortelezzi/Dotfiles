-- https://awesomewm.org/doc/api/libraries/naughty.html#notify
-- https://github.com/streetturtle/awesome-wm-widgets/blob/master/battery-widget/battery.lua
-- https://github.com/manilarome/the-glorious-dotfiles/blob/master/config/awesome/surreal/widget/battery/init.lua

local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful").xresources.apply_dpi
local watch = awful.widget.watch

local gears = require("gears")
local config_dir = gears.filesystem.get_configuration_dir()
local widget_icon_dir = config_dir .. "widgets/test/icons/"

local battery_imagebox = wibox.widget({
  nil,
  {
    id = "icon",
    image = widget_icon_dir .. "battery" .. ".svg",
    widget = wibox.widget.imagebox,
    resize = true,
  },
  nil,
  expand = "none",
  layout = wibox.layout.align.vertical,
})

local battery_percentage_text = wibox.widget({
  id = "percent_text",
  text = "100%",
  font = "Inter Bold 11",
  align = "center",
  valign = "center",
  visible = true,
  widget = wibox.widget.textbox,
})

local battery_widget = wibox.widget({
  layout = wibox.layout.fixed.horizontal,
  spacing = dpi(0),
  battery_imagebox,
  battery_percentage_text,
})

local battery_container = wibox.widget({
  battery_widget,
  margins = dpi(7),
  widget = wibox.container.margin,
})

local battery_tooltip = awful.tooltip({
  objects = { battery_widget },
  text = "None",
  mode = "outside",
  align = "right",
  margin_leftright = dpi(8),
  margin_topbottom = dpi(8),
  preferred_positions = { "right", "left", "top", "bottom" },
})

battery_tooltip:add_to_object(battery_container)

local update_widget_ui = function(status, charge, time)
  battery_percentage_text.text = charge .. "%"
  battery_tooltip.text = status .. " " .. time

  charge = tonumber(charge)
  status = string.lower(status)

  local icon_name = "battery"

  -- Fully charged
  if (status == "fully-charged" or status == "charging") and charge == 100 then
    icon_name = icon_name .. "-fully-charged"
    battery_imagebox.icon:set_image(gears.surface.load_uncached(widget_icon_dir .. icon_name .. ".svg"))
    return
  end

  -- Critical level warning message
  if (charge > 0 and charge < 10) and status == "discharging" then
    icon_name = icon_name .. "-alert-red"
    battery_imagebox.icon:set_image(gears.surface.load_uncached(widget_icon_dir .. icon_name .. ".svg"))
    return
  end

  -- Discharging
  if charge < 20 then
    icon_name = icon_name .. "-" .. status .. "-10"
  elseif charge < 30 then
    icon_name = icon_name .. "-" .. status .. "-20"
  elseif charge < 50 then
    icon_name = icon_name .. "-" .. status .. "-30"
  elseif charge < 60 then
    icon_name = icon_name .. "-" .. status .. "-50"
  elseif charge < 80 then
    icon_name = icon_name .. "-" .. status .. "-60"
  elseif charge < 90 then
    icon_name = icon_name .. "-" .. status .. "-80"
  elseif charge < 100 then
    icon_name = icon_name .. "-" .. status .. "-90"
  end

  battery_imagebox.icon:set_image(gears.surface.load_uncached(widget_icon_dir .. icon_name .. ".svg"))
end

watch("acpi -b", 10, function(_, stdout)
  for s in stdout:gmatch("[^\r\n]+") do
    local status, charge, time = string.match(s, ".+: (%a+), (%d?%d?%d)%%,?(.*)")
    if not status then
      battery_tooltip.text = "No battery found"
      battery_percentage_text.text = "-1%"
      return
    end

    update_widget_ui(status, charge, time)
  end
end)

return battery_container
