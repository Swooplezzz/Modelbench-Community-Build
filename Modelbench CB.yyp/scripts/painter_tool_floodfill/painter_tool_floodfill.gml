// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function painter_tool_floodfill(mousexsnap,mouseysnap,inbounds){
if((mouse_check_button_pressed(mb_left) || mouse_check_button_pressed(mb_right)) && paint_tool_selected = e_paint.FILL && !filling && inbounds){
	var color = (mouse_check_button_pressed(mb_left)? paint_primary_color : paint_secondary_color)
	if(painter_main_color = 1)
	 color = (mouse_check_button_pressed(mb_left)? paint_secondary_color : paint_primary_color)

fill_buffer = buffer_create(texturewidth * textureheight * 4, buffer_fixed, 1);
selection_buffer = buffer_create(texturewidth * textureheight * 4, buffer_fixed, 1);
alpha_fill_buffer = buffer_create(texturewidth * textureheight * 4, buffer_fixed, 1);
    buffer_get_surface(fill_buffer, colorsurf, 0);
    buffer_get_surface(selection_buffer, selectionsurf, 0);
    buffer_get_surface(alpha_fill_buffer, alphasurf, 0);
draw_floodfill_add(colorsurf, alphasurf, mousexsnap+ .5, mouseysnap + .5,surface_getpixel(colorsurf, mousexsnap +1, mouseysnap +1), color, 0, color_get_red(surface_getpixel(alphasurf, mousexsnap +1, mouseysnap +1)))



filling = true;
if(sprite_exists(colorspr))
sprite_delete(colorspr)
colorspr = sprite_create_from_surface(colorsurf, 0,0,surface_get_width(colorsurf), surface_get_height(colorsurf), false, false, 0, 0)
if(sprite_exists(alphaspr))
sprite_delete(alphaspr)
alphaspr = sprite_create_from_surface(alphasurf, 0,0,surface_get_width(alphasurf), surface_get_height(alphasurf), false, false, 0, 0)

}


}