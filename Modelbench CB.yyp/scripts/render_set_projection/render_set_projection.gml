/// render_set_projection(from, to, up, fov, aspect, znear, zfar)
/// @arg from
/// @arg to
/// @arg up
/// @arg fov
/// @arg aspect
/// @arg znear
/// @arg zfar

function render_set_projection(from, to, up, fov, aspect, znear, zfar)
{
	var mV, mP;
	
	mV = matrix_create_lookat(from, to, up);
	mP = matrix_build_projection_perspective_fov(-fov, -aspect, znear, zfar);
	
	if (render_proj_mode == 1)
	{
		if (render_width == render_height)
		{
			mP = matrix_build_projection_ortho(display_get_height() * (view_cam.zoom * 0.0005), -display_get_height() * (view_cam.zoom*0.0005)  , znear, zfar);
		}
		else if (render_width == recent_thumbnail_width && render_height == recent_thumbnail_height)
		{
			mP = matrix_build_projection_ortho(recent_thumbnail_width * .0115 * abs((( model_get_max_y() + model_get_min_y() ) / 2) - model_get_min_y()), -recent_thumbnail_height * .0115 * abs((( model_get_max_y() + model_get_min_y() ) / 2) - model_get_min_y()), znear, zfar);
			show_debug_message("Rendering Recent")
		}
	    else
		{
			mP = matrix_build_projection_ortho(render_width * (view_cam.zoom * 0.0005), -render_height * (view_cam.zoom*0.0005) , znear, zfar);
	    }
	}
	
	camera_set_view_mat(cam_render, mV)
	camera_set_proj_mat(cam_render, mP)
	camera_apply(cam_render)
}
