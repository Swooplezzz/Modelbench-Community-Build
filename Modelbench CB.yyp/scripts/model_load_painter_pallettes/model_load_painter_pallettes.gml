// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function model_load_painter_pallettes(map){
	
	with (obj_pallette)
		instance_destroy()

	ds_list_clear(pallette_list)
	
	if (!ds_map_valid(map))
		return 0
	show_debug_message("loading pallettes")


	if (!ds_map_exists(map,"pallettelist"))
		return 0
		
	 var pallettelist;
	pallettelist = map[?"pallettelist"];




	
	for (var i = 0; i < ds_list_size(pallettelist); i++)
	{
		
		show_debug_message("object pallette")
		var pallettemap = pallettelist[|i];
		
		if (ds_map_valid(pallettemap))
		{
			var palletteobj = new_obj(obj_pallette);
			palletteobj.name = value_get_string(pallettemap[?"name"], "")
	
			var colorlist = pallettemap[?"colorlist"];
			palletteobj.color_list = value_get_array(colorlist)
			for(var c = 0; c < array_length(palletteobj.color_list); c++)
			{
				palletteobj.color_list[c] = hex_to_color(palletteobj.color_list[c])
			}
			ds_list_add(pallette_list, palletteobj)
		}
	}
}