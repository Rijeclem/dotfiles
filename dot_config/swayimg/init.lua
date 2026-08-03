-- for lua to not warn "hl"
---@diagnostic disable: undefined-global

swayimg.text.hide()
swayimg.text.set_font("Jura")
swayimg.viewer.bind_reset()

-- DEBUG: table printer
function Printtable(mytable)
    if next(mytable) == nil then
        print("The table is empty")
    end
    for key, value in pairs(mytable) do
        print(key, value)
    end
end

-- overlay state
local scale_modes = {
	"optimal",
	"fit",
	"fill",
	"width",
	"height",
	"real",
}
local scale_index = 1

-- Quit
swayimg.viewer.on_key("q", function()
	swayimg.exit()
end)
swayimg.gallery.on_key("q", function() swayimg.exit()
end)

-- switch to viewer/gallery/slideshow (i removed slideshow)
swayimg.viewer.on_key("Tab", function()
	swayimg.set_mode("gallery")
end)
-- swayimg.gallery.on_key("Tab", function()
-- 	swayimg.set_mode("slideshow")
-- end)
swayimg.gallery.on_key("Tab", function()
	swayimg.set_mode("viewer")
end)

-- Previous / Next image
swayimg.viewer.on_key("Left", function()
	swayimg.viewer.switch_image("prev")
end)
swayimg.viewer.on_key("Right", function()
	swayimg.viewer.switch_image("next")
end)

-- toggle fullscreen
swayimg.viewer.on_key("f", function()
	swayimg.set_fullscreen(!swayimg.get_fullscreen())
end)

-- get all images in directory
    swayimg.imagelist.enable_adjacent(true)

-- Pan image
local function pan(dx, dy)
	local pos = swayimg.viewer.get_position()
	swayimg.viewer.set_abs_position(pos.x + dx, pos.y + dy)
end

swayimg.viewer.on_key("h", function()
	pan(20, 0)
end)
swayimg.viewer.on_key("Shift+h", function()
	pan(50, 0)
end)

swayimg.viewer.on_key("l", function()
	pan(-20, 0)
end)
swayimg.viewer.on_key("Shift+l", function()
	pan(-50, 0)
end)

swayimg.viewer.on_key("k", function()
	pan(0, 20)
end)
swayimg.viewer.on_key("Shift+k", function()
	pan(0, 50)
end)

swayimg.viewer.on_key("j", function()
	pan(0, -20)
end)
swayimg.viewer.on_key("Shift+j", function()
	pan(0, -50)
end)

-- Rotate
swayimg.viewer.on_key("r", function()
	swayimg.viewer.rotate(90)
end)
swayimg.viewer.on_key("Shift+r", function()
	swayimg.viewer.rotate(270)
end)

-- Reset zoom/pan
swayimg.viewer.on_key("c", function()
	swayimg.viewer.reset()
end)

--zoom
swayimg.viewer.on_key("Shift+plus", function()
    local curScale = swayimg.viewer.get_scale()
    swayimg.viewer.set_abs_scale(curScale + 0.1)
end)
swayimg.viewer.on_key("Up", function()
    local curScale = swayimg.viewer.get_scale()
    swayimg.viewer.set_abs_scale(curScale + 0.1)
end)
swayimg.viewer.on_mouse("ScrollUp", function()
    local curScale = swayimg.viewer.get_scale()
    swayimg.viewer.set_abs_scale(curScale + 0.1)
end)
swayimg.viewer.on_key("minus", function()
    local curScale = swayimg.viewer.get_scale()
    swayimg.viewer.set_abs_scale(curScale - 0.1)
end)
swayimg.viewer.on_key("Down", function()
    local curScale = swayimg.viewer.get_scale()
    swayimg.viewer.set_abs_scale(curScale - 0.1)
end)
swayimg.viewer.on_mouse("ScrollDown", function()
    local curScale = swayimg.viewer.get_scale()
    swayimg.viewer.set_abs_scale(curScale - 0.1)
end)

-- Mouse things to stop from commenting unhandled function
swayimg.viewer.on_mouse("MouseLeft", function()
end)
swayimg.viewer.on_mouse("MouseRight", function()
end)

-- Remove image from rotation
swayimg.viewer.on_key("x", function()
	local img = swayimg.viewer.get_image() if img then
		swayimg.imagelist.remove(img.path)
	end
end)
swayimg.gallery.on_key("x", function()
	local img = swayimg.gallery.get_image() if img then
		swayimg.imagelist.remove(img.path)
	end
end)

-- Center image
swayimg.viewer.on_key("c", function()
	swayimg.viewer.set_fix_position("center")
end)

-- Cycle scaling modes
swayimg.viewer.on_key("s", function()
	scale_index = scale_index + 1
	if scale_index > #scale_modes then
		scale_index = 1
	end

	swayimg.viewer.set_fix_scale(scale_modes[scale_index])
	swayimg.text.set_status("Scale: " .. scale_modes[scale_index])
end)

-- Next animation frame
swayimg.viewer.on_key("m", function()
    swayimg.viewer.next_frame()
end)
-- Next animation frame
swayimg.viewer.on_key("n", function()
    swayimg.viewer.prev_frame()
end)
-- Pause / Resume animation
swayimg.viewer.on_key("space", function()
	swayimg.viewer.set_animation(!swayimg.viewer.get_animation())
end)


 -- Gallery (thumbnail view) colors

swayimg.gallery.set_window_color(0xFF2E3440) -- Gallery window bg

swayimg.gallery.set_unselected_color(0xFF3B4252) -- Slightly lighter Nord

swayimg.gallery.set_selected_color(0xFF81A1C1) -- #81a1c1

swayimg.gallery.set_border_color(0xFF81A1C1) -- #81a1c1

-- Metadata toggle with 'i'

swayimg.text.hide()

local function toggle_text()

if swayimg.text.visible() then

swayimg.text.hide()

else

swayimg.text.show()

end

end

swayimg.gallery.on_key("i", function()

toggle_text()

end)

swayimg.viewer.on_key("i", function()

toggle_text()

end)

-- Gallery navigation with h/j/k/l

swayimg.gallery.on_key("h", function()

swayimg.gallery.switch_image("left")

end)

swayimg.gallery.on_key("l", function()

swayimg.gallery.switch_image("right")

end)

swayimg.gallery.on_key("k", function()

swayimg.gallery.switch_image("up")

end)

swayimg.gallery.on_key("j", function()

swayimg.gallery.switch_image("down")

end)

 swayimg.gallery.on_key("g", function()

swayimg.gallery.switch_image("first")

end)

swayimg.gallery.on_key("Shift+g", function()

swayimg.gallery.switch_image("last")

end)

-- yank image
swayimg.viewer.on_key("y", function()
    local image = swayimg.viewer.get_image()
    os.execute(string.format(
        "sh -c 'convert %q png:- | wl-copy --type image/png &'",
        image.path
    ))
    swayimg.text.set_status("Image copied to clipboard")
end)
swayimg.slideshow.on_key("Ctrl-c", function()
    local image = swayimg.slideshow.get_image()
    os.execute(string.format(
        "sh -c 'convert %q png:- | wl-copy --type image/png &'",
        image.path
    ))
    swayimg.text.set_status("Image copied to clipboard")
end)
