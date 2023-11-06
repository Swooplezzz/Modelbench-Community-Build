// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function point3D_lerp(start, target, time){
	return [start[@ X] + (target[@ X] - start[@ X]) * time, start[@ Y] + (target[@ Y] - start[@ Y]) * time, start[@ Z] + (target[@ Z] - start[@ Z]) * time]
	//return (1 - point3D_mul(point3D_add(start, point3D_mul(target, time)), time))
}