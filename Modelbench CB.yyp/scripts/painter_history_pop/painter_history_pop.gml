// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function painter_history_pop(){
	model_changed = true;
	if (painter_history_pos > 0)
	{
		painter_history_amount -= painter_history_pos
		for (var h = 0; h < painter_history_amount; h++)
		{
			if (h < painter_history_pos)
			{
				with (painter_history[h])
				{
					//with (obj_history_save)
					//	if (hobj = other.id)
					//		instance_destroy()
					if(sprite_exists(id.sprite))
					sprite_delete(id.sprite);
					if(sprite_exists(id.selsprite))
					sprite_delete(id.selsprite);
					if(sprite_exists(id.trnsprite))
					sprite_delete(id.trnsprite);
				}
			}
			painter_history[h] = painter_history[h + painter_history_pos]
		}
	}
	
	painter_history_pos = 0
}