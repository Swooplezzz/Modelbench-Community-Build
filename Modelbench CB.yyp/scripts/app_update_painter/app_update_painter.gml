// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function app_update_painter(){
if(painter_update_spr = true && res_edit != null){
	show_debug_message(true)
if(sprite_exists(res_edit.sprite))
sprite_delete(res_edit.sprite)
res_edit.sprite = sprite_duplicate(finalspr)
textures_list.update = true;
painter_update_spr = false
}
//selectionsize = vec2(selection_btmright[0]-selection_topleft[0],selection_btmright[1]-selection_topleft[1]);
}