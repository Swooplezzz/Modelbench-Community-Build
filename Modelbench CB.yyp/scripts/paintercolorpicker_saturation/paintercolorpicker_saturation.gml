/// painter_colorpicker_saturation(value, add)
/// @arg value
/// @arg add

function painter_colorpicker_saturation(value, add)
{
	painter_colorpicker.saturation = min(255, painter_colorpicker.saturation * add + value)
	painter_colorpicker_update(null, make_color_hsv(painter_colorpicker.hue, painter_colorpicker.saturation, painter_colorpicker.brightness), false)
}
