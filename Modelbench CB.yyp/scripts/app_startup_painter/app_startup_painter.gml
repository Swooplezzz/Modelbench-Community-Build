// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function app_startup_painter(){
paint_tool_selected = e_paint.BRUSH
paint_primary_color = c_white
paint_secondary_color = c_black
paint_opacity = 1
paint_width = 1
paint_tolerance = .05
filling = false

fillarr = array_create(0);

pallette_list = ds_list_create()

	globalvar painter_history_data;
	painter_history[0] = null
	painter_history_amount = 0
	painter_history_pos = 0
	painter_history_undo = 0
	painter_history_redo = 0
	painter_history_data = null

pallettes_load()

texturewidth = res_edit.size[X]
textureheight = res_edit.size[Y]
texsurf = surface_create(texturewidth, textureheight)
drawsurf = surface_create(texturewidth, textureheight)
alphasurf = surface_create(texturewidth, textureheight)
colorsurf = surface_create(texturewidth, textureheight)
selectionsurf = surface_create(texturewidth, textureheight)
	surface_set_target(selectionsurf){
		draw_clear_alpha(c_white,0)
	}
	surface_reset_target()

offx = 0
offy = 0
targetoffx = 0
targetoffy = 0
texspr = res_edit.sprite

surface_set_target(alphasurf){
shader_set(shader_alphamask)
draw_clear(c_black)
alphafix
draw_sprite(texspr,0,0,0)
gpu_set_blendmode(bm_normal)
shader_reset();
}
surface_reset_target()

surface_set_target(colorsurf){
shader_set(shader_colormask)

draw_sprite(texspr,0,0,0)
shader_reset();
}
surface_reset_target()

colorspr = sprite_create_from_surface(colorsurf,0,0,texturewidth, textureheight, false,false, 0,0)
	finalspr = sprite_create_from_surface(colorsurf, 0,0,surface_get_width(colorsurf), surface_get_height(colorsurf), false, false, 0, 0)
alphaspr = sprite_create_from_surface(alphasurf, 0,0,surface_get_width(alphasurf), surface_get_height(alphasurf), false, false, 0, 0)
selectionspr = sprite_create_from_surface(selectionsurf, 0,0,surface_get_width(selectionsurf), surface_get_height(selectionsurf), false, false, 0, 0)
targetzoom = 5

zoom = targetzoom
scale_offset_x= window_get_width() / 2 - (texturewidth*zoom /2 )
scale_offset_y = window_get_height() / 2 - (texturewidth*zoom /2 )

mouse_x_prev = window_mouse_get_x() - scale_offset_x
mouse_y_prev = window_mouse_get_y() - scale_offset_y

select_pos_one = vec2(0,0)
select_pos_two = vec2(0,0)

selection_active = false
}