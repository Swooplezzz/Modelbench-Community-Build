// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function add_recent_color(color){
	if(array_length(recentcolor_list) > 11){
		array_delete(recentcolor_list,11,1);
	}
	array_insert(recentcolor_list,0, color);
}