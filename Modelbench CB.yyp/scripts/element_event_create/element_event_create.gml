/// element_event_create()
/// @desc Create event of an element.

function element_event_create()
{
	save_id = ""
	save_id = save_id_create()
	
	name = ""
	name_duplicate = false
	name_empty = true
	
	element_type = TYPE_PART
	type = "block"
	
	parent = null
	parent_is_selected = false
	parent_hover = false
	texture_scroll_speed = 0
	texture_scroll_direction = 0
	selected = false
	color = make_color_hsv(random(255), 255, 255)
	res = null
	depth = 0
	
	part_list = null
	shape_list = null
	
	hidden = false
	tree_hidden = false
	locked = false
	tree_locked = false
	bend_default_angle = vec3(0)
	
	shape_vbuffer = null
	extend = false
	update_vbuffer = false
	world_pos = point3D(0, 0, 0)
	world_pos_2d = point2D(0, 0)
	world_pos_2d_error = false
	world_rot = point3D(0, 0, 0)
	quat_rot = vec4(0,0,0,1)
	
	list_mouseon = false
	
	for (var v = 0; v < e_value.amount; v++)
		value[v] = element_value_default(v)
	
	shape_export_position_list = null
	shape_export_uv_list = null
	shape_export_vertex_list = null
	
	shape_unique_position_list = null
	shape_unique_uv_list = null
}
