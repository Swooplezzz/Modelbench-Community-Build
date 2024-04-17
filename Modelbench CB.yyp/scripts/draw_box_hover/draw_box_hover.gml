/// draw_box_hover(x, y, width, height, alpha, [color])
/// @arg x
/// @arg y
/// @arg width
/// @arg height
/// @arg alpha
/// @arg [color]
/// @desc Drawing separate full boxes for each side because drawing primitive outlines isn't consistent on all computers

function draw_box_hover(xx, yy, width, height, inalpha, color = c_hover)
{
	var size, alpha;
	size = 2
	alpha = a_hover * inalpha
	
	if (alpha = 0)
		return 0
	
	// Top
	draw_box(xx - size, yy - size, width + (size * 2), size, false, color, alpha)
	
	// Bottom
	draw_box(xx - size, yy + height, width + (size * 2), size, false, color, alpha)
	
	// Left
	draw_box(xx - size, yy, size, height, false, color, alpha)
	
	// Right
	draw_box(xx + width, yy, size, height, false, color, alpha)
}