/// action_el_show_backfaces(val)
/// @arg value
/// @arg add

function action_el_show_backfaces(val)
{
	if (history_undo)
	{
		with (history_data)
		{
			for (var t = 0; t < save_var_amount; t++)
			{
				with (save_id_find(save_var_save_id[t]))
				{
					value[e_value.SHOW_BACKFACES] = other.save_var_old_value[t]
				}
			}
		}
	}
	else if (history_redo)
	{
		with (history_data)
		{
			for (var t = 0; t < save_var_amount; t++)
			{
				with (save_id_find(save_var_save_id[t]))
				{
					value[e_value.SHOW_BACKFACES] = other.save_var_new_value[t]
				}
			}
		}
	}
	else
	{
		var hobj = history_save_var_start(action_el_show_backfaces, true);
		show_debug_message(val)
		with (obj_model_element)
			if (element_type = TYPE_PART && selected)
				action_el_show_backfaces_tree(id, val, hobj)
	}
}
