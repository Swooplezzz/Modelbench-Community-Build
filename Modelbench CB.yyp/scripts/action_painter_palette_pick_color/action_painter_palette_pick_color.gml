/// action_painter_palette_pick_color(value)
/// @arg value

function action_painter_palette_pick_color(value)
{
	paint_primary_color = value
	painter_colorpicker_update(null, value, true)
}