/// painter_colorpicker_hue(value, add)
/// @arg value
/// @arg add

function painter_colorpicker_hue(value, add)
{
	painter_colorpicker.hue = min(255, painter_colorpicker.hue * add + value)
	painter_colorpicker_update(null, make_color_hsv(painter_colorpicker.hue, painter_colorpicker.saturation, painter_colorpicker.brightness), false)
}
