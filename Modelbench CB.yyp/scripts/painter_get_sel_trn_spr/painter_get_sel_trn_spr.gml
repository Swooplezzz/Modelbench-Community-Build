// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function painter_get_sel_trn_spr(){
	surface_set_target(draw_surf){
draw_clear(c_black)
gpu_set_blendmode(bm_subtract)
draw_set_color(c_black)
draw_surface(selection_surf,0,0)
gpu_set_blendmode(bm_normal)
}
surface_reset_target()
if(sprite_exists(seltrnspr))
sprite_delete(seltrnspr)
seltrnspr = sprite_create_from_surface(draw_surf,selection_topleft[X],selection_topleft[Y],selection_size[X],selection_size[Y],false,false,0,0)
	surface_set_target(draw_surf){
		draw_clear_alpha(c_black,0)
	}
	surface_reset_target()
}