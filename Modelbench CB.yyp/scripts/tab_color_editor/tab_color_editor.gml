/// tab_color_editor()

function tab_color_editor()
{
	// Mix color
	draw_painter_color_editor("paintercoloreditor", action_color_set, (painter_main_color ? paint_secondary_color : paint_primary_color))

    var stack = (content_width > 230 + 176)
	if (!stack)
		dx = content_x + 12 + content_width /2 - 230/2;
	else
		dx = content_x + 12
	
	dx += 12;
	draw_button_icon("switchmaincolor", dx, dy, 24, 24, 0, icons.SWITCH, action_switch_main_color)
	dx += 32;
	
	if (painter_main_color = 0)
	{
		draw_color_selector_button("secselector", dx+12,dy+12, 1, action_painter_select_color);
		draw_color_selector_button("primaryselector", dx,dy, 0, action_painter_select_color);
	}
	else
	{
		draw_color_selector_button("primaryselector", dx,dy, 0, action_painter_select_color);
		draw_color_selector_button("secselector", dx+12,dy+12, 1, action_painter_select_color);
	}
	
	dx = content_x + 12;
	dy += 52;
	
	draw_recentcolors()
}