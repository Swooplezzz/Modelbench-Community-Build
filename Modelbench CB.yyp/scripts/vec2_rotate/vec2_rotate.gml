/// vec2_rotate(vector, angle, center)
/// @arg vector
/// @arg angle
/// @arg center

function vec2_rotate(vector, angle, center)
{
	var theta = degtorad(angle)

	var cs, sn;
	cs = cos(theta);
	sn = sin(theta);

	var dx, dy;
	dx = center[X];
	dy = center[Y];

	var translated_x = vector[X] - dx;
	var translated_y = vector[Y] - dy;
	
	var result_x = translated_x * cs - translated_y * sn;
	var result_y = translated_x * sn + translated_y * cs;
	
	result_x += dx;
	result_y += dy;

	return [result_x, result_y]
}