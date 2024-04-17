// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function painter_update_floodfill(){

if(array_length(fill_arr) > 0){
for(var a = array_length(fill_arr) - 1; a >= 0; a--){

draw_floodfill(fill_arr[a].surf,fill_arr[a].alpha_surf,fill_arr[a].xx,fill_arr[a].yy,fill_arr[a].targ_color,fill_arr[a].color, fill_arr[a].side, fill_arr[a].targ_alpha)	


array_delete(fill_arr, a,1)
}

if(sprite_exists(color_spr))
sprite_delete(color_spr)
color_spr = sprite_create_from_surface(color_surf, 0,0,surface_get_width(color_surf), surface_get_height(color_surf), false, false, 0, 0)
if(sprite_exists(alpha_spr))
sprite_delete(alpha_spr)
alpha_spr = sprite_create_from_surface(alpha_surf, 0,0,surface_get_width(alpha_surf), surface_get_height(alpha_surf), false, false, 0, 0)

}
if(array_length(fill_arr) = 0 && filling){
filling = false	
	buffer_set_surface(fill_buffer, color_surf,0);
	buffer_set_surface(alpha_fill_buffer, alpha_surf,0);
	buffer_delete(fill_buffer)
	buffer_delete(selection_buffer)
	buffer_delete(alpha_fill_buffer)
if(sprite_exists(color_spr))
sprite_delete(color_spr)
color_spr = sprite_create_from_surface(color_surf, 0,0,surface_get_width(color_surf), surface_get_height(color_surf), false, false, 0, 0)
if(sprite_exists(alpha_spr))
sprite_delete(alpha_spr)
alpha_spr = sprite_create_from_surface(alpha_surf, 0,0,surface_get_width(alpha_surf), surface_get_height(alpha_surf), false, false, 0, 0)
painter_create_final_spr()
painter_history_set("painting", final_spr, selection_spr, transform_spr)

}
}