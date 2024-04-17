// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function app_startup_painter(){
paint_tool_selected = e_paint.BRUSH
paint_view_grid = true
paint_view_brush_guides = false
paint_primary_color = c_black
paint_secondary_color = c_white
paint_opacity = 1
paint_width = 1
paint_tolerance = .25
filling = false
painter_update_spr = true
fillarr = array_create(0);

//Adjustments
hue=0;
sat=100;
val=0;
adjust_huesat = false;

painter_main_color = 0;
painter_editing_color = 0;
painter_pallette_id = -1;
painter_pallette_col = -1;
pallette_list = ds_list_create()
recentcolor_list = array_create(0)


//History
globalvar painter_history_data;
painter_history[0] = null
painter_history_amount = 0
painter_history_pos = 0
painter_history_undo = 0
painter_history_redo = 0
painter_history_data = null
floodfill_frame_count = 0;
//pallettes_load()

paint_texture_width = 16
paint_texture_height = 16
texture_surf = surface_create(paint_texture_width, paint_texture_height)
draw_surf = surface_create(paint_texture_width, paint_texture_height)
alpha_surf = surface_create(paint_texture_width, paint_texture_height)
color_surf = surface_create(paint_texture_width, paint_texture_height)
selection_surf = surface_create(paint_texture_width, paint_texture_height)
transform_surf = surface_create(paint_texture_width, paint_texture_height)
view_offset_x = 0
view_offset_y = 0
target_view_offset_x = 0
target_view_offset_y = 0

texspr = sprite_duplicate(spr_empty)
colorspr = sprite_create_from_surface(color_surf,0,0,paint_texture_width, paint_texture_height, false,false, 0,0)
finalspr = sprite_create_from_surface(color_surf, 0,0,surface_get_width(color_surf), surface_get_height(color_surf), false, false, 0, 0)
alphaspr = sprite_create_from_surface(alpha_surf, 0,0,surface_get_width(alpha_surf), surface_get_height(alpha_surf), false, false, 0, 0)
selectionspr = sprite_create_from_surface(selection_surf, 0,0,surface_get_width(selection_surf), surface_get_height(selection_surf), false, false, 0, 0)
transformspr = sprite_create_from_surface(selection_surf, 0,0,surface_get_width(selection_surf), surface_get_height(selection_surf), false, false, 0, 0)
seltrnspr = sprite_create_from_surface(selection_surf, 0,0,surface_get_width(selection_surf), surface_get_height(selection_surf), false, false, 0, 0)
targetzoom = 5

zoom = targetzoom
scale_offset_x= window_get_width() / 2 - (paint_texture_width*zoom /2 )
scale_offset_y = window_get_height() / 2 - (paint_texture_width*zoom /2 )

mouse_x_prev = window_mouse_get_x() - scale_offset_x
mouse_y_prev = window_mouse_get_y() - scale_offset_y

selection_pos = vec2(0,0)
drawsize = vec2(0,0)
selection_topleft = vec2(0,0)
selection_btmright = vec2(0,0)
selection_topleft_prev = vec2(0,0)
selection_btmright_prev = vec2(0,0)
selection_size = vec2(selection_btmright[0]-selection_topleft[0],selection_btmright[1]-selection_topleft[1]);
selection_active = false
selection_moved = false
}