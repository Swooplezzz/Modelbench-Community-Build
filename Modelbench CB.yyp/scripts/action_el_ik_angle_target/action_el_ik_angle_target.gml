// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function action_el_ik_angle_target(value){
	el_value_set_start(action_el_ik_angle_target, false)
	el_value_set(e_value.IK_ANGLE_TARGET, value, false)
	el_value_set_done()
}