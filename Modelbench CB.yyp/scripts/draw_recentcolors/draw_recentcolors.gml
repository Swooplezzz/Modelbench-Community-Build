/// draw_recentcolors()

function draw_recentcolors()
{
	var stack = (content_width > 230 + 176)
	if (!stack)
		dx = content_x + 12 + content_width /2 - 230/2
	else
		dx = content_x + 12
	
	var xx = dx + 24;
	var ddx = xx;
	var ww = 230 - 12;

	if (stack)
	{
		ww = content_width 
		xx = dx + content_width - 176 - 24;
		ddx = xx;
		dy -= 64;
	}
	
	for (var i = 0; i < array_length(recentcolor_list); i++)
	{
		if(xx >= (dx + ww - 42))
		{
			xx = ddx
			dy += 28
		}
		draw_button_colorpalette("col" + string(i), xx, dy, recentcolor_list[i], action_painter_recent_pick_color, null, action_painter_recent_remove_color, -1, i)
		xx += 28
	}
	
	if (xx >= (dx + ww))
	{
		xx = ddx	
		dy += 28
	}
	
	dy += 38
	if (stack)
		dy += 12
	
	dx = content_x + 12 
}
