/// painter_create_final_spr()

function painter_create_final_spr()
{
		show_debug_message("updatedfinal")
	if (sprite_exists(final_spr))
		sprite_delete(final_spr)
	final_spr = sprite_create_from_surface(color_surf, 0,0,surface_get_width(color_surf), surface_get_height(color_surf), false, false, 0, 0)
	sprite_set_alpha_from_sprite(final_spr, alpha_spr)
	
}