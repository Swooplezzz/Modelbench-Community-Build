// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function painter_reset(){

filling = false
painter_update_spr = true
fillarr = array_create(0);
painter_history_clear();
painter_history[0] = null
painter_history_amount = 0
painter_history_pos = 0
painter_history_undo = 0
painter_history_redo = 0
painter_history_data = null

paint_texture_width = res_edit.size[X]
paint_texture_height = res_edit.size[Y]
texture_surf = surface_require(texture_surf, paint_texture_width, paint_texture_height)
draw_surf = surface_require(draw_surf, paint_texture_width, paint_texture_height)
alpha_surf = surface_require(alpha_surf, paint_texture_width, paint_texture_height)
color_surf = surface_require(color_surf, paint_texture_width, paint_texture_height)
selection_surf = surface_require(selection_surf, paint_texture_width, paint_texture_height)
	surface_set_target(selection_surf){
		draw_clear_alpha(c_white,0)
	}
	surface_reset_target()

view_offset_x = 0
view_offset_y = 0
target_view_offset_x = 0
target_view_offset_y = 0

if(sprite_exists(texspr))
sprite_delete(texspr);

if(sprite_exists(res_edit.sprite))
texspr = sprite_duplicate(res_edit.sprite)

surface_set_target(alpha_surf){
draw_clear(c_black)
shader_set(shader_alphamask)
alphafix
draw_sprite(texspr,0,0,0)
gpu_set_blendmode(bm_normal)
shader_reset();
}
surface_reset_target()

surface_set_target(color_surf){
	draw_clear_alpha(c_black, 0)
shader_set(shader_colormask)

draw_sprite(texspr,0,0,0)
shader_reset();
}
surface_reset_target()

colorspr = sprite_create_from_surface(color_surf,0,0,paint_texture_width, paint_texture_height, false,false, 0,0)
	finalspr = sprite_create_from_surface(color_surf, 0,0,surface_get_width(color_surf), surface_get_height(color_surf), false, false, 0, 0)
alphaspr = sprite_create_from_surface(alpha_surf, 0,0,surface_get_width(alpha_surf), surface_get_height(alpha_surf), false, false, 0, 0)
selectionspr = sprite_create_from_surface(selection_surf, 0,0,surface_get_width(selection_surf), surface_get_height(selection_surf), false, false, 0, 0)
targetzoom = 5

painter_history_set("painting", texspr, selectionspr, transformspr)

zoom = targetzoom
scale_offset_x= window_get_width() / 2 - (paint_texture_width*zoom /2 )
scale_offset_y = window_get_height() / 2 - (paint_texture_width*zoom /2 )

paintercolorpicker.def = c_black
paintercolorpicker.color = paint_primary_color
paintercolorpicker.red = color_get_red(paint_primary_color)
paintercolorpicker.green = color_get_green(paint_primary_color)
paintercolorpicker.blue = color_get_blue(paint_primary_color)
		
paintercolorpicker.hue = color_get_hue(paint_primary_color)
paintercolorpicker.saturation = color_get_saturation(paint_primary_color)
paintercolorpicker.brightness = color_get_value(paint_primary_color)
		
paintercolorpicker.tbx_red.text = string(paintercolorpicker.red)
paintercolorpicker.tbx_green.text = string(paintercolorpicker.green)
paintercolorpicker.tbx_blue.text = string(paintercolorpicker.blue)
paintercolorpicker.tbx_hexadecimal.text = color_to_hex(paint_primary_color)
		
selection_active = false
}