// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function painter_apply_brightness_contrast(){
	var sizex, sizey;
if(paint_tool_selected = e_paint.TRANSFORM_SELECTION)
painter_history_set("transform", final_spr, selection_spr, transform_spr)
else
painter_history_set("painting", final_spr, selection_spr, transform_spr)
var offsetx = sprite_get_xoffset(transform_spr);
var offsety = sprite_get_yoffset(transform_spr);
sprite_set_offset(transform_spr, 0, 0)

	sizex = (selection_btmright[0] - selection_topleft[0]);
	sizey = (selection_btmright[1] - selection_topleft[1]);
surface_set_target(color_surf){
alphafix
	draw_clear_alpha(c_black, 0)
draw_sprite(color_spr,0,0,0)

    render_shader_obj = shader_map[?shader_contrast_brightness]
	
    shader_set(shader_contrast_brightness)
    render_set_uniform("uBrightness", painter_adjust_brightness/100)
    render_set_uniform("uContrast", painter_adjust_contrast/100)
    render_set_uniform("u_colmask", 1.0)
	with(render_shader_obj)
    texture_set_stage(sampler_map[?"u_clipsampler"], surface_get_texture(other.selection_surf))
    
	

	draw_sprite_ext(transform_spr, 0, (selection_topleft[X]), (selection_topleft[Y]), sizex / selection_size[X], sizey / selection_size[Y], 0, c_white, 1)

	shader_reset()
	gpu_set_blendmode(bm_normal)

}
surface_reset_target()



if(sprite_exists(alpha_spr))
sprite_delete(alpha_spr)
alpha_spr = sprite_create_from_surface(alpha_surf, 0,0,surface_get_width(alpha_surf), surface_get_height(alpha_surf), false, false, 0, 0)

if(sprite_exists(color_spr))
sprite_delete(color_spr)
color_spr = sprite_create_from_surface(color_surf, 0,0,surface_get_width(color_surf), surface_get_height(color_surf), false, false, 0, 0)

painter_create_finalspr();
		painter_update_selection_bounds()
		selection_size = vec2(selection_btmright[0] - selection_topleft[0], selection_btmright[1] - selection_topleft[1])

	selection_moved = false
			selection_rot = 0
		selection_pos = [selection_topleft[X] + selection_size[X] / 2, selection_topleft[Y] + selection_size[Y] / 2]
			painter_update_spr = true;
	sprite_set_offset(transform_spr, offsetx, offsety)
painter_done(true);
   if(paint_tool_selected = e_paint.TRANSFORM_SELECTION)
	painter_clear_selection()
adjusting_brightness_contrast = false;


popup_close();
}