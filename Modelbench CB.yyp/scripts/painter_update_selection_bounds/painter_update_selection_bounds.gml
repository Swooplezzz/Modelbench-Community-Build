/// painter_update_selection_bounds()

function painter_update_selection_bounds()
{
	selection_buffer = buffer_create(paint_texture_width * paint_texture_height * 4, buffer_fixed, 1);
	buffer_get_surface(selection_buffer, selection_surf, 0);
	var topleft = [1000000,1000000]
	var btmright = [-1000000,-1000000]
	for (var i = 0; i < paint_texture_width; i++)
	{
		for(var j = 0; j < paint_texture_height; j++)
		{
			var offset = 4 * (i + j * paint_texture_width);
			var selection = buffer_peek(selection_buffer, offset + 3, buffer_u8);
			if (selection != 255)
			{
				topleft = [min(i, topleft[X]),min(j, topleft[Y])];
				btmright = [max(i, btmright[X]),max(j, btmright[Y])];
			}
		}
	}
	if(topleft[X] = 1000000)
		topleft[X] = 0
	if(topleft[Y] = 1000000)
		topleft[Y] = 0
	if(btmright[X] = -1000000)
		btmright[X] = -1
	if(btmright[Y] = -1000000)
		btmright[Y] = -1
	buffer_delete(selection_buffer);
	selection_topleft = topleft;
	btmright[X] += 1;
	btmright[Y] += 1;
	selection_btmright = btmright;
	draw_size = vec2(selection_topleft[0] - selection_btmright[0],selection_topleft[1] - selection_btmright[1]);
}