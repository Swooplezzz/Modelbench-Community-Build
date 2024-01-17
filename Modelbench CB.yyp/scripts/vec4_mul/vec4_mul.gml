/// vec3_mul(vector, multiplier)
/// @arg vector
/// @arg multiplier

function vec4_mul(vec, mul)
{
	if (is_array(mul))
		return [vec[@ X] * mul[@ X], vec[@ Y] * mul[@ Y], vec[@ Z] * mul[@ Z], vec[@ W] * mul[@ W]]
	else
		return [vec[@ X] * mul, vec[@ Y] * mul, vec[@ Z] * mul, vec[@ W] * mul]
}