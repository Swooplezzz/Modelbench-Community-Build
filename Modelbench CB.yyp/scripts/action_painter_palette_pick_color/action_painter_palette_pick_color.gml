/// action_painter_palette_pick_color(value)
/// @arg value

function action_painter_palette_pick_color(value)
{
	action_color_set(value)
	painter_colorpicker_update(null, value, true)
}