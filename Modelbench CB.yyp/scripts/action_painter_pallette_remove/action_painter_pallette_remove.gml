// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function action_painter_pallette_remove(pos){
ds_list_delete(pallette_list, pos)
pallettes_save()
}