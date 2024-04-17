/// painter_update_transform_sprite()

function painter_update_transform_sprite()
{
	if (selection_size[X] > 0 && selection_size[Y] > 0)
	{
	    surface_set_target(transform_surf)
		{
			draw_clear_alpha(c_black, 0)
			alphafix
			gpu_set_colorwriteenable(false,false,false,true)
		    draw_sprite_ext(final_spr,0,-selection_topleft[X], -selection_topleft[Y],1,1,0,c_white,1);
			gpu_set_colorwriteenable(true,true,true,false)
		    draw_sprite_ext(final_spr,0,-selection_topleft[X], -selection_topleft[Y],1,1,0,c_white,1);
			gpu_set_colorwriteenable(true,true,true,true)

	        gpu_set_blendmode(bm_subtract)
	        draw_set_color(c_black)
	        draw_surface(selection_surf,-selection_topleft[X], -selection_topleft[Y])
	        gpu_set_blendmode(bm_normal)
	    }
		surface_reset_target()
		
		if (sprite_exists(transform_spr))
			sprite_delete(transform_spr)
		transform_spr = sprite_create_from_surface(transform_surf,0, 0,selection_size[X],selection_size[Y],false,false,0,0);

		surface_set_target(draw_surf)
		{
			draw_clear(c_black)
			gpu_set_blendmode(bm_subtract)
			draw_set_color(c_black)
			draw_surface(selection_surf,0,0)
			gpu_set_blendmode(bm_normal)
		}
		surface_reset_target()
		
		if (sprite_exists(sel_trn_spr))
			sprite_delete(sel_trn_spr)
		sel_trn_spr = sprite_create_from_surface(draw_surf,selection_topleft[X],selection_topleft[Y],selection_size[X],selection_size[Y],false,false,0,0)
		
		surface_set_target(draw_surf)
		{
			draw_clear_alpha(c_black,0)
		}
		surface_reset_target()
	}
}