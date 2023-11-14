// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function painter_tool_floodfill(mousexsnap,mouseysnap,inbounds){
if((mouse_check_button_pressed(mb_left) || mouse_check_button_pressed(mb_right)) && paint_tool_selected = e_paint.FILL && !filling && inbounds){
	var color = (mouse_check_button_pressed(mb_left)? paint_primary_color : paint_secondary_color)
	
draw_floodfill(colorsurf, alphasurf, mousexsnap+ .5, mouseysnap + .5,surface_getpixel(colorsurf, mousexsnap +1, mouseysnap +1), color, 0)
filling = true;
if(sprite_exists(colorspr))
sprite_delete(colorspr)
colorspr = sprite_create_from_surface(colorsurf, 0,0,surface_get_width(colorsurf), surface_get_height(colorsurf), false, false, 0, 0)
if(sprite_exists(alphaspr))
sprite_delete(alphaspr)
alphaspr = sprite_create_from_surface(alphasurf, 0,0,surface_get_width(alphasurf), surface_get_height(alphasurf), false, false, 0, 0)

}


}