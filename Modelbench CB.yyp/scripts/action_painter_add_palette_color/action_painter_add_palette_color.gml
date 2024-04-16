/// action_painter_add_palette_color(value)
/// @arg value

function action_painter_add_palette_color(value)
{
	array_add(app.palette_list[|value].color_list, (app.painter_main_color = 1 ? app.paint_secondary_color : app.paint_primary_color))
	//palettes_save()
}