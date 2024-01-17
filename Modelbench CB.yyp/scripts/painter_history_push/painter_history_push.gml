// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function painter_history_push(){
	painter_history_amount++;
	for (var h = painter_history_amount; h > 0; h--)
		painter_history[h] = painter_history[h - 1]
}