/// action_el_show_backfaces_tree(element, newvalue, hobj)
/// @arg element
/// @arg newvalue
/// @arg hobj

function action_el_show_backfaces_tree(el, nval, hobj)
{
	with (hobj)
		history_save_var(el, el.value[e_value.SHOW_BACKFACES], nval)
	
	el.value[e_value.SHOW_BACKFACES] = nval;
	if (el.part_list != null)
	{
		for (var i = 0; i < ds_list_size(el.part_list); i++)
			if (!el.part_list[|i].selected)
				action_el_show_backfaces_tree(el.part_list[|i], nval, hobj)
	}
}
