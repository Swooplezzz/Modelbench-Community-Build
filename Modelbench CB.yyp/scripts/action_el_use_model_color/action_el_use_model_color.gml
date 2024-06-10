/// action_el_use_model_color(value)
/// @arg value

function action_el_use_model_color(val)
{
	el_value_set_start(action_el_use_model_color, false)
	el_value_set(e_value.USE_MODEL_COLOR, val, false)
	el_value_set_done()
}
