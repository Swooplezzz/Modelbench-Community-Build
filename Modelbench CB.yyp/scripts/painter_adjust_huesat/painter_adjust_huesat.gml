/// painter_adjust_huesat()

function painter_adjust_huesat()
{
  render_shader_obj = shader_map[?shader_huesat]

    shader_set(shader_huesat)
    render_set_uniform("u_Position", hue)
    render_set_uniform("u_Position_s", sat/100)
    render_set_uniform("u_Position_l", val/100)
    render_set_uniform("u_colmask", 0.0)
    texture_set_stage(render_shader_obj.sampler_map[?"u_clipsampler"], surface_get_texture(selection_surf))
    
    alphafix
    draw_sprite_ext(final_spr, 0, scale_offset_x, scale_offset_y, zoom, zoom,0, c_white, 1)
    gpu_set_blendmode(bm_normal);
    shader_reset();
   draw_painter_selection_outline(c_white, 1, 0.0, false,paint_texture_width * zoom,paint_texture_height * zoom);
}