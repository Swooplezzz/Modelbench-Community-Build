/// action_el_ik_target(value)
/// @arg value

function action_el_ik_target(value)
{
	el_value_set_start(action_el_ik_target, false)
	el_value_set(e_value.IK_TARGET, value, false)
	el_value_set_done()
}