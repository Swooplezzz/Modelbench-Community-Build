/// painter_adjust_brightness_contrast()

function painter_adjust_brightness_contrast()
{
    render_shader_obj = shader_map[?shader_contrast_brightness]
	
    shader_set(shader_contrast_brightness)
    render_set_uniform("uBrightness", painter_adjust_brightness/100)
    render_set_uniform("uContrast", painter_adjust_contrast/100)
    render_set_uniform("u_colmask", 0.0)
	with(render_shader_obj)
    texture_set_stage(sampler_map[?"u_clipsampler"], surface_get_texture(other.selection_surf))

    alphafix
	
    draw_sprite_ext(final_spr, 0, scale_offset_x, scale_offset_y, zoom, zoom,0, c_white, 1)
    gpu_set_blendmode(bm_normal);
    shader_reset();
	
	draw_painter_selection_outline(c_white, 1, paint_texture_width * zoom, paint_texture_height * zoom, 0.0, false);
}