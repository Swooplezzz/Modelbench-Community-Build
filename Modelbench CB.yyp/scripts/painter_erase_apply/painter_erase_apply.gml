// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function painter_erase_apply(){
surface_set_target(alpha_surf){

draw_clear_alpha(c_black, 1)
draw_sprite_ext(alphaspr, 0,0,0,1,1,0, c_white, 1)
draw_surface_ext(draw_surf,0,0,1,1,0, c_black, 1)

}
surface_reset_target();
if(sprite_exists(alphaspr))
sprite_delete(alphaspr)

alphaspr = sprite_create_from_surface(alpha_surf, 0,0,surface_get_width(alpha_surf), surface_get_height(alpha_surf), false, false, 0, 0)
surface_set_target(color_surf){

	draw_clear_alpha(c_black, 0)

draw_sprite(colorspr,0,0,0)
gpu_set_blendmode(bm_subtract);
draw_surface_ext(draw_surf,0,0,1,1,0,c_black, 1)

gpu_set_blendmode(bm_normal);


}
surface_reset_target()
if(sprite_exists(colorspr))
sprite_delete(colorspr)
colorspr = sprite_create_from_surface(color_surf, 0,0,surface_get_width(color_surf), surface_get_height(color_surf), false, false, 0, 0)
surface_set_target(draw_surf){
	draw_clear_alpha(c_black, 0)
	}
surface_reset_target();
}