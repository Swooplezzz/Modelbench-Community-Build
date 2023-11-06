/// shader_shape_outline_set(shapesurf, normalssurf)
/// @arg shapesurf
/// @arg normalsurf

function shader_shape_outline_set(shapesurf, normalssurf, depthsurf)
{
	texture_set_stage(sampler_map[?"uShapeBuffer"], surface_get_texture(shapesurf))
	texture_set_stage(sampler_map[?"uNormalBuffer"], surface_get_texture(normalssurf))
	//texture_set_stage(sampler_map[?"uDepthBuffer"], surface_get_texture(depthsurf))

	render_set_uniform_vec2("uTexSize", render_width, render_height)
	render_set_uniform("uStrength", 1.0 - app.setting_overlays_outline_opacity)
	render_set_uniform("zFar", cam_far)
	render_set_uniform("zFar", cam_near)
}
