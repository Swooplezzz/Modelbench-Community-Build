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
paint_tolerance = .05
filling = false
painter_update_spr = true
fillarr = array_create(0);
painter_main_color = 0;
painter_editing_color = 0;
painter_pallette_id = -1;
painter_pallette_col = -1;
pallette_list = ds_list_create()
recentcolor_list = array_create(0)

globalvar painter_history_data;
painter_history[0] = null
painter_history_amount = 0
painter_history_pos = 0
painter_history_undo = 0
painter_history_redo = 0
painter_history_data = null

pallettes_load()

texturewidth = 16
textureheight = 16
texsurf = surface_create(texturewidth, textureheight)
drawsurf = surface_create(texturewidth, textureheight)
alphasurf = surface_create(texturewidth, textureheight)
colorsurf = surface_create(texturewidth, textureheight)
selectionsurf = surface_create(texturewidth, textureheight)
transformsurf = surface_create(texturewidth, textureheight)
offx = 0
offy = 0
targetoffx = 0
targetoffy = 0

texspr = sprite_duplicate(spr_empty)
colorspr = sprite_create_from_surface(colorsurf,0,0,texturewidth, textureheight, false,false, 0,0)
finalspr = sprite_create_from_surface(colorsurf, 0,0,surface_get_width(colorsurf), surface_get_height(colorsurf), false, false, 0, 0)
alphaspr = sprite_create_from_surface(alphasurf, 0,0,surface_get_width(alphasurf), surface_get_height(alphasurf), false, false, 0, 0)
selectionspr = sprite_create_from_surface(selectionsurf, 0,0,surface_get_width(selectionsurf), surface_get_height(selectionsurf), false, false, 0, 0)
transformspr = sprite_create_from_surface(selectionsurf, 0,0,surface_get_width(selectionsurf), surface_get_height(selectionsurf), false, false, 0, 0)
seltrnspr = sprite_create_from_surface(selectionsurf, 0,0,surface_get_width(selectionsurf), surface_get_height(selectionsurf), false, false, 0, 0)
targetzoom = 5

zoom = targetzoom
scale_offset_x= window_get_width() / 2 - (texturewidth*zoom /2 )
scale_offset_y = window_get_height() / 2 - (texturewidth*zoom /2 )

mouse_x_prev = window_mouse_get_x() - scale_offset_x
mouse_y_prev = window_mouse_get_y() - scale_offset_y

selection_pos = vec2(0,0)
selection_topleft = vec2(0,0)
selection_btmright = vec2(0,0)
selection_topleft_prev = vec2(0,0)
selection_btmright_prev = vec2(0,0)
selectionsize = vec2(selection_btmright[0]-selection_topleft[0],selection_btmright[1]-selection_topleft[1]);
selection_active = false
}