/// painter_toolbar_draw(x, y, width, height)
/// @arg x
/// @arg y
/// @arg width
/// @arg height

function painter_toolbar_draw(barx, bary, barw, barh)
{
	dx = barx
	dy = bary
	dw = barw
	dh = barh
	dy_start = dy
	dx_start = dx
	
	if (program_mode != e_mode.TEXTURING)
		return 0
	
	content_mouseon = app_mouse_box(dx, dy, dw, dh) && !popup_mouseon && !toast_mouseon && !context_menu_mouseon
	
	if (dh > dw)
		tip_force_right = true

	var busy, buttonsize;
	busy = window_busy
	buttonsize = 28 + 4
	
	window_busy = ""
	
	if (app_mouse_box(dx - 80, dy - 80, dw + 160, dh + 160) && !popup_mouseon && !toast_mouseon && !context_menu_mouseon)
		toolbar_painter_alpha_goal = 1
	else
		toolbar_painter_alpha_goal = .65
	
	window_busy = busy
	
	draw_set_alpha(toolbar_painter_alpha)
	
	// Background
	draw_box(dx, dy, dw, dh, false, c_level_middle, 1)
	draw_dropshadow(dx, dy, dw, dh, c_black, 1)
	draw_outline(dx, dy, dw, dh, 1, c_border, a_border)
	
	dy += 4
	dx += 4
	
	// Brush tool
	tip_set_keybind(e_keybind.BRUSH)
	if (draw_button_icon("toolbrush", dx, dy, 28, 28, paint_tool_selected = e_paint.BRUSH, icons.BRUSH, null, false, "toolsetpainterbrush"))
		paint_tool_selected = e_paint.BRUSH
	
	if (dw > dh)
		dx += buttonsize
	else
		dy += buttonsize
	
	// Erase tool
	tip_set_keybind(e_keybind.ERASE)
	if(draw_button_icon("tooleraser", dx, dy, 28, 28, paint_tool_selected = e_paint.ERASE, icons.ERASER, null, false, "toolsetpaintererase"))
		paint_tool_selected = e_paint.ERASE
	
	if (dw > dh)
		dx += buttonsize
	else
		dy += buttonsize
	
	// Color picker tool
	tip_set_keybind(e_keybind.PICK)
	if(draw_button_icon("toolpicker", dx, dy, 28, 28, paint_tool_selected = e_paint.PICK, icons.PICKER, null, false, "toolsetpainterpick"))
		paint_tool_selected = e_paint.PICK
			
	if (dw > dh)
		dx += buttonsize
	else
		dy += buttonsize
	
	// Fill tool
	tip_set_keybind(e_keybind.FILL)
	if(draw_button_icon("toolfill", dx, dy, 28, 28, paint_tool_selected = e_paint.FILL, icons.FILL_TOOL, null, false, "toolsetpainterfill"))
		paint_tool_selected = e_paint.FILL
		
	if (dw > dh)
		dx += buttonsize
	else
		dy += buttonsize
	
	// Fill tool
	tip_set_keybind(e_keybind.SHAPE)
	if(draw_button_icon("toolshape", dx, dy, 28, 28, paint_tool_selected = e_paint.SHAPE, icons.SHAPES, null, false, "toolsetpaintershape"))
		paint_tool_selected = e_paint.SHAPE
		
	
	if (dw > dh)
		dx += buttonsize
	else
		dy += buttonsize
		
	if (dw > dh)
		draw_box(dx, dy, 1, 28, false, c_border, a_border)
	else
		draw_box(dx, dy, 28, 1, false, c_border, a_border)
	
	if (dw > dh)
		dx += 4
	else
		dy += 4
	
	// Box select tool
	tip_set_keybind(e_keybind.BOX_SELECT)
	if(draw_button_icon("toolselect", dx, dy, 28, 28, paint_tool_selected = e_paint.BOX_SELECT, icons.BOX_SELECT, null, false, "toolsetpainterboxselect"))
		paint_tool_selected = e_paint.BOX_SELECT
	
	if (dw > dh)
		dx += buttonsize
	else
		dy += buttonsize
	
	// Select transform tool
	tip_set_keybind(e_keybind.TRANSFORM_SELECTION)
	if(draw_button_icon("tooltransform", dx, dy, 28, 28, paint_tool_selected = e_paint.TRANSFORM_SELECTION, icons.TRANSFORM, null, false, "toolsetpaintertransformselection"))
		paint_tool_selected = e_paint.TRANSFORM_SELECTION
	
	if (dw > dh)
		dx += buttonsize
	else
		dy += buttonsize
	
	draw_set_alpha(1)
	tip_force_left = false
}
