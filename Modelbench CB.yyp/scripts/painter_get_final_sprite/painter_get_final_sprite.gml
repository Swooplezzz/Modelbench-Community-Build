// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function painter_get_final_sprite(inbounds){
surface_set_target(colorsurf){
	draw_clear_alpha(c_black,0)
	draw_sprite(colorspr,0,0,0)
}
surface_reset_target()
//Update the alpha mask.
surface_set_target(alphasurf){
	draw_clear(c_black)

draw_sprite(alphaspr,0,0,0)

gpu_set_blendmode(bm_normal);
}
surface_reset_target()

if(sprite_exists(finalspr))
sprite_delete(finalspr)
finalspr = sprite_create_from_surface(colorsurf, 0,0,surface_get_width(colorsurf), surface_get_height(colorsurf), false, false, 0, 0)
sprite_set_alpha_from_sprite(finalspr, alphaspr)
if(mouse_check_button_released(mb_right) || mouse_check_button_released(mb_left)){
	if(paint_tool_selected = e_paint.BRUSH || paint_tool_selected = e_paint.ERASE){
	painter_history_pop()
	painter_history_push()
	painter_history[0] = sprite_duplicate(finalspr);
	painter_history_limit()
	show_debug_message(painter_history_amount)
	}
}
}