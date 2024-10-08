/// painter_update(view, cam)
/// @arg view
/// @arg cam

function painter_update(view, cam)
{
	painter_update_surface(view, cam)
	var boxx, boxy, boxw, boxh;	
	painter_surf_require()
	
	// Calculate box
	#region Variables
		boxx = view_area_x
		boxy = view_area_y
		boxw = view_area_width
		boxh = view_area_height
	
		boxx = floor(boxx)
		boxy = floor(boxy)
		boxw = floor(boxw)
		boxh = floor(boxh)
	#endregion
	
	painter_view()
	scale_offset_x = floor(boxx + (boxw / 2 - (paint_texture_width / 2 + offx) * zoom))
	scale_offset_y = floor(boxy + (boxh / 2 - (paint_texture_height / 2 + offy) * zoom))
	
	// Cut, copy, paste, delete shortcuts
	painter_cpy_pst()
	
	// Undo, redo
	painter_history()

	#region MouseVariables
		// Snap even brush sizes to grid edges
		if (paint_tool_selected = e_paint.BRUSH || paint_tool_selected = e_paint.ERASE)
		{
			if (!keyboard_check(vk_alt))
			{
				mousexsnap = snap((window_mouse_get_x() - scale_offset_x) / zoom - (paint_width % 2 ? 0.5 : 1), 1) - (paint_width % 2 ? 0.5 : 0)
				prevmousexsnap = snap(mouse_x_prev / zoom - (paint_width % 2 ? 0.5 : 1), 1) - (paint_width % 2 ? 0.5 : 0)
			}
			if (!keyboard_check(vk_shift))
			{
				mouseysnap = snap((window_mouse_get_y() - scale_offset_y) / zoom - (paint_width % 2 ? 0.5 : 1), 1) - (paint_width % 2 ? 0.5 : 0)
				prevmouseysnap = snap(mouse_y_prev / zoom - (paint_width % 2 ? 0.5 : 1), 1) - (paint_width % 2 ? 0.5 : 0)
			}
		}
		else
		{
			if (!keyboard_check(vk_alt))
			{
				mousexsnap = snap((window_mouse_get_x() - scale_offset_x) / zoom - 0.5, 1) - 0.5
				prevmousexsnap = snap(mouse_x_prev / zoom - 0.5, 1) - 0.5
			}
			if (!keyboard_check(vk_shift))
			{
				mouseysnap = snap((window_mouse_get_y() - scale_offset_y) / zoom - 0.5, 1) - 0.5
				prevmouseysnap = snap(mouse_y_prev / zoom - 0.5, 1) - 0.5
			}
		}
		var inbounds = ((mousexsnap + 1) < paint_texture_width && (mouseysnap + 1) < paint_texture_height && (mousexsnap + 1) > 0 && (mouseysnap + 1) > 0) && content_mouseon
	#endregion

	render_set_culling(false)

	if (content_mouseon)
	{
		if (keybinds[e_keybind.BRUSH_WIDTH].active)
			paint_width = clamp(paint_width - mouse_wheel, 1, 256)
			
		if (mouse_left || mouse_right)
		{
			// Brush tool
			painter_tool_brush(mousexsnap, mouseysnap, prevmousexsnap, prevmouseysnap, mouse_button)
		
			// Erase tool
			painter_tool_erase(mousexsnap, mouseysnap, prevmousexsnap, prevmouseysnap)
		}
		
		if (mouse_left_pressed || mouse_right_pressed)
		{
			// Fill tool
			if (inbounds)
				painter_tool_floodfill(mousexsnap, mouseysnap, mouse_button)		
		}
		
		// Shape tool
		painter_tool_shape(mouse_button)
		
		// Select tool
		painter_tool_select(mousexsnap, mouseysnap)
		
		// Color picker tool
		if (inbounds)
			painter_tool_color_picker(mousexsnap, mouseysnap, mouse_button)
	}
	
	// Apply Draw
	painter_draw_apply()

	painter_update_floodfill()

	// Draw Painter BG
	draw_gradient(content_x, content_y + content_height / 3, content_width, content_height / 1.5, c_accent, 0, 0, 0.1, 0.1)

	#region BgCheckers
		clip_begin(scale_offset_x, scale_offset_y, zoom * paint_texture_width, zoom * paint_texture_height)
		draw_box(boxx, boxy, boxw, boxh, false, c_level_middle, 1)
		for (var i = 0; i < ceil(boxw/192); i++)
			for (var j = 0; j < ceil(boxh/192); j++)
				draw_image(spr_uv_editor_pattern, 0, boxx + (i * 192), boxy + (j * 192), 1, 1, c_text_main, .05)
		clip_end()
	#endregion
	if (selection_moved && (paint_tool_selected != e_paint.TRANSFORM_SELECTION ||  (adjusting_brightness_contrast || adjusting_hue)))
		painter_update_spr = true
	
	painter_done(content_mouseon)
	painter_draw(mousexsnap, mouseysnap, content_mouseon)

	mouse_x_prev = window_mouse_get_x() - scale_offset_x
	mouse_y_prev = window_mouse_get_y() - scale_offset_y
	
	if (selection_moved && (paint_tool_selected != e_paint.TRANSFORM_SELECTION ||  (adjusting_brightness_contrast || adjusting_hue)))
	{

		painter_update_selection_bounds()
		selection_size = vec2(selection_btmright[0] - selection_topleft[0], selection_btmright[1] - selection_topleft[1])
		painter_update_transform_sprite()
	}
	if (selection_moved && (paint_tool_selected != e_paint.TRANSFORM_SELECTION ||  (adjusting_brightness_contrast || adjusting_hue)))
	{

		selection_moved = false
		selection_rot = 0
		selection_pos = [selection_topleft[X] + selection_size[X] / 2, selection_topleft[Y] + selection_size[Y] / 2]
	}

	render_set_culling(true)
}