///// view_shape_outline()

//function view_shape_outline()
//{
//	if (!setting_overlays_outlines || !setting_overlays || setting_overlays_outline_opacity = 0)
//		return 0
	
//	var shapesurf, normalssurf, depthsurf;
//	render_surface[0] = surface_require(render_surface[0], render_width, render_height)
//	depthsurf = render_surface[0]
//	surface_set_target(depthsurf)
//	{
//		draw_clear_alpha(c_black, 0)
//		proj_depth_near = 1;
//		proj_depth_far = 1000;
//		render_world_start(1000)
//		render_world(e_render_mode.DEPTH_NO_GROUND)
//		render_world_done()
//	}
//	surface_reset_target()
	
//	render_surface[1] = surface_require(render_surface[1], render_width, render_height)
//	normalssurf = render_surface[1]
	
//	surface_set_target(normalssurf)
//	{
//		draw_clear_alpha(c_white, 0)
//		render_world_start()
//		render_world(e_render_mode.NORMALS)
//		render_world_done()
//	}
//	surface_reset_target()
//		render_surface[2] = surface_require(render_surface[2], render_width, render_height)
//	shapesurf = render_surface[2]
//	surface_set_target(shapesurf)
//	{
//		draw_clear_alpha(c_black, 0)
//		render_world_start()
//		render_world(e_render_mode.SHAPE)
//		render_world_done()
//	}
//	surface_reset_target()
//	render_surface[3] = surface_require(render_surface[3], render_width, render_height)
//	var finalsurf = render_surface[3]
//	surface_set_target(finalsurf)
//	{

//		render_shader_obj = shader_map[?shader_shape_outline]
//		with (render_shader_obj)
//		{
//			shader_set(shader_shape_outline)
//			shader_shape_outline_set(shapesurf, normalssurf, depthsurf)
//		}
//		draw_surface_exists(render_target,0,0)
//		with (render_shader_obj)
//			shader_clear()

//	}
//	surface_reset_target()
//		surface_set_target(render_target)
//	{
//		draw_surface_exists(finalsurf,0,0)

//	}
//	surface_reset_target()
//}

// view_shape_outline()

function view_shape_outline()
{
	if (!setting_overlays_outlines || !setting_overlays || setting_overlays_outline_opacity = 0 || program_mode != e_mode.MODELING)
		return 0
	
	var shapesurf, normalssurf;
	render_surface[0] = surface_require(render_surface[0], render_width, render_height)
	shapesurf = render_surface[0]
	surface_set_target(shapesurf)
	{
		draw_clear_alpha(c_black, 0)
		render_world_start()
		render_world(e_render_mode.SHAPE)
		render_world_done()
	}
	surface_reset_target()
	
	render_surface[1] = surface_require(render_surface[1], render_width, render_height)
	normalssurf = render_surface[1]
	
	surface_set_target(normalssurf)
	{
		draw_clear_alpha(c_white, 0)
		render_world_start()
		render_world(e_render_mode.NORMALS)
		render_world_done()
	}
	surface_reset_target()
	
	surface_set_target(render_target)
	{
		gpu_set_blendmode_ext(bm_zero, bm_src_color)
		
		gpu_set_texrepeat(false)
		render_shader_obj = shader_map[?shader_shape_outline]
		with (render_shader_obj)
		{
			shader_set(shader_shape_outline)
			shader_shape_outline_set(shapesurf, normalssurf)
		}
		draw_blank(0, 0, render_width, render_height) // Blank quad
		with (render_shader_obj)
			shader_clear()
		
		gpu_set_texrepeat(true)
		
		gpu_set_blendmode(bm_normal)
	}
	surface_reset_target()
}
