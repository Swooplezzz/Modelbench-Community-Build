/// angle_axis(angle, axis)
/// @arg angle
/// @arg axis

function angle_axis(aAngle, aAxis)
{
	aAxis = vec3_normalize(aAxis)
	var rad = aAngle * ((pi * 2) / 360) * 0.5
	aAxis = vec3_mul(aAxis, sin(rad))
	return vec4(aAxis[@ X], aAxis[@ Y], aAxis[@ Z], cos(rad))
}