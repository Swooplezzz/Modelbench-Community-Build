// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function painter_history_limit(){
if(painter_history_amount > 800){
	sprite_delete(painter_history[painter_history_amount]);
	painter_history_amount--;
	
}
}