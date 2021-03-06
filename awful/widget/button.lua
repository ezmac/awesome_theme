---------------------------------------------------------------------------
-- @author Julien Danjou &lt;julien@danjou.info&gt;
-- @copyright 2008-2009 Julien Danjou
-- @release v3.5.1
---------------------------------------------------------------------------

local setmetatable = setmetatable
local type = type
local abutton = require("awful.button")
local imagebox = require("wibox.widget.imagebox")
local widget = require("wibox.widget.base")
local surface = require("gears.surface")
local cairo = require("lgi").cairo
local capi = { mouse = mouse }

-- awful.widget.button
local button = { mt = {} }

--- Create a button widget. When clicked, the image is deplaced to make it like
-- a real button.
-- @param args Widget arguments. "image" is the image to display.
-- @return A textbox widget configured as a button.
function button.new(args)
    if not args or not args.image then
        return widget.empty_widget()
    end
    local img_release = surface.load(args.image)
    local img_press = cairo.ImageSurface(cairo.Format.ARGB32, img_release.width, img_release.height)
    local cr = cairo.Context(img_press)
    cr:set_source_surface(img_release, 2, 2)
    cr:paint()

    local w = imagebox()
    w:set_image(img_release)
    w:buttons(abutton({}, 1, function () w:set_image(img_press) end, function () w:set_image(img_release) end))
    return w
end

function button.mt:__call(...)
    return button.new(...)
end

return setmetatable(button, button.mt)

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
