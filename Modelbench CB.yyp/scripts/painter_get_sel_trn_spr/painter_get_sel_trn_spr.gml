// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function painter_get_sel_trn_spr(){
	surface_set_target(drawsurf){
draw_clear(c_black)
gpu_set_blendmode(bm_subtract)
draw_set_color(c_black)
draw_surface(selectionsurf,0,0)
gpu_set_blendmode(bm_normal)
}
surface_reset_target()
if(sprite_exists(seltrnspr))
sprite_delete(seltrnspr)
seltrnspr = sprite_create_from_surface(drawsurf,selection_topleft[X],selection_topleft[Y],selectionsize[X],selectionsize[Y],false,false,0,0)
	surface_set_target(drawsurf){
		draw_clear_alpha(c_black,0)
	}
	surface_reset_target()
}