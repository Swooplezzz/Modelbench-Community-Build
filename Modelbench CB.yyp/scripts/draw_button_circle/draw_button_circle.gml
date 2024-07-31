/// draw_button_label(name, x, y, [radius, [icon, [type, [script, [color, [anchor, [disabled]]]]]])
/// @arg name
/// @arg x
/// @arg y
/// @arg [radius
/// @arg [icon
/// @arg [type
/// @arg [script
/// @arg [color
/// @arg [anchor
/// @arg [disabled]]]]]]]

function draw_button_circle()
{
	var name, xx, yy, r, icon, type, script, anchor, disabled, tip, arg
	var font, cap, capwid, customw, mouseon, mouseclick;
	var w, h, color;

	name = argument[0]
	xx = argument[1]
	yy = argument[2]
	r = 32
	icon = null
	type = e_button.PRIMARY
	script = null
	anchor = e_anchor.LEFT
	arg = null
	disabled = false
	tip = ""
	color = c_accent
	
	if (argument_count > 3)
		r = argument[3]
	
	if (argument_count > 4)
		icon = argument[4]
	
	if (argument_count > 5)
		type = argument[5]
	
	if (argument_count > 6)
		script = argument[6]
		
	if (argument_count > 7)
		color = argument[7]
		
	if (argument_count > 8)
		anchor = argument[8]
	
	if (argument_count > 9)
		arg = argument[9]
		
    if (argument_count > 10)
		disabled = argument[10]
		
	 if (argument_count > 11)
		tip = argument[11]

	cap = name
	
	h = (type != e_button.TOOLBAR ? 32 : toolbar_size)
	
	font = (type != e_button.TOOLBAR ? font_button : font_value)
		w = r * 2
	h = r * 2
	/*
	if (type = e_button.BIG)
	{
		h = 64
		font = font_heading_big
	}
	*/
	
	// Calculate width/position
	draw_set_font(font)
	capwid = string_width(cap)
	
	if (w = null)
	{
		w = capwid + (icon = null ? 24 : 52)
		customw = false
	}
	else
		customw = true
	
	//if (anchor = e_anchor.CENTER)
	//	xx = xx - floor(w/2)
	//else if (anchor = e_anchor.RIGHT)
	//	xx -= w
	
	if (yy > content_y + content_height || yy + h < content_y || xx > content_x + content_width || xx + w < content_x)
		return 0
	
		if (tip != "")
		tip_set(text_get(tip), xx, yy, w, h)
	mouseon = app_mouse_box(xx - r-2, yy - r-2, w + 4, h + 4) && content_mouseon && !disabled
	mouseclick = mouseon && mouse_left
	microani_set(name, script, mouseon, mouseclick, false)
	
	if (mouseon)
		mouse_cursor = cr_handpoint
	
	var focus, backcolor, backalpha, linecolor, linealpha, contentcolor, contentalpha, contentx;
	focus = max(microani_arr[e_microani.ACTIVE], microani_arr[e_microani.PRESS])
	
	if (type = e_button.PRIMARY || type = e_button.BIG)
	{
		backcolor = merge_color(color, merge_color(color, c_white, .25), microani_arr[e_microani.HOVER])
		backcolor = merge_color(backcolor, merge_color(color, c_white, 1), focus)
		backcolor = merge_color(backcolor, c_text_tertiary, microani_arr[e_microani.DISABLED])
		backalpha = lerp(1, a_text_tertiary, microani_arr[e_microani.DISABLED])
		
		linecolor = merge_color(merge_color(color, c_overlay, .75), merge_color(color, c_overlay, 1), focus)
		linealpha = lerp(0, 1,  microani_arr[e_microani.HOVER])
		
		contentcolor = c_button_text
		contentalpha = 1
	}
	else
	{
		backcolor = merge_color(color, merge_color(color, c_black, .1), focus)
		backalpha = lerp(.5, .75, microani_arr[e_microani.HOVER])
		backalpha = lerp(backalpha, .25, focus)
		backalpha = lerp(backalpha, 0, microani_arr[e_microani.DISABLED])
		
		contentcolor = merge_color(c_text_secondary, c_text_main, microani_arr[e_microani.HOVER])
		contentcolor = merge_color(contentcolor, c_accent, focus)
		contentcolor = merge_color(contentcolor, c_text_tertiary, microani_arr[e_microani.DISABLED])
		contentalpha = lerp(0, a_text_main, microani_arr[e_microani.HOVER])
		contentalpha = lerp(contentalpha, 1, focus)
		contentalpha = lerp(contentalpha, a_text_tertiary, microani_arr[e_microani.DISABLED])
		
		linecolor = merge_color(color, merge_color(color, c_white, .75), focus)
		linealpha = lerp(.75, 1, focus)
	}
	if (type = e_button.PRIMARY)
	{
	// Background
	//draw_circle_ext(xx, yy, r + 3, true, 32, linecolor, linealpha)
	//draw_circle_ext(xx, yy, r, false, 32, backcolor, backalpha)
		draw_image(spr_control_dial, 0, xx, yy, (r+3)/24, (r+3)/24, linecolor, linealpha)
		draw_image(spr_circle_32, 0, xx, yy, r/16, r/16, backcolor, backalpha)
	}
	// Bevel
	//if (type = e_button.PRIMARY || type = e_button.BIG)
	//	draw_box_bevel(xx, yy, w, h, 1)
	
	// Background
	if (type = e_button.SECONDARY)
	{
		//draw_image(spr_dropshadow_14, 0, origin2d[X], origin2d[Y], 2, 2, c_white, 1)
		draw_image(spr_circle_32, 0, xx, yy, r/16, r/16, linecolor, linealpha)
		draw_image(spr_circle_32, 0, xx, yy, r/16, r/16, c_level_top, backalpha)

	}
	
	// Focus ring
	//draw_box_hover(xx, yy, w, h, microani_arr[e_microani.PRESS])
	
	if (customw)
		contentx = floor((xx + w/2) - ((capwid + (icon = null ? 0 : 32)) / 2))
	else
		contentx = floor(xx + (icon = null ? 12 : 8))
	
	// Draw icon
	if (icon != null)
	{
		draw_image(spr_icons, icon, contentx + 12, yy + h/2, 1, 1, contentcolor, contentalpha)
		contentx += 32
	}
	
	// Draw label
	draw_label(cap, contentx - r, yy, fa_left, fa_middle, contentcolor, contentalpha)
	
	microani_update(mouseon, mouseclick, false, disabled)

	if (mouseon && mouse_left_released)
	{
		if (script != null)
		{
			if (arg != null)
				script_execute(script, arg)
			else
				script_execute(script)
		}
		return true
	}
}
