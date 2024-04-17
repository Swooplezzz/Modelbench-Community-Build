/// painter_reset()

function painter_reset()
{
	filling = false
	painter_update_spr = true
	fill_arr = array_create(0);
	painter_history_clear();
	painter_history[0] = null
	painter_history_amount = 0
	painter_history_pos = 0
	painter_history_undo = 0
	painter_history_redo = 0
	painter_history_data = null

	paint_texture_width = res_edit.size[X]
	paint_texture_height = res_edit.size[Y]
	tex_surf = surface_require(tex_surf, paint_texture_width, paint_texture_height)
	draw_surf = surface_require(draw_surf, paint_texture_width, paint_texture_height)
	alpha_surf = surface_require(alpha_surf, paint_texture_width, paint_texture_height)
	color_surf = surface_require(color_surf, paint_texture_width, paint_texture_height)
	selection_surf = surface_require(selection_surf, paint_texture_width, paint_texture_height)
	surface_set_target(selection_surf)
	{
		draw_clear_alpha(c_white,0)
	}
	surface_reset_target()

	offx = 0
	offy = 0
	targetoffx = 0
	targetoffy = 0

	if (sprite_exists(tex_spr))
		sprite_delete(tex_spr);

	if (sprite_exists(res_edit.sprite))
		tex_spr = sprite_duplicate(res_edit.sprite)

	surface_set_target(alpha_surf)
	{
		draw_clear(c_black)
		shader_set(shader_alphamask)
		alphafix
		draw_sprite(tex_spr,0,0,0)
		gpu_set_blendmode(bm_normal)
		shader_reset();
	}
	surface_reset_target()

	surface_set_target(color_surf)
	{
		shader_set(shader_colormask)

		draw_sprite(tex_spr,0,0,0)
		shader_reset();
	}
	surface_reset_target()

	color_spr = sprite_create_from_surface(color_surf,0,0,paint_texture_width, paint_texture_height, false,false, 0,0)
	final_spr = sprite_create_from_surface(color_surf, 0,0,surface_get_width(color_surf), surface_get_height(color_surf), false, false, 0, 0)
	alpha_spr = sprite_create_from_surface(alpha_surf, 0,0,surface_get_width(alpha_surf), surface_get_height(alpha_surf), false, false, 0, 0)
	selection_spr = sprite_create_from_surface(selection_surf, 0,0,surface_get_width(selection_surf), surface_get_height(selection_surf), false, false, 0, 0)
	targetzoom = 12

	painter_history_set("painting", tex_spr, selection_spr, transform_spr)

	zoom = targetzoom
	scale_offset_x= window_get_width() / 2 - (paint_texture_width*zoom /2 )
	scale_offset_y = window_get_height() / 2 - (paint_texture_width*zoom /2 )

	paintercolorpicker.def = c_black
	paintercolorpicker.color = paint_primary_color
	paintercolorpicker.red = color_get_red(paint_primary_color)
	paintercolorpicker.green = color_get_green(paint_primary_color)
	paintercolorpicker.blue = color_get_blue(paint_primary_color)
		
	paintercolorpicker.hue = color_get_hue(paint_primary_color)
	paintercolorpicker.saturation = color_get_saturation(paint_primary_color)
	paintercolorpicker.brightness = color_get_value(paint_primary_color)
		
	paintercolorpicker.tbx_red.text = string(paintercolorpicker.red)
	paintercolorpicker.tbx_green.text = string(paintercolorpicker.green)
	paintercolorpicker.tbx_blue.text = string(paintercolorpicker.blue)
	paintercolorpicker.tbx_hexadecimal.text = color_to_hex(paint_primary_color)
		
	selection_active = false
}