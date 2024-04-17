/// action_painter_palette_remove(pos)
/// @arg position

function action_painter_palette_remove(pos)
{
	ds_list_delete(palette_list, pos)
	//palettes_save()
}