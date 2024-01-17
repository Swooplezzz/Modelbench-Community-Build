// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function painter_update_floodfill(){

if(array_length(fillarr) > 0){
for(var a = 0; a < array_length(fillarr); a++){
	if(a > 250) break;
draw_floodfill(fillarr[a].surf,fillarr[a].alphasurf,fillarr[a].xx,fillarr[a].yy,fillarr[a].targ_color,fillarr[a].color, fillarr[a].side, fillarr[a].targ_alpha)	

array_delete(fillarr, a,1)
}

if(sprite_exists(colorspr))
sprite_delete(colorspr)
colorspr = sprite_create_from_surface(colorsurf, 0,0,surface_get_width(colorsurf), surface_get_height(colorsurf), false, false, 0, 0)
if(sprite_exists(alphaspr))
sprite_delete(alphaspr)
alphaspr = sprite_create_from_surface(alphasurf, 0,0,surface_get_width(alphasurf), surface_get_height(alphasurf), false, false, 0, 0)

}
if(array_length(fillarr) = 0 && filling){
filling = false	
if(sprite_exists(finalspr))
sprite_delete(finalspr)
finalspr = sprite_create_from_surface(colorsurf, 0,0,surface_get_width(colorsurf), surface_get_height(colorsurf), false, false, 0, 0)
	painter_history_pop()
	painter_history_push()
	painter_history[0] = sprite_duplicate(finalspr);
	painter_history_limit()
}
}