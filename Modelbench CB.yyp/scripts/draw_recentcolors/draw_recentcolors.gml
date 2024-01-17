// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_recentcolors(){
		var xx = dx;
		for(var i = 0; i < array_length(recentcolor_list); i++){
		if(xx >= (dx + content_width - 64 - 28 - 28)){
		xx = dx	
		dy += 28
		}
		
		draw_button_colorpallette("col" + string(i), xx, dy, recentcolor_list[i], action_painter_recent_pick_color)
		xx += 28
		}
		if(xx >= (dx + content_width - 64 - 28 - 28)){
		xx = dx	
		dy += 28
		}
		dy += 38
		}
