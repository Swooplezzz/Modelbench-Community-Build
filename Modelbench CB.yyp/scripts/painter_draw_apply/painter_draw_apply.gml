// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function painter_draw_apply(){
//Update the surfaces and sprites after draw.
if(mouse_check_button_released(mb_right) || mouse_check_button_released(mb_left)){


surface_set_target(alphasurf){

draw_clear_alpha(c_black, 1)
draw_sprite_ext(alphaspr, 0,0,0,1,1,0, c_white, 1)

shader_set(shader_alphamask)
alphafix
draw_surface_ext(drawsurf,0,0,1,1,0, c_white, paint_opacity)
shader_reset()
   gpu_set_colorwriteenable(true, true, true, true);

gpu_set_blendmode(bm_normal);
}
surface_reset_target();
	

if(sprite_exists(alphaspr))
sprite_delete(alphaspr)
alphaspr = sprite_create_from_surface(alphasurf, 0,0,surface_get_width(alphasurf), surface_get_height(alphasurf), false, false, 0, 0)

surface_set_target(colorsurf){

alphafix
	draw_clear_alpha(c_black, 0)
shader_set(shader_premalpha)
draw_surface_ext(drawsurf,0,0,1,1,0,c_white, 1)

draw_sprite(colorspr,0,0,0)

draw_surface_ext(drawsurf,0,0,1,1,0,c_white, paint_opacity)
shader_reset()

gpu_set_blendmode(bm_normal);


}
surface_reset_target()
if(sprite_exists(colorspr))
sprite_delete(colorspr)
colorspr = sprite_create_from_surface(colorsurf, 0,0,surface_get_width(colorsurf), surface_get_height(colorsurf), false, false, 0, 0)
	surface_set_target(drawsurf){
	draw_clear_alpha(c_black, 0)
	}
	surface_reset_target();
	

painter_update_spr = true;
}
}