/// action_edit_palette_color(value)
/// @arg value

function action_edit_palette_color(value)
{
	palette_list[|painter_palette_id].color_list[painter_palette_col] = value
}