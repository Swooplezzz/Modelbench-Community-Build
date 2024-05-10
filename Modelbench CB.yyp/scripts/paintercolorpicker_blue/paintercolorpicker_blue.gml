/// painter_colorpicker_blue(value, add)
/// @arg value
/// @arg add

function painter_colorpicker_blue(value, add)
{
	painter_colorpicker.blue = min(255, painter_colorpicker.blue * add + value)
	painter_colorpicker_update(null, make_color_rgb(painter_colorpicker.red, painter_colorpicker.green, painter_colorpicker.blue), true)
}
