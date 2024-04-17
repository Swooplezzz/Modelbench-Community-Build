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
		
		finalspr = sprite_duplicate(painter_history[painter_history_pos].sprite)
		
		surface_set_target(alpha_surf){
				draw_clear_alpha(c_black, 1)
			alphafix
			shader_set(shader_alphamask)
			draw_sprite(finalspr,0,0,0)
			shader_reset()
						gpu_set_blendmode(bm_normal)
		}
		surface_reset_target()
		surface_set_target(color_surf){
			draw_clear_alpha(c_black, 0)
			shader_set(shader_colormask)
			draw_sprite(finalspr,0,0,0)
			shader_reset()
						gpu_set_blendmode(bm_normal)
		}
		surface_reset_target()
		colorspr = sprite_create_from_surface(color_surf,0,0,surface_get_width(color_surf),surface_get_height(color_surf), false, false,0,0)
		alphaspr = sprite_create_from_surface(alpha_surf,0,0,surface_get_width(alpha_surf),surface_get_height(alpha_surf), false, false,0,0)
		painter_update_spr = true;
		
		
		if(painter_history[painter_history_pos].val = "selection"){
			paint_tool_selected = e_paint.BOX_SELECT
		}
		selectionspr = sprite_duplicate(painter_history[painter_history_pos].selsprite)
			surface_set_target(selection_surf){
            draw_sprite(selectionspr,0,0,0)
	        }
	        surface_reset_target()
		transformspr = sprite_duplicate(painter_history[painter_history_pos].trnsprite)

		
		if(painter_history[painter_history_pos].val = "transform"){
		paint_tool_selected = e_paint.TRANSFORM
		selection_moved = true
		
		}

		selection_topleft = painter_history[painter_history_pos].pos_tl;
		selection_btmright = painter_history[painter_history_pos].pos_br;
		selection_size = painter_history[painter_history_pos].sel_size;
		selection_active = painter_history[painter_history_pos].sel_active;
		if(!selection_active){
			surface_set_target(selection_surf){
		draw_clear_alpha(c_black,0)
		selection_topleft = vec2(0,0)
		selection_btmright = vec2(0,0)
	     }
	     surface_reset_target()	
		}
	}
}
else if(keyboard_check_pressed(ord("Z"))){
	if(painter_history_pos + 1< painter_history_amount){
		painter_history_pos += 1;
		if(sprite_exists(alphaspr))
		sprite_delete(alphaspr)
		if(sprite_exists(colorspr))
		sprite_delete(colorspr)
		
		finalspr = sprite_duplicate(painter_history[painter_history_pos].sprite)
		
		surface_set_target(alpha_surf){
				draw_clear_alpha(c_black, 1)
			alphafix
			shader_set(shader_alphamask)
			draw_sprite(finalspr,0,0,0)
			shader_reset()
			gpu_set_blendmode(bm_normal)
		}
		surface_reset_target()
		surface_set_target(color_surf){
			draw_clear_alpha(c_black, 0)
			shader_set(shader_colormask)
			draw_sprite(finalspr,0,0,0)
			shader_reset()
						gpu_set_blendmode(bm_normal)
		}
		surface_reset_target()
		colorspr = sprite_create_from_surface(color_surf,0,0,surface_get_width(color_surf),surface_get_height(color_surf), false, false,0,0)
		alphaspr = sprite_create_from_surface(alpha_surf,0,0,surface_get_width(alpha_surf),surface_get_height(alpha_surf), false, false,0,0)
		painter_update_spr = true;
		
		
		if(painter_history[painter_history_pos].val = "selection"){
			paint_tool_selected = e_paint.BOX_SELECT
		}
			
		selectionspr = sprite_duplicate(painter_history[painter_history_pos].selsprite)
			surface_set_target(selection_surf){
            draw_sprite(selectionspr,0,0,0)
	        }
	        surface_reset_target()
		transformspr = sprite_duplicate(painter_history[painter_history_pos].trnsprite)

		
		if(painter_history[painter_history_pos].val = "transform"){
		paint_tool_selected = e_paint.TRANSFORM
		selection_moved = true;
		}

		selection_topleft = painter_history[painter_history_pos].pos_tl;
		selection_btmright = painter_history[painter_history_pos].pos_br;
		selection_size = painter_history[painter_history_pos].sel_size;
		selection_active = painter_history[painter_history_pos].sel_active;
		if(!selection_active){
			surface_set_target(selection_surf){
		draw_clear_alpha(c_black,0)
		selection_topleft = vec2(0,0)
		selection_btmright = vec2(0,0)
	     }
	     surface_reset_target()	
		}
	}
}
}
}