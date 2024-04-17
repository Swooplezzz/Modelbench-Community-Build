/// view_toolbar_projection_draw(x, y, width, height)
/// @arg x
/// @arg y
/// @arg width
/// @arg height

function view_toolbar_projection_draw(barx, bary, barw, barh)
{
	dx = barx
	dy = bary
	dw = barw
	dh = barh
	dy_start = dy
	dx_start = dx
	
	content_mouseon = app_mouse_box(dx, dy, dw, dh) && !popup_mouseon && !toast_mouseon && !context_menu_mouseon
	
	if (dh > dw)
		tip_force_left = true
	
	var busy, buttonsize;
	busy = window_busy
	buttonsize = 28 + 4
	
	window_busy = ""
	
	if (app_mouse_box(dx - 80, dy - 80, dw + 160, dh + 160) && !popup_mouseon && !toast_mouseon && !context_menu_mouseon)
		toolbar_projection_alpha_goal = 1
	else
		toolbar_projection_alpha_goal = .65
	
	window_busy = busy
	
	if (window_busy = "viewzoom" || window_busy = "viewmovecameratoggle" || window_busy = "viewpan")
		toolbar_projection_alpha_goal = 1
	
	draw_set_alpha(toolbar_projection_alpha)
	
	// Background
	draw_box(dx, dy, dw, dh, false, c_level_middle, 1)
	draw_dropshadow(dx, dy, dw, dh, c_black, 1)
	draw_outline(dx, dy, dw, dh, 1, c_border, a_border)
	
	dy += 4
	dx += 4
	
	// Projection toggle
	tip_set_keybind(e_keybind.TOGGLE_PROJ)
	if (draw_button_icon("toolprojtoggle", dx, dy, 28, 28, 0,render_proj_mode == 0 ? icons.PRESPECTIVE : icons.ORTHOGRAPHIC, toggle_projection, false, render_proj_mode == 0 ? "tooltipprojtoggleortho" : "tooltipprojtogglepres")){
	}
	
	if (dw > dh)
		dx += buttonsize
	else
		dy += buttonsize
	
	draw_set_alpha(1)
	
	tip_force_left = false
}
