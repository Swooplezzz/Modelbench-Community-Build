/// action_el_texture_scroll_speed(value, add)
/// @arg value
/// @arg add

function action_el_texture_scroll_speed(value, add)
{
	el_value_set_start(action_el_opacity, true)
	el_value_set(e_value.TEXTURE_SCROLL_SPEED, value, add)
	el_value_set_done()
}
