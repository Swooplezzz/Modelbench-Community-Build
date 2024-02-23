/// action_el_mirror_texture(mirror)
/// @arg mirror

function action_el_mirror_y_texture(mirror)
{
	el_value_set_start(action_el_mirror_y_texture, false)
	el_value_set(e_value.TEX_MIRROR_X, mirror, false)
	el_value_set_done()
}
