/// action_model_color(val)
/// @arg value

function action_model_color(val)
{
	if (history_undo)
	{
		with (history_data) 
			other.model_color = save_var_old_value[0]
	}
	else if (history_redo)
	{
		with (history_data) 
			other.model_color = save_var_new_value[0]
	}
	else
	{
		var hobj = history_save_var_start(action_model_color, true);
		
		with (hobj)
			history_save_var(other.id, other.model_color, val)
		
		model_color = val
	}
	
	with (app)
		el_update_part()
}