// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function painter_update_floodfill(){

if(array_length(fillarr) > 0){
	var i = 0;
	
for(var a = array_length(fillarr) - 1; a >= 0; a--){

draw_floodfill(fillarr[a].surf,fillarr[a].alpha_surf,fillarr[a].xx,fillarr[a].yy,fillarr[a].targ_color,fillarr[a].color, fillarr[a].side, fillarr[a].targ_alpha)	


array_delete(fillarr, a,1)
}

if(sprite_exists(colorspr))
sprite_delete(colorspr)
colorspr = sprite_create_from_surface(color_surf, 0,0,surface_get_width(color_surf), surface_get_height(color_surf), false, false, 0, 0)
if(sprite_exists(alphaspr))
sprite_delete(alphaspr)
alphaspr = sprite_create_from_surface(alpha_surf, 0,0,surface_get_width(alpha_surf), surface_get_height(alpha_surf), false, false, 0, 0)

}
if(array_length(fillarr) = 0 && filling){
filling = false	
	buffer_set_surface(fill_buffer, color_surf,0);
	buffer_set_surface(alpha_fill_buffer, alpha_surf,0);
	buffer_delete(fill_buffer)
	buffer_delete(selection_buffer)
	buffer_delete(alpha_fill_buffer)
if(sprite_exists(colorspr))
sprite_delete(colorspr)
colorspr = sprite_create_from_surface(color_surf, 0,0,surface_get_width(color_surf), surface_get_height(color_surf), false, false, 0, 0)
if(sprite_exists(alphaspr))
sprite_delete(alphaspr)
alphaspr = sprite_create_from_surface(alpha_surf, 0,0,surface_get_width(alpha_surf), surface_get_height(alpha_surf), false, false, 0, 0)
painter_create_finalspr()
painter_history_set("painting", finalspr, selectionspr, transformspr)

}
}