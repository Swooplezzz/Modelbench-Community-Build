/// point3D_lerp(start, target, time)
/// @arg start
/// @arg target
/// @arg time

function point3D_lerp(start, target, time)
{
	return [start[@ X] + (target[@ X] - start[@ X]) * time, start[@ Y] + (target[@ Y] - start[@ Y]) * time, start[@ Z] + (target[@ Z] - start[@ Z]) * time]
	//return (1 - point3D_mul(point3D_add(start, point3D_mul(target, time)), time))
}