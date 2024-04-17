/// app_update_painter()

function app_update_painter()
{
	if (painter_update_spr = true && res_edit != null)
	{
		if(sprite_exists(res_edit.sprite))
			sprite_delete(res_edit.sprite)
		res_edit.sprite = sprite_duplicate(finalspr)
		textures_list.update = true;
		painter_update_spr = false
	}
	//selectionsize = vec2(selection_btmright[0]-selection_topleft[0],selection_btmright[1]-selection_topleft[1]);
}