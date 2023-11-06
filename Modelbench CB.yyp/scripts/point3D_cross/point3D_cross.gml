function point3D_cross(v1, v2)
{
	return [
		v1[@ Y] * v2[@ Z] - v1[@ Z] * v2[@ Y],
		v1[@ Z] * v2[@ X] - v1[@ X] * v2[@ Z],
		v1[@ X] * v2[@ Y] - v1[@ Y] * v2[@ X]
	]
}