/// action_painter_palette_pick_color(value)
/// @arg value

function action_painter_palette_pick_color(value)
{
	paint_primary_color = value
	paintercolorpicker_update(null, value, true)
}