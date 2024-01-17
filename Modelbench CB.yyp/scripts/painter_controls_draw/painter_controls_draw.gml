//function painter_controls_draw()
function painter_controls_draw(barx, bary, barw, barh){
dx = barx
	dy = bary
	dw = barw
	dh = barh
	dy_start = dy
	dx_start = dx
	
	content_mouseon = app_mouse_box(dx, dy, dw, dh) && !popup_mouseon && !toast_mouseon && !context_menu_mouseon
	
	
	if (dh > dw)
		tip_force_right = true
	
	var busy, buttonsize;
	busy = window_busy
	buttonsize = 28 + 4
	
	window_busy = ""
	
	if (app_mouse_box(dx - 80, dy - 80, dw + 160, dh + 160) && !popup_mouseon && !toast_mouseon && !context_menu_mouseon)
		toolbar_nav_alpha_goal = 1
	else
		toolbar_nav_alpha_goal = .65
	
	window_busy = busy
	
	draw_set_alpha(toolbar_nav_alpha)
	
	// Background
	draw_box(dx, dy, dw, dh, false, c_level_middle, 1)
	draw_dropshadow(dx, dy, dw, dh, c_black, 1)
	draw_outline(dx, dy, dw, dh, 1, c_border, a_border)
	
		dy += 4
	dx += 4
		tip_set_keybind(e_keybind.VIEW_PTR_GRID)
		if(draw_button_icon("viewgrid", dx, dy, 28, 28, paint_view_grid = true, icons.ORTHOGRAPHIC, null, false, "tooltipviewptrgrid"))
		paint_view_grid = !paint_view_grid
	

	dx += buttonsize

	tip_set_keybind(e_keybind.VIEW_PTR_GUIDES)
	if(draw_button_icon("viewguides", dx, dy, 28, 28, paint_view_brush_guides = true, icons.CUSTOMIZATION, null, false, "tooltipviewguides"))
	paint_view_brush_guides = !paint_view_brush_guides
	
	dx += buttonsize


	draw_set_alpha(1)
	
	tip_force_left = false
}