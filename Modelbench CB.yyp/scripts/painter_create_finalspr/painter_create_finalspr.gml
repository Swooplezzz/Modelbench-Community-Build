/// painter_create_finalspr()

function painter_create_finalspr()
{
	if (sprite_exists(finalspr))
		sprite_delete(finalspr)
	finalspr = sprite_create_from_surface(colorsurf, 0,0,surface_get_width(colorsurf), surface_get_height(colorsurf), false, false, 0, 0)
	sprite_set_alpha_from_sprite(finalspr, alphaspr)
}