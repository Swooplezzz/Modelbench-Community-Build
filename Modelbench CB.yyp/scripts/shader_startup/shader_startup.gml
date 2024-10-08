/// shader_startup()

function shader_startup()
{
	globalvar shader_map, shader_texture_surface, shader_texture_filter_linear, shader_texture_filter_mipmap;
	globalvar shader_clip_x, shader_clip_y, shader_clip_width, shader_clip_height, shader_clip_active;
	
	// Clip
	shader_clip_x = 0
	shader_clip_y = 0
	shader_clip_width = 0
	shader_clip_height = 0
	shader_clip_active = false
	
	// Init shaders
	log("Shader init")
	log("shaders_are_supported", yesno(shaders_are_supported()))
	
	var err = false;
	if (!shaders_are_supported())
		err = true
	
	// Compiled?
	if (!err)
	{
		shader_map = ds_map_create()
		
		shader_texture_surface = false
		shader_texture_filter_linear = false
		shader_texture_filter_mipmap = false
		
		new_shader("shader_draw_texture")
		new_shader("shader_color")
		new_shader("shader_color_light")
		new_shader("shader_sky")
		new_shader("shader_preview")
		new_shader("shader_depth")
		new_shader("shader_high_light_sun")
		new_shader("shader_high_ssao")
		new_shader("shader_high_ssao_blur")
		new_shader("shader_high_ssao_depth_normal")
		new_shader("shader_shape")
		new_shader("shader_shape_outline")
		new_shader("shader_normals")
		new_shader("shader_high_aa")
		new_shader("shader_border")
		new_shader("shader_alpha_fix")
		new_shader("shader_alpha_test")
		new_shader("shader_clip")
		new_shader("shader_ground")
		new_shader("shader_selection_outline")
		//new_shader("shader_high_bevel")
		new_shader("shader_hue_yiq")
		new_shader("shader_contrast_brightness")
		new_shader("shader_huesat")
		new_shader("shader_premalphacolmask")


		
		with (obj_shader)
		{
			log(name + " compiled", yesno(shader_is_compiled(shader)))
			
			if (!shader_is_compiled(shader))
			{
				err = true
				break
			}
		}
	
	}
	
	if (err)
	{
		log("Shader compilation failed, try updating your graphics drivers.")
		show_message("Some shaders failed to compile.\nCheck that your graphics drivers are up-to-date and restart Modelbench.")
		
		game_end()
		return false
	}
	
	with (shader_map[?shader_color])
	{
		new_shader_uniform("uMixColor")
		new_shader_uniform("uHighlightColor")
	}
	
	with (shader_map[?shader_premalphacolmask])
	{
		new_shader_sampler("u_alphamask")
	}
	
	with (shader_map[?shader_color_light])
	{
		new_shader_uniform("uMixColor")
		new_shader_uniform("uHighlightColor")
		new_shader_uniform("uBrightness")
		new_shader_uniform("uLightColor")
		new_shader_uniform("uAmbientColor")
		new_shader_uniform("uCameraDirection")
	}
	
	with (shader_map[?shader_sky])
	{
		new_shader_uniform("uColorTop")
		new_shader_uniform("uColorBottom")
		new_shader_uniform("uHorizonPow")
		new_shader_uniform("uContrast")
	}
	
	with (shader_map[?shader_preview])
	{
		new_shader_uniform("uColorLight")
		new_shader_uniform("uColorDark")
		new_shader_uniform("uLightPosition")
		new_shader_uniform("uIsGround")
	}
	
	with (shader_map[?shader_depth])
	{
		new_shader_uniform("uNear")
		new_shader_uniform("uFar")
	}
	
	with (shader_map[?shader_high_light_sun])
	{
		new_shader_uniform("uBrightness")
		new_shader_uniform("uBlockBrightness")
		new_shader_uniform("uIsGround")
		new_shader_uniform("uSunAt")
		new_shader_uniform("uIsSky")
		new_shader_uniform("uLightMatrix")
		new_shader_uniform("uLightPosition")
		new_shader_uniform("uLightNear")
		new_shader_uniform("uLightFar")
		new_shader_uniform("uLightColor")
		new_shader_uniform("uLightAmount")
		new_shader_sampler("uDepthBuffer")
		new_shader_uniform("uBlurQuality")
		new_shader_uniform("uBlurSize")
	}
	
	with (shader_map[?shader_high_ssao])
	{
		new_shader_sampler("uDepthBuffer")
		new_shader_sampler("uNormalBuffer")
		new_shader_sampler("uBrightnessBuffer")
		new_shader_sampler("uNoiseBuffer")
		new_shader_uniform("uNear")
		new_shader_uniform("uFar")
		new_shader_uniform("uProjMatrix")
		new_shader_uniform("uProjMatrixInv")
		new_shader_uniform("uScreenSize")
		new_shader_uniform("uKernel")
		new_shader_uniform("uRadius")
		new_shader_uniform("uPower")
		new_shader_uniform("uColor")
	}
	
	with (shader_map[?shader_high_ssao_blur])
	{
		new_shader_sampler("uDepthBuffer")
		new_shader_sampler("uNormalBuffer")
		new_shader_uniform("uScreenSize")
		new_shader_uniform("uPixelCheck")
	}
	
	with (shader_map[?shader_high_ssao_depth_normal])
	{
		new_shader_uniform("uSSAOEnable")
		new_shader_uniform("uBrightness")
		new_shader_uniform("uNear")
		new_shader_uniform("uFar")
	}
	
	with (shader_map[?shader_shape])
		new_shader_uniform("uShape")
	
	with (shader_map[?shader_shape_outline])
	{
		new_shader_sampler("uShapeBuffer")
		new_shader_sampler("uNormalBuffer")
		new_shader_sampler("uDepthBuffer")
		new_shader_uniform("uTexSize")
		new_shader_uniform("uStrength")
		new_shader_uniform("zFar")
		new_shader_uniform("zNear")
	}
	
	with (shader_map[?shader_high_aa])
	{
		new_shader_uniform("uScreenSize")
		new_shader_uniform("uPower")
	}
	
	
	with (shader_map[?shader_border])
	{
		new_shader_uniform("uTexSize")
		new_shader_uniform("uColor")
		new_shader_uniform("uSize")
	}
	
	with (shader_map[?shader_selection_outline])
	{
		new_shader_uniform("uTexSize")
		new_shader_uniform("uColor")
		new_shader_uniform("uSize")
		new_shader_uniform("uInvert")
	}
	with (shader_map[?shader_clip])
	{
		new_shader_uniform("uBox")
		new_shader_uniform("uScreenSize")
	}
	
	with (shader_map[?shader_ground])
	{
		new_shader_uniform("uFade")
		new_shader_uniform("uFadeColor")
		new_shader_uniform("uFadeStart")
		new_shader_uniform("uFadeEnd")
	}
	
	//with (shader_map[?shader_high_bevel])
	//{
	//	new_shader_sampler("uShapeBuffer")
	//	new_shader_uniform("uTexSize")
	//	new_shader_uniform("uSize")
	//}
	
	with (shader_map[?shader_hue_yiq])
	{
		new_shader_uniform("hueShift")
		new_shader_uniform("satShift")
	}
	
	with (shader_map[?shader_huesat])
	{
		new_shader_uniform("u_Position")
		new_shader_uniform("u_Position_s")
		new_shader_uniform("u_Position_l")
		new_shader_uniform("u_colmask")
		new_shader_sampler("u_clipsampler")
	}
	with (shader_map[?shader_contrast_brightness])
	{
		new_shader_uniform("uBrightness")
		new_shader_uniform("uContrast")
		new_shader_uniform("u_colmask")
		new_shader_sampler("u_clipsampler")
	}
	
	return true
}
