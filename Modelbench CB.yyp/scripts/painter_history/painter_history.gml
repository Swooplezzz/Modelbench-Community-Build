// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function painter_history(){
if(keyboard_check(vk_control)){
if(keyboard_check_pressed(ord("Y"))){
	if(painter_history_pos > 0){
		painter_history_pos -= 1;
		
		if(sprite_exists(alphaspr))
		sprite_delete(alphaspr)
		if(sprite_exists(colorspr))
		sprite_delete(colorspr)
		show_debug_message(painter_history_pos);
		finalspr = sprite_duplicate(painter_history[painter_history_pos])
		surface_set_target(alphasurf){
			alphafix
			draw_clear_alpha(c_black, 0)
			shader_set(shader_alphamask)
			draw_sprite(finalspr,0,0,0)
			shader_reset()
			gpu_set_blendmode(bm_normal)
		}
		surface_reset_target()
		surface_set_target(colorsurf){
			alphafix
			draw_clear_alpha(c_black, 0)
			shader_set(shader_colormask)
			draw_sprite(finalspr,0,0,0)
			shader_reset()
			gpu_set_blendmode(bm_normal)
		}
		surface_reset_target()
		colorspr = sprite_create_from_surface(colorsurf,0,0,surface_get_width(colorsurf),surface_get_height(colorsurf), false, false,0,0)
		alphaspr = sprite_create_from_surface(alphasurf,0,0,surface_get_width(alphasurf),surface_get_height(alphasurf), false, false,0,0)
		painter_update_spr = true;
	}
}
else if(keyboard_check_pressed(ord("Z"))){
	if(painter_history_pos + 1< painter_history_amount){
		painter_history_pos += 1;
		if(sprite_exists(alphaspr))
		sprite_delete(alphaspr)
		if(sprite_exists(colorspr))
		sprite_delete(colorspr)
		finalspr = sprite_duplicate(painter_history[painter_history_pos])
			surface_set_target(alphasurf){
							alphafix
				draw_clear_alpha(c_black, 0)
			shader_set(shader_alphamask)
			draw_sprite(finalspr,0,0,0)
			shader_reset()
						gpu_set_blendmode(bm_normal)
		}
		surface_reset_target()
		surface_set_target(colorsurf){
						alphafix
			draw_clear_alpha(c_black, 0)
			shader_set(shader_colormask)
			draw_sprite(finalspr,0,0,0)
			shader_reset()
						gpu_set_blendmode(bm_normal)
		}
		surface_reset_target()
		colorspr = sprite_create_from_surface(colorsurf,0,0,surface_get_width(colorsurf),surface_get_height(colorsurf), false, false,0,0)
		alphaspr = sprite_create_from_surface(alphasurf,0,0,surface_get_width(alphasurf),surface_get_height(alphasurf), false, false,0,0)
		painter_update_spr = true;
	}
}
}
}