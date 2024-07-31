/// tab_color_palettes()

function tab_color_palettes()
{
	draw_colorpalettes()
	
	tab_control(24)
	
	if (draw_button_icon("newpalette", dx, dy, 24, 24, false, icons.ASSET_ADD, null, false, "painternewpalette"))
		action_painter_palette_add()
	
	if (draw_button_icon("importpalette", dx + 28, dy, 24, 24, false, icons.ASSET_IMPORT, null, false, "painterimportpalette"))
		action_painter_palette_import()
	
	tab_next()
}