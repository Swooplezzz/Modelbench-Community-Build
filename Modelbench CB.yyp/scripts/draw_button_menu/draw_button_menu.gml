/// draw_button_menu(name, type, x, y, width, height, value, text, script|menuscript, [disabled, [texture, [icon, [caption, [texcolor, texalpha, [capwid]]]]]])
/// @arg name
/// @arg type
/// @arg x
/// @arg y
/// @arg width
/// @arg height
/// @arg value
/// @arg text
/// @arg script|drawscript
/// @arg [disabled
/// @arg [texture
/// @arg [icon
/// @arg [caption
/// @arg [texcolor
/// @arg texalpha
/// @arg [capwid]]]]]

function draw_button_menu()
{
	var name, type, xx, yy, wid, hei, value, text, script, tex, disabled, icon, caption, texcolor, texalpha, capwid;
	var flip, mouseon, cap, menuactive, menuhide, menuid, nameid;
	name = argument[0]
	type = argument[1]
	xx = argument[2] 
	yy = argument[3]
	wid = argument[4]
	hei = argument[5]
	value = argument[6]
	text = argument[7]
	script = argument[8]
	
	if (argument_count > 9)
		disabled = argument[9]
	else
		disabled = false
	
	if (argument_count > 10)
		tex = argument[10]
	else
		tex = null
	
	if (argument_count > 11)
		icon = argument[11]
	else
		icon = null
	
	if (argument_count > 12)
		caption = argument[12]
	else
		caption = ""
	
	if (argument_count > 13)
	{
		texcolor = argument[13]
		texalpha = argument[14]
		
		if (texcolor = null)
			texcolor = c_white
		
		if (texalpha = null)
			texalpha = 1
	}
	else
	{
		texcolor = c_white
		texalpha = 1
	}
	
	if (argument_count > 15)
		capwid = argument[15]
	else
		capwid = null
	
	// Caption
	cap = text_get(name)
	nameid = name
	
	// Check if menu is currently active
	menuactive = false
	menuhide = false
	menuid = null
	
	for (var i = 0; i < ds_list_size(menu_list); i++)
	{
		if (menu_list[|i].menu_name = nameid)
		{
			menuactive = true
			menuhide = menu_list[|i].menu_ani_type = "hide"
			menuid = menu_list[|i]
		}
	}
	
	flip = (yy + hei + hei * 8 > window_height)
	
	microani_set(nameid, null, false, false, false)
	
	var textcolor, textalpha, bordercolor, borderalpha, chevroncolor, chevronalpha, fadealpha, animation;
	textcolor = merge_color(c_text_secondary, c_text_main, microani_arr[e_microani.HOVER])
	textcolor = merge_color(textcolor, c_accent, microani_arr[e_microani.ACTIVE])
	textcolor = merge_color(textcolor, c_text_tertiary, microani_arr[e_microani.DISABLED])
	textalpha = lerp(a_text_secondary, a_text_main, microani_arr[e_microani.HOVER])
	textalpha = lerp(textalpha, a_accent, microani_arr[e_microani.ACTIVE])
	textalpha = lerp(textalpha, a_text_tertiary, microani_arr[e_microani.DISABLED])
	fadealpha = microani_arr[e_microani.FADE]
	animation = current_microani
	
	// Caption
	if (capwid = null)
	{
		draw_label(string_limit(cap, dw), xx, yy - (setting_compact_panels ? -12 : 3), fa_left, fa_top, textcolor, textalpha, font_label)
		yy += 8 + ((label_height) * (setting_compact_panels ? 0 : 1))
	}
	else if (capwid != null)
	{
		draw_label(cap, xx, yy + hei/2, fa_left, fa_middle, textcolor, textalpha, font_label)
		wid -= capwid
		xx += capwid
	}
	animation.fade.value = 1
	
	if (menuactive && !setting_compact_panels)
	{
		xx = lerp(xx, max(dx, menuid.menu_x), menuid.menu_ani_ease)
		wid = lerp(wid, min(dw, menuid.menu_w), menuid.menu_ani_ease)
	}
	
	// Button
	bordercolor = merge_color(c_border, c_text_secondary, microani_arr[e_microani.HOVER])
	bordercolor = merge_color(bordercolor, c_accent, microani_arr[e_microani.PRESS])
	bordercolor = merge_color(bordercolor, c_accent, microani_arr[e_microani.ACTIVE])
	borderalpha = lerp(a_border, a_text_secondary, microani_arr[e_microani.HOVER])
	borderalpha = lerp(borderalpha, a_accent, microani_arr[e_microani.PRESS])
	borderalpha = lerp(borderalpha, a_accent, microani_arr[e_microani.ACTIVE])
	
	xx = xx + (setting_compact_panels ? string_width(string_limit(cap, dw)) + 8 : 0)
	wid = wid - (setting_compact_panels ? string_width(string_limit(cap, dw)) + 8 : 0)
	
	draw_box(xx, yy, wid, hei, false, c_level_top, draw_get_alpha())
	draw_outline(xx, yy, wid, hei, 1, bordercolor, borderalpha * fadealpha, true)
	
	draw_box_hover(xx, yy, wid, hei, microani_arr[e_microani.PRESS])
	
	// Mouse
	mouseon = app_mouse_box(xx, yy, wid, hei) && !disabled && content_mouseon
	
	if (mouseon)
		mouse_cursor = cr_handpoint
	
	// Item
	var item = list_item_add(text, null, caption, tex, icon, -1, null, false, false);
	item.disabled = disabled
	
	item.thumbnail_blend = texcolor
	item.thumbnail_alpha = texalpha
	
	list_item_draw(item, xx, yy, wid, hei, false, null, null, false)
	instance_destroy(item)
	
	// Chevron
	chevroncolor = merge_color(c_text_tertiary, c_text_secondary, microani_arr[e_microani.HOVER])
	chevroncolor = merge_color(chevroncolor, c_accent, microani_arr[e_microani.ACTIVE])
	chevroncolor = merge_color(chevroncolor, c_text_tertiary, microani_arr[e_microani.DISABLED])
	chevronalpha = lerp(a_text_tertiary, a_text_secondary, microani_arr[e_microani.HOVER])
	chevronalpha = lerp(chevronalpha, a_accent, microani_arr[e_microani.ACTIVE])
	chevronalpha = lerp(chevronalpha, a_text_tertiary, microani_arr[e_microani.DISABLED])
	
	draw_image(spr_icons, icons.CHEVRON_DOWN_TINY, xx + wid - 12, yy + hei / 2, 1, 1, chevroncolor, chevronalpha * (1 - microani_arr[e_microani.CUSTOM_LINEAR]))
	draw_image(spr_icons, icons.CHEVRON_UP_TINY, xx + wid - 12, yy + hei / 2, 1, 1, chevroncolor, chevronalpha * microani_arr[e_microani.CUSTOM_LINEAR])
	
	// Disabled overlay
	draw_box(xx, yy, wid, hei, false, c_overlay, a_overlay * microani_arr[e_microani.DISABLED])
	
	microani_update(mouseon, mouseon && mouse_left, (menuactive && !menuhide), disabled, ((menuactive && !menuhide) ? !flip : flip))
	
	// Ctrl + Scroll
	if (mouseon && keyboard_check(vk_control) && mouse_wheel != 0)
	{
		var m = new_obj(obj_menu);
		m.menu_ani = 0
		m.menu_value = value
		m.menu_name = nameid
		menu_current = m
		menu_scroll = true

		var list;

		if (type = e_menu.LIST)
			list = list_init(name)

		menu_scroll = false

		// Find index of chosen value
		var index = 0;
		var item = null;

		for (var i = 0; i < ds_list_size(list.item); i++)
		{
			var it = list.item[|i];

			if (it.script != null)
				continue

			if (it.value = value)
			{
				index = i;
				break
			}
		}

		index += mouse_wheel
		index = mod_fix(index, ds_list_size(list.item))
		item = list.item[|index]

		while (item.script != null)
		{
			index = mod_fix(index + mouse_wheel, ds_list_size(list.item))
			item = list.item[|index]
		}

		list_item_script = script
		list_item_script_value = item.value

		list_destroy(list)
		instance_destroy(m)

		current_microani.holding.init(1)

		return true
	}
	
	// Update menu position
	if (menuactive)
	{
		menu_x = xx
		menu_y = yy
	}
	
	// Quick, re-open!
	if (mouseon && mouse_left_released && menuhide)
	{
		window_busy = "menu"
		menuid.menu_ani_type = "show"
		app_mouse_clear()
	}
	
	// Check click
	if (mouseon && mouse_left_released && !menuhide)
	{
		var m = null;
		for (var i = 0; i < ds_list_size(menu_list); i++)
		{
			if (menu_list[|i].menu_name = nameid)
			{
				m = menu_list[|i]
				break;
			}
		}
		
		if (m = null)
			m = new_obj(obj_menu)
		
		window_busy = "menu"
		window_focus = ""//string(menu_scroll_vertical)
		app_mouse_clear()
		
		m.menu_name = nameid
		m.menu_type = type
		m.menu_script = script
		m.menu_value = value
		m.menu_ani = 0
		m.menu_ani_type = "show"
		m.menu_flip = flip
		m.menu_x = xx
		m.menu_x_start = xx
		m.menu_y = yy
		m.menu_w = wid
		m.menu_w_start = wid
		m.menu_button_h = hei
		m.menu_item_w = wid
		m.menu_item_h = m.menu_button_h
		m.menu_margin = 0//8
		m.menu_steps = 0
		m.menu_floating = false
		
		m.content_x = content_x
		m.content_width = content_width
		
		menu_current = m
		
		if (type = e_menu.LIST)
		{
			m.menu_list = list_init(name)
			m.menu_list.show_ticks = false
		}
		
		m.menu_amount = m.menu_list = null ? 0 : ds_list_size(m.menu_list.item)
		
		with (m)
			menu_focus_selected()
		
		// Flip
		if (m.menu_flip)
			m.menu_show_amount = floor((m.menu_y * 0.9) / m.menu_item_h)
		else
			m.menu_show_amount = floor(((window_height - (m.menu_y + m.menu_button_h)) * 0.9) / m.menu_item_h)
		
		current_microani = animation
		
		menu_popup = popup
		return true
	}
	
	current_microani = animation
	return false
}
