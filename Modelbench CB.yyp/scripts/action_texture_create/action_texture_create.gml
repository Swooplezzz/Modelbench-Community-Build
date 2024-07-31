/// action_texture_create()

function action_texture_create()
{
	var name_count = 0;
	 	
	for (var i = 0; i < ds_list_size(textures_list.item); i++)
	{
		var purename = string_get_name(string_replace(textures_list.item[|i].name, ".png*", ""));
		if (purename = "New_Texture")
			name_count++;
	}
	var name = "New_Texture" + (name_count != 0 ? " ("+string(name_count)+")" : "") + ".png";
	var tex = new_tex(name);

	with (tex)
	{
		sprite = sprite_duplicate(spr_empty)
		size = point2D(16, 16)
		filename = name
	}
	model_save_texture_file(tex)
	textures_list.update = true
	
	model_reset_loaded()
	//painter_reset()
}