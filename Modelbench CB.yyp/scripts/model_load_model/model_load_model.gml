/// model_load_model(map)
/// @arg map

function model_load_model(map)
{
	if (!ds_map_valid(map))
		return 0
	
	// Mine-imator checks for model name, texture, and parts, Modelbench doesn't need do
	
	// Model name
	if (is_string(map[?"mb_name"]))
		model_name = value_get_string(map[?"mb_name"], "")
	else
		model_name = value_get_string(map[?"name"], "")
	
	// Root texture
	texture_name = value_get_string(map[?"texture"], null)
	
	// Texture size
	texture_size = value_get_point2D(map[?"texture_size"], point2D(16, 16))
	texture_size = vec2(max(texture_size[X], texture_size[Y])) // Make square
	
	if (texture_name != null)
	{
		res = model_load_texture(texture_name)
		res.scale = value_get_real(map[?"texture_scale"], 1)
	}
	
	// Default texture scroll
	texture_scroll_speed = 0
	texture_scroll_direction = 0
	
	// Color
	color_inherit = false
	color_blend = c_white
	color_alpha = 1
	color_brightness = 0
	color_mix = c_black
	color_mix_percent = 0
	
	// Allow Minecraft skins
	player_skin = value_get_real(map[?"player_skin"], false)
	floor_box_uvs = value_get_real(map[?"floor_box_uvs"], false)
	
	// Model color
	model_color = value_get_color(map[?"model_color"], c_white)
	
	// Scale (optional)
	scale = value_get_point3D(map[?"scale"], vec3(1))
	root_scale = max(scale[X], scale[Y], scale[Z])
	
	if (part_list = null)
		part_list = ds_list_create()
	
	// Read parts from root
	var partlist = map[?"parts"]
	for (var p = 0; p < ds_list_size(partlist); p++)
	{
		var part = model_load_part(partlist[|p], id)
		if (part = null)
			return null
		if (part > 0)
			ds_list_add(part_list, part)
	}
}
