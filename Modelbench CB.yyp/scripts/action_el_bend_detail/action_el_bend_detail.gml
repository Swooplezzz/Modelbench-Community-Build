/// action_el_bend_detail(value, add)
/// @arg bend
/// @arg add

function action_el_bend_detail(value, add)
{
	el_value_set_start(action_el_bend_detail, true)
	el_value_set(e_value.BEND_DETAIL, value, add)
	el_value_set_done()
}
