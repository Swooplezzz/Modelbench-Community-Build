/// action_painter_palette_add()

function action_painter_palette_add()
{
	var struct =
	{
		name: "New Palette",
		color_list: array_create(0)
	}

	ds_list_add(palette_list, struct)
	//palettes_save()
}