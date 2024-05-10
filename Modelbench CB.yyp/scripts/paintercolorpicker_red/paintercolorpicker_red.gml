/// painter_colorpicker_red(value, add)
/// @arg value
/// @arg add

function painter_colorpicker_red(value, add)
{
	painter_colorpicker.red = min(255, painter_colorpicker.red * add + value)
	painter_colorpicker_update(null, make_color_rgb(painter_colorpicker.red, painter_colorpicker.green, painter_colorpicker.blue), true)
}
