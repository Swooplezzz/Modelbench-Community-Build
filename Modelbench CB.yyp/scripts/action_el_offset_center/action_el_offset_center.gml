/// action_el_offset_center()

function action_el_offset_center()
{
var _axis_edit;

		var axis_e = (setting_z_is_up ? Z : Y)
	if(argument_count > 0){
	_axis_edit = argument[0]
	}
	
	if(_axis_edit != null)
	axis_edit = _axis_edit
	else
		axis_edit = context_menu_copy_axis_edit

	if (el_edit.type = "plane"){
		if(el_edit.value[e_value.EXTRUDE] == true){
   		   if(axis_edit == axis_e){
			   	el_value_set_start(action_el_offset, true)
	            el_value_set(e_value.OFFSET_X + axis_e, -1 / 2, false)
					el_value_set_done()
		   }
		   else{
			      	el_value_set_start(action_el_offset, true)
		   		el_value_set(e_value.OFFSET_X + axis_edit, -el_edit.value[e_value.WIDTH + axis_edit] / 2, false)
					el_value_set_done()
		   }
		}
		else{
			if(axis_edit == axis_e){
				   	el_value_set_start(action_el_offset, true)
	            el_value_set(e_value.OFFSET_X + axis_e, 0, false)
					el_value_set_done()
		    }
		    else{
				   	el_value_set_start(action_el_offset, true)
				el_value_set(e_value.OFFSET_X + axis_edit, -el_edit.value[e_value.WIDTH + axis_edit] / 2, false)
					el_value_set_done()
		    }
		}
	}
	else if (el_edit.type = "block"){
		   	el_value_set_start(action_el_offset, true)
			el_value_set(e_value.OFFSET_X + axis_edit, -el_edit.value[e_value.WIDTH + axis_edit] / 2, false)
				el_value_set_done()
	}
	

}
