/// painter_colorpicker_green(value, add)
/// @arg value
/// @arg add

function painter_colorpicker_green(value, add)
{
	painter_colorpicker.green = min(255, painter_colorpicker.green * add + value)
	painter_colorpicker_update(null, make_color_rgb(painter_colorpicker.red, painter_colorpicker.green, painter_colorpicker.blue), true)
}
