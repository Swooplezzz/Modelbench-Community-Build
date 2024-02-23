//el_mirror()

function el_mirror(mirrorAxis){
if(string_contains(mirrorAxis, "Z")){
	value[e_value.POS_X] = -value[e_value.POS_X]
	value[e_value.OFFSET_X] = -value[e_value.OFFSET_X] - (element_type = TYPE_SHAPE ? value[e_value.WIDTH] : 0)
	value[e_value.ROT_Z] = -value[e_value.ROT_Z]
	value[e_value.ROT_Y] = -value[e_value.ROT_Y]
				
	if (element_type = TYPE_SHAPE)
	{
		if(string_contains(mirrorAxis, "Texture"))
		value[e_value.TEX_MIRROR] = !value[e_value.TEX_MIRROR]
	}
	
	if(element_type = TYPE_PART){
		value[e_value.BEND_INVERT_Z] = !value[e_value.BEND_INVERT_Z]
		value[e_value.BEND_INVERT_Y] = !value[e_value.BEND_INVERT_Y]
		
		switch (value[e_value.BEND_PART])
		{
			case e_part.RIGHT: value[e_value.BEND_PART] = e_part.LEFT; value[e_value.BEND_OFFSET] = -value[e_value.BEND_OFFSET] break;
			
			case e_part.LEFT: value[e_value.BEND_PART] = e_part.RIGHT; value[e_value.BEND_OFFSET] = -value[e_value.BEND_OFFSET] break;
		}
		
				if (shape_list != null && ds_list_size(shape_list) > 0)
		{
			for (var i = 0; i < ds_list_size(shape_list); i++)
			{
				with (shape_list[|i])
					el_mirror(mirrorAxis)
			}
		}
	
		if (part_list != null && ds_list_size(part_list) > 0)
		{
			for (var i = 0; i < ds_list_size(part_list); i++)
			{
				with (part_list[|i])
					el_mirror(mirrorAxis)
			}
		}
	}
}
if(string_contains(mirrorAxis, "X")){
	//if (element_type = TYPE_SHAPE)
	//{
	//	if(string_contains(mirrorAxis, "Texture"))
	//	value[e_value.TEX_MIRROR] = !value[e_value.TEX_MIRROR]
	//}
	var l = value[e_value.LENGTH]
	if (type = "block"){
		
		if(value[e_value.LENGTH] == 0){
			if(string_contains(mirrorAxis, "Texture"))
			value[e_value.INVERT] = !value[e_value.INVERT] 
		}
		else{
				if(string_contains(mirrorAxis, "Texture"))
		value[e_value.TEX_MIRROR_X] = !value[e_value.TEX_MIRROR_X]
		}
		
	}
		if (type = "plane"){
	if(value[e_value.EXTRUDE] == true){
		l = 1
	}
	else{
		l = 0
	}
		}
		
	value[e_value.POS_Y] = -value[e_value.POS_Y]

	value[e_value.OFFSET_Y] = -value[e_value.OFFSET_Y] - (element_type = TYPE_SHAPE ? l: 0)
	
	value[e_value.ROT_X] = -value[e_value.ROT_X]
	value[e_value.ROT_Z] = -value[e_value.ROT_Z]
	
	var HF = value[e_value.HIDE_FRONT]
	var HB = value[e_value.HIDE_BACK]
	
	value[e_value.HIDE_BACK] = HF

	value[e_value.HIDE_FRONT] = HB
	
			
	if(element_type = TYPE_PART){
		value[e_value.BEND_INVERT_X] = !value[e_value.BEND_INVERT_X]
		value[e_value.BEND_INVERT_Z] = !value[e_value.BEND_INVERT_Z]
		
		switch (value[e_value.BEND_PART])
		{
			case e_part.FRONT: value[e_value.BEND_PART] = e_part.BACK; value[e_value.BEND_OFFSET] = -value[e_value.BEND_OFFSET] break;
			
			case e_part.BACK: value[e_value.BEND_PART] = e_part.FRONT; value[e_value.BEND_OFFSET] = -value[e_value.BEND_OFFSET] break;			
		}
		
				if (shape_list != null && ds_list_size(shape_list) > 0)
		{
			for (var i = 0; i < ds_list_size(shape_list); i++)
			{
				with (shape_list[|i])
					el_mirror(mirrorAxis)
			}
		}
	
		if (part_list != null && ds_list_size(part_list) > 0)
		{
			for (var i = 0; i < ds_list_size(part_list); i++)
			{
				with (part_list[|i])
					el_mirror(mirrorAxis)
			}
		}
	}
}
	
    update_vbuffer = true
}