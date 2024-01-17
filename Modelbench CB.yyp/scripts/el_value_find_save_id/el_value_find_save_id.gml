/// el_value_find_save_id(valueid, oldvalue, newvalue)
/// @arg valueid
/// @arg oldvalue
/// @arg newvalue

function el_value_find_save_id(vid, oldval, newval)
{
	if ((vid = e_value.TEXTURE_OBJ||vid = e_value.IK_ANGLE_TARGET || vid = e_value.IK_TARGET) && newval = "none")
		newval = 0
	else if (vid = e_value.TEXTURE_OBJ||vid = e_value.IK_ANGLE_TARGET || vid = e_value.IK_TARGET) 
	{
		//log(string(newval))
		newval = save_id_find(newval)
		//log(string(newval))
	}
	
	return newval
}
