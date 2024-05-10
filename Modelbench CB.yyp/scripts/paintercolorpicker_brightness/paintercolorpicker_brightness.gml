/// colorpicker_brightness(value, add)
/// @arg value
/// @arg add

function painter_colorpicker_brightness(value, add)
{
	painter_colorpicker.brightness = min(255, painter_colorpicker.brightness * add + value)
	painter_colorpicker_update(null, make_color_hsv(painter_colorpicker.hue, painter_colorpicker.saturation, painter_colorpicker.brightness), false)
}
