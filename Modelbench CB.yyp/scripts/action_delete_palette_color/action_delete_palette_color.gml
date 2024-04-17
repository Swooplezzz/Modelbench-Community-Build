/// action_delete_palette_color(color, index)
/// @arg color
/// @arg index

function action_delete_palette_color(c, i)
{
	array_delete(palette_list[|c].color_list, i, 1);
}