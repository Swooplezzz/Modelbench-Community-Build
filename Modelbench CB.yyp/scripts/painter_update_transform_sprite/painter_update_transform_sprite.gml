// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function painter_update_transform_sprite(){
	if(selectionsize[X] > 0 && selectionsize[Y] > 0){

	    surface_set_target(transformsurf){
		draw_clear_alpha(c_black, 0)
		alphafix
		gpu_set_colorwriteenable(false,false,false,true)
	    draw_sprite_ext(finalspr,0,-selection_topleft[X], -selection_topleft[Y],1,1,0,c_white,1);
		gpu_set_colorwriteenable(true,true,true,false)
	    draw_sprite_ext(finalspr,0,-selection_topleft[X], -selection_topleft[Y],1,1,0,c_white,1);
		gpu_set_colorwriteenable(true,true,true,true)

		
        gpu_set_blendmode(bm_subtract)
		
        draw_set_color(c_black)
		
        draw_surface(selectionsurf,-selection_topleft[X], -selection_topleft[Y])
		
        gpu_set_blendmode(bm_normal)
		
	    }
	

	surface_reset_target()
	if(sprite_exists(transformspr))
	sprite_delete(transformspr)
	transformspr = sprite_create_from_surface(transformsurf,0, 0,selectionsize[X],selectionsize[Y],false,false,0,0);

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
}