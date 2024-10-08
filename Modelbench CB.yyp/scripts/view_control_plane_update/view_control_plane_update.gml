/// view_control_plane_update()
/// @desc Updates plane gizmo

function view_control_plane_update()
{
	// Update view ray
	var px, py, rayclip, rayeye, raywor;
	
	// Get -1 -> 1 XY mouse coordinates in viewport
	log(string(view_cam.zoom))
	px = -(((view_control_plane_mouse[X] - content_x + view_control_plane_offset[X]) / content_width ) * 2 - 1) / (render_proj_mode = 1 ? (view_cam.zoom) : 1)
	py = (((view_control_plane_mouse[Y] - content_y + view_control_plane_offset[Y]) / content_height ) * 2 - 1) / (render_proj_mode = 1 ? (view_cam.zoom) : 1)
	
	rayclip = vec4(px , py, -1, 1) ;
	rayeye = point4D_mul_matrix(rayclip, matrix_inverse(proj_matrix));
	rayeye = vec4(rayeye[X]  , rayeye[Y] , -1, 0)
		log(string(rayeye), "pepe")
	raywor = point4D_mul_matrix(rayeye, matrix_inverse(view_matrix));
	view_control_ray_dir = vec3_normalize(vec3(raywor[X], raywor[Y], raywor[Z]))
	
	// Update mouse
	view_control_plane_mouse[X] += mouse_dx * dragger_multiplier
	view_control_plane_mouse[Y] += mouse_dy * dragger_multiplier
}
