/// action_color_set(color)
/// @arg color

function action_color_set(color)
{
	if (painter_main_color = 0)
		paint_primary_color = color
	else
		paint_secondary_color = color
}