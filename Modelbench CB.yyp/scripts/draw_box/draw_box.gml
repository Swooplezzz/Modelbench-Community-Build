/// draw_box(x, y, width, height, outline, [color, alpha])
/// @arg x
/// @arg y
/// @arg width
/// @arg height
/// @arg outline
/// @arg [color
/// @arg alpha]

function draw_box()
{
	var xx, yy, ww, hh, outline, color, alpha;
	xx = argument[0]
	yy = argument[1]
	ww = argument[2]
	hh = argument[3]
	outline = argument[4]
	color = draw_get_color()
	alpha = draw_get_alpha()
	
	if (argument_count > 5)
	{
		color = argument[5]
		alpha *= argument[6]
	}
	
	if (alpha = 0)
		return 0
	
	draw_primitive_begin(outline ? pr_linestrip : pr_trianglefan)
	
	draw_vertex_color(xx, yy, color, alpha)
	draw_vertex_color(xx + ww, yy, color, alpha)
	draw_vertex_color(xx + ww, yy + hh, color, alpha)
	draw_vertex_color(xx, yy + hh, color, alpha)
	draw_vertex_color(xx, yy, color, alpha)

	draw_primitive_end()
}

/// draw_shape(x, y, x2, y2, outline, [color, alpha])
/// @arg x
/// @arg y
/// @arg width
/// @arg height
/// @arg outline
/// @arg [color
/// @arg alpha]
function draw_shape()
{
	var xx, yy, xx2, yy2, outline, color, alpha;
	xx = argument[0]
	yy = argument[1]
	xx2 = argument[2]
	yy2 = argument[3]
	outline = argument[4]
	color = draw_get_color()
	alpha = draw_get_alpha()
	
	if (argument_count > 5)
	{
		color = argument[5]
		alpha *= argument[6]
	}
	
	if (alpha = 0)
		return 0
	
	draw_primitive_begin(outline ? pr_linestrip : pr_trianglefan)
	
	draw_vertex_color(xx, yy, color, alpha)
	draw_vertex_color(xx2, yy, color, alpha)
	draw_vertex_color(xx2, yy2, color, alpha)
	draw_vertex_color(xx, yy2, color, alpha)
	draw_vertex_color(xx, yy, color, alpha)

	draw_primitive_end()
}