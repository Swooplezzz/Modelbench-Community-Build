//function action_el_mirror()
function action_el_mirror_x(){
	if (history_undo)
	{
		with (obj_model_element)
			if (selected)
				el_mirror("X")
		
		with (history_data)
			history_restore_el_select()
	}
	else
	{
		if (el_edit = null)
			return 0
		
		with (obj_model_element)
		{
			root_copy = null
			copy = null
		}
		
		if (!history_redo) 
			with (history_set(action_el_mirror_x))
				history_save_el_select()
		
		with (obj_model_element)
		{
			if (selected)
			el_mirror("X")

		}
		

	}
	
	el_update_lock_tree(false)
	el_update_hidden_tree(false)
	app_update_el_edit()
	app_update_name_warning()
	el_update_part()
	action_update_search()

	//if(el_edit = null){
	//	return 0
	//}
	//with(obj_model_element){
	//	if(selected){
	//	}
	//}
	
	//el_update_lock_tree(false)
	//el_update_hidden_tree(false)
	//app_update_el_edit()
	
	//el_update_part()
}