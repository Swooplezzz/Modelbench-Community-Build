/// tab_preview_render()

function tab_preview_camera()
{
	dy -= 8
	
	var taby;
	
	// Position
	taby = dy
	microani_set("tabposition", null, false, false, false)
	tab_camera_editor_position()
	microani_set("tabposition", null, false, false, false)
	microani_update(app_mouse_box(dx, taby, dw, dy - taby) && content_mouseon, false, false)
	
	// Rotation
	taby = dy
	microani_set("tabrotation", null, false, false, false)
	tab_camera_editor_rotation()
	microani_set("tabrotation", null, false, false, false)
	microani_update(app_mouse_box(dx, taby, dw, dy - taby) && content_mouseon, false, false)
}
