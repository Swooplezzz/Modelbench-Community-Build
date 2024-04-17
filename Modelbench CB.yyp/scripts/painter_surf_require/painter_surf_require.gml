// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function painter_surf_require(){
texture_surf = surface_require(texture_surf, paint_texture_width, paint_texture_height)
draw_surf = surface_require(draw_surf, paint_texture_width, paint_texture_height)
alpha_surf = surface_require(alpha_surf, paint_texture_width, paint_texture_height)
color_surf = surface_require(color_surf, paint_texture_width, paint_texture_height)
selection_surf = surface_require(selection_surf, paint_texture_width, paint_texture_height)
transform_surf = surface_require(transform_surf, paint_texture_width, paint_texture_height)
}