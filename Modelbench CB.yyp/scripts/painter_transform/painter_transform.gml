/// painter_transform(x, y)
/// @arg x
/// @arg y

function painter_transform(xx, yy)
{
	var sizex, sizey;
	sizex = (selection_btmright[0] - selection_topleft[0]);
	sizey = (selection_btmright[1] - selection_topleft[1]);

	// No selection active ? Select all of the sprite;
	if (!selection_active)
	{
		if (sprite_exists(transformspr))
			sprite_delete(transformspr)
		transformspr = sprite_duplicate(finalspr);
	}

	surface_set_target(transformsurf)
	{
		draw_clear_alpha(c_black, 0)
		alphafix
	    gpu_set_colorwriteenable(false,false,false,true)
		draw_sprite_ext(transformspr, 0, (selection_topleft[X]), (selection_topleft[Y]), sizex / selectionsize[X], sizey / selectionsize[Y], 0, c_white, 1)
		gpu_set_colorwriteenable(true,true,true,false)
		draw_sprite_ext(transformspr, 0, (selection_topleft[X]), (selection_topleft[Y]), sizex / selectionsize[X], sizey / selectionsize[Y], 0, c_white, 1)
		gpu_set_colorwriteenable(true,true,true,true)

		gpu_set_blendmode(bm_normal)
	}
	surface_reset_target();
	
	surface_set_target(selectionsurf)
	{
		draw_clear(c_black)
		gpu_set_blendmode(bm_subtract)
		draw_sprite_ext(seltrnspr, 0, (selection_topleft[X]), (selection_topleft[Y]), sizex / selectionsize[X], sizey / selectionsize[Y], 0, c_black, 1)
		gpu_set_blendmode(bm_normal)
	}
	surface_reset_target();

	//Not selecting anything ?
	if (!selection_active)
	{
		selection_topleft = vec2(0, 0)
		selection_btmright = vec2(texturewidth, textureheight)
		selectionsize = vec2(selection_btmright[0] - selection_topleft[0], selection_btmright[1] - selection_topleft[1]);
		selection_active = true
		surface_set_target(selectionsurf)
		{
			draw_clear_alpha(c_white, 0)
			if (sprite_exists(selectionspr))
				sprite_delete(selectionspr)
			selectionspr = sprite_create_from_surface(selectionsurf, 0, 0, surface_get_width(selectionsurf), surface_get_height(selectionsurf), false, false, 0, 0)
		}
		surface_reset_target()
		
		if (sprite_exists(transformspr))
			sprite_delete(transformspr)
		transformspr = sprite_duplicate(finalspr)
		
		surface_set_target(drawsurf)
		{
			draw_clear(c_black)
			gpu_set_blendmode(bm_subtract)
			draw_set_color(c_black)
			draw_surface(selectionsurf, 0, 0)
			gpu_set_blendmode(bm_normal)
		}
		
		surface_reset_target()
		if (sprite_exists(seltrnspr))
			sprite_delete(seltrnspr)
		seltrnspr = sprite_create_from_surface(drawsurf, selection_topleft[X], selection_topleft[Y], selectionsize[X], selectionsize[Y], false, false, 0, 0)
		surface_set_target(drawsurf)
		{
			draw_clear_alpha(c_black, 0)
		}
		surface_reset_target()
		selection_moved = false;
	}

	if (!selection_moved)
	{
		painter_clear_selection()
		//painter_create_finalspr();
		selection_moved = true;
		painter_history_set("transform", finalspr, selectionspr, transformspr);
	}

	if (selection_active)
	{
		if (mouse_left_released)
		{
			if (sprite_exists(selectionspr))
				sprite_delete(selectionspr)
			selectionspr = sprite_create_from_surface(selectionsurf, 0, 0, surface_get_width(selectionsurf), surface_get_height(selectionsurf), false, false, 0, 0)
			
			painter_history_set("transform", finalspr, selectionspr, transformspr);

			window_busy = ""
		}
		draw_surface_ext(transformsurf, scale_offset_x, scale_offset_y, zoom, zoom, 0, c_white, 1)
	
		draw_set_alpha(0.5)
		draw_box(scale_offset_x + selection_topleft[X] * zoom, scale_offset_y + selection_topleft[Y] * zoom, sizex * zoom, sizey * zoom, true, c_white, 1);
		draw_box(scale_offset_x + selection_topleft[X] * zoom, scale_offset_y + selection_topleft[Y] * zoom, sizex * zoom, sizey * zoom, true, c_black, 1);
		draw_set_alpha(1)
	
		render_surface[0] = surface_require(render_surface[0], render_width, render_height);
		surface_set_target(render_surface[0])
		{
			draw_clear_alpha(c_black, 0);
			draw_sprite_ext(seltrnspr, 0, 0, 0, sizex / selectionsize[X], sizey / selectionsize[Y], 0, c_black, 1)
		}
		surface_reset_target();
		
		gpu_set_texrepeat(false)
		render_shader_obj = shader_map[?shader_selection_outline]
		with(render_shader_obj)
			shader_use()

		shader_border_set(c_white, 1, render_width * zoom, render_height * zoom, 0, 1)
		draw_surface_ext(render_surface[0], scale_offset_x + (selection_topleft[X] * zoom), scale_offset_y + (selection_topleft[Y] * zoom), zoom, zoom, 0, c_black, 1)
	
		with(render_shader_obj)
			shader_clear()
		
		gpu_set_texrepeat(true)
	
		//SIDES
		if (app_mouse_box((selection_topleft[X]) * zoom + scale_offset_x + 5, (selection_topleft[Y]) * zoom + scale_offset_y - 5, sizex * zoom - 10, 10) && mouse_left && window_busy = "")
		{
			window_busy = "painter_resize_top";
		}
		if (app_mouse_box((selection_topleft[X]) * zoom + scale_offset_x + 5, (selection_btmright[Y]) * zoom + scale_offset_y - 5, sizex * zoom - 10, 10) && mouse_left && window_busy = "")
		{
			window_busy = "painter_resize_btm";
		}
		if (app_mouse_box((selection_btmright[X]) * zoom + scale_offset_x - 5, (selection_topleft[Y]) * zoom + scale_offset_y + 5, 10, sizey * zoom - 10) && mouse_left && window_busy = "")
		{
			window_busy = "painter_resize_right";
		}
		if (app_mouse_box((selection_topleft[X]) * zoom + scale_offset_x - 5, (selection_topleft[Y]) * zoom + scale_offset_y + 5, 10, sizey * zoom - 10) && mouse_left && window_busy = "")
		{
			window_busy = "painter_resize_left";
		}

		if (window_busy = "painter_resize_top")
		{
			selection_topleft[Y] = yy + 0.5
		}
		if (window_busy = "painter_resize_btm")
		{
			selection_btmright[Y] = yy + 0.5
		}
		if (window_busy = "painter_resize_left")
		{
			selection_topleft[X] = xx + 0.5
		}
		if (window_busy = "painter_resize_right")
		{
			selection_btmright[X] = xx + 0.5
		}

		//TOP LEFT CORNER
		draw_box((selection_topleft[X]) * zoom + scale_offset_x - 5, (selection_topleft[Y]) * zoom + scale_offset_y - 5, 10, 10, false, c_white, .75)
		draw_box((selection_topleft[X]) * zoom + scale_offset_x - 5, (selection_topleft[Y]) * zoom + scale_offset_y - 5, 10, 10, true, c_black, .75)
		if (app_mouse_box((selection_topleft[X]) * zoom + scale_offset_x - 5, (selection_topleft[Y]) * zoom + scale_offset_y - 5, 10, 10) && mouse_left && window_busy = "")
		{
			window_busy = "painter_resize_topleft";

		}

		if (window_busy = "painter_resize_topleft")
		{
			selection_topleft = vec2(xx + 0.5, yy + 0.5)
		}

		draw_box((selection_btmright[X]) * zoom + scale_offset_x - 5, (selection_btmright[Y]) * zoom + scale_offset_y - 5, 10, 10, false, c_white, .75)
		draw_box((selection_btmright[X]) * zoom + scale_offset_x - 5, (selection_btmright[Y]) * zoom + scale_offset_y - 5, 10, 10, true, c_black, .75)
	
		if (app_mouse_box((selection_btmright[X]) * zoom + scale_offset_x - 5, (selection_btmright[Y]) * zoom + scale_offset_y - 5, 10, 10) && mouse_left && window_busy = "")
		{
			window_busy = "painter_resize_bottomright";

		}

		if (window_busy = "painter_resize_bottomright")
		{
			selection_btmright = vec2(xx + 0.5, yy + 0.5)
		}

		draw_box((selection_topleft[X]) * zoom + scale_offset_x - 5, (selection_btmright[Y]) * zoom + scale_offset_y - 5, 10, 10, false, c_white, .75)
		draw_box((selection_topleft[X]) * zoom + scale_offset_x - 5, (selection_btmright[Y]) * zoom + scale_offset_y - 5, 10, 10, true, c_black, .75)
		if (app_mouse_box((selection_topleft[X]) * zoom + scale_offset_x - 5, (selection_btmright[Y]) * zoom + scale_offset_y - 5, 10, 10) && mouse_left && window_busy = "")
		{
			window_busy = "painter_resize_bottomleft";

		}

		if (window_busy = "painter_resize_bottomleft")
		{
			selection_topleft[X] = xx + 0.5
			selection_btmright[Y] = yy + 0.5
		}
		draw_box((selection_btmright[X]) * zoom + scale_offset_x - 5, (selection_topleft[Y]) * zoom + scale_offset_y - 5, 10, 10, false, c_white, .75)
		draw_box((selection_btmright[X]) * zoom + scale_offset_x - 5, (selection_topleft[Y]) * zoom + scale_offset_y - 5, 10, 10, true, c_black, .75)
		if (app_mouse_box((selection_btmright[X]) * zoom + scale_offset_x - 5, (selection_topleft[Y]) * zoom + scale_offset_y - 5, 10, 10) && mouse_left && window_busy = "")
		{
			window_busy = "painter_resize_topright";

		}
		if (app_mouse_box((selection_topleft[X]) * zoom + scale_offset_x, (selection_topleft[Y]) * zoom + scale_offset_y, sizex * zoom + scale_offset_y, sizey * zoom + scale_offset_y) && mouse_left && window_busy = "")
		{
			window_busy = "painter_transform_move";

		}
		if (window_busy = "painter_transform_move")
		{
			selection_topleft[X] -= prevmousexsnap - mousexsnap
			selection_topleft[Y] -= prevmouseysnap - mouseysnap
			selection_btmright[X] -= prevmousexsnap - mousexsnap
			selection_btmright[Y] -= prevmouseysnap - mouseysnap
		}
		if (window_busy = "painter_resize_topright")
		{
			selection_btmright[X] = xx + 0.5
			selection_topleft[Y] = yy + 0.5
		}

		selection_topleft_prev = selection_topleft
		selection_btmright_prev = selection_btmright
	

		draw_box((selection_topleft[X] + sizex / 2) * zoom + scale_offset_x - 5, (selection_topleft[Y]) * zoom + scale_offset_y - 5, 10, 10, false, c_white, .75)
		draw_box((selection_topleft[X] + sizex / 2) * zoom + scale_offset_x - 5, (selection_topleft[Y]) * zoom + scale_offset_y - 5, 10, 10, true, c_black, .75)
	

		draw_box((selection_topleft[X] + sizex / 2) * zoom + scale_offset_x - 5, (selection_btmright[Y]) * zoom + scale_offset_y - 5, 10, 10, false, c_white, .75)
		draw_box((selection_topleft[X] + sizex / 2) * zoom + scale_offset_x - 5, (selection_btmright[Y]) * zoom + scale_offset_y - 5, 10, 10, true, c_black, .75)
	

		draw_box((selection_btmright[X]) * zoom + scale_offset_x - 5, (selection_topleft[Y] + sizey / 2) * zoom + scale_offset_y - 5, 10, 10, false, c_white, .75)
		draw_box((selection_btmright[X]) * zoom + scale_offset_x - 5, (selection_topleft[Y] + sizey / 2) * zoom + scale_offset_y - 5, 10, 10, true, c_black, .75)
	

		draw_box((selection_topleft[X]) * zoom + scale_offset_x - 5, (selection_topleft[Y] + sizey / 2) * zoom + scale_offset_y - 5, 10, 10, false, c_white, .75)
		draw_box((selection_topleft[X]) * zoom + scale_offset_x - 5, (selection_topleft[Y] + sizey / 2) * zoom + scale_offset_y - 5, 10, 10, true, c_black, .75)
	}

	draw_box((selection_topleft[X]) * zoom + scale_offset_x - 5, (selection_topleft[Y]) * zoom + scale_offset_y - 5, 10, 10, false, c_white, .75)
	draw_box((selection_topleft[X]) * zoom + scale_offset_x - 5, (selection_topleft[Y]) * zoom + scale_offset_y - 5, 10, 10, true, c_black, .75)
	if (app_mouse_box((selection_topleft[X]) * zoom + scale_offset_x - 5, (selection_topleft[Y]) * zoom + scale_offset_y - 5, 10, 10) && mouse_left && window_busy = "")
	{
		window_busy = "painter_resize_topleft";
	}

	if (window_busy = "painter_resize_topleft")
	{
		selection_topleft = vec2(xx + 0.5, yy + 0.5)
	}

	draw_box((selection_btmright[X]) * zoom + scale_offset_x - 5, (selection_btmright[Y]) * zoom + scale_offset_y - 5, 10, 10, false, c_white, .75)
	draw_box((selection_btmright[X]) * zoom + scale_offset_x - 5, (selection_btmright[Y]) * zoom + scale_offset_y - 5, 10, 10, true, c_black, .75)

	draw_box((selection_topleft[X]) * zoom + scale_offset_x - 5, (selection_topleft[Y]) * zoom + scale_offset_y - 5, 10, 10, false, c_white, .75)
	draw_box((selection_topleft[X]) * zoom + scale_offset_x - 5, (selection_topleft[Y]) * zoom + scale_offset_y - 5, 10, 10, true, c_black, .75)
}