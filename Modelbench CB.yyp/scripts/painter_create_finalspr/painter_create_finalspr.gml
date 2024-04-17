// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function painter_create_finalspr(){
if(sprite_exists(finalspr))
sprite_delete(finalspr)
finalspr = sprite_create_from_surface(color_surf, 0,0,surface_get_width(color_surf), surface_get_height(color_surf), false, false, 0, 0)
sprite_set_alpha_from_sprite(finalspr, alphaspr)

}