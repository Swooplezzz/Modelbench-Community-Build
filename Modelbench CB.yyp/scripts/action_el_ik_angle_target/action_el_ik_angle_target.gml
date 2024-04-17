/// action_el_ik_angle_target(value)
/// @value

function action_el_ik_angle_target(value)
{
	el_value_set_start(action_el_ik_angle_target, false)
	el_value_set(e_value.IK_ANGLE_TARGET, value, false)
	el_value_set_done()
}