/// color_get_distance(color1, color2)
/// @arg color1
/// @arg color2

function color_get_distance(col1, col2)
{
	var r1,r2,g1,g2,b1,b2;
	r1 = color_get_red(col1)
	g1 = color_get_green(col1)
	b1 = color_get_blue(col1)
	r2 = color_get_red(col2)
	g2 = color_get_green(col2)
	b2 = color_get_blue(col2)

	return sqr(power(r2-r1, 2)+power(b2-b1, 2)+power(g2-g1, 2))
}