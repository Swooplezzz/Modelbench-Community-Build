// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function painter_transform(mousesnapx, mousesnapy){
if(selection_active){
	var sizex, sizey;

	sizex = (selection_btmright[0]-selection_topleft[0]);
	sizey = (selection_btmright[1]-selection_topleft[1]);

	surface_set_target(transformsurf){
			draw_clear_alpha(c_black,0)
	alphafix
	shader_set(shader_premalpha)
		draw_sprite_ext(transformspr, 0, (selection_topleft[X]), (selection_topleft[Y] ),sizex/selectionsize[X],sizey/selectionsize[Y],0, c_white, 1)
		shader_reset()
	gpu_set_blendmode(bm_normal)
	}
	surface_reset_target();
	draw_surface_ext(transformsurf, scale_offset_x, scale_offset_y, zoom, zoom,0, c_white, 1)
	gpu_set_texrepeat(false)
			render_shader_obj = shader_map[?shader_selection_outline]
			with (render_shader_obj)
				shader_use()
				
			shader_border_set(c_white, 1, texturewidth * zoom, textureheight * zoom,0)
			
			draw_surface_ext(selectionsurf, scale_offset_x, scale_offset_y, zoom, zoom,0, c_white, 1.0)

			with (render_shader_obj)
				shader_clear()
			
	gpu_set_texrepeat(true)
	var top_left;
	var top_right;
	if(mouse_left_released){
		window_busy = ""
	}
	//TOP LEFT CORNER
	draw_box((selection_topleft[X] )* zoom + scale_offset_x - 5, (selection_topleft[Y] )* zoom+ scale_offset_y - 5, 10, 10, false, c_white, .75)
	draw_box((selection_topleft[X] )* zoom + scale_offset_x - 5, (selection_topleft[Y] )* zoom+ scale_offset_y - 5, 10, 10, true, c_black, .75)
	if(app_mouse_box((selection_topleft[X] )* zoom + scale_offset_x - 5, (selection_topleft[Y] )* zoom+ scale_offset_y - 5, 10, 10) && mouse_left){
		window_busy = "painter_resize_topleft";

	}

	if(window_busy= "painter_resize_topleft"){
		selection_topleft = vec2(mousesnapx + 0.5,mousesnapy + 0.5)
	}

	draw_box((selection_btmright[X] )* zoom+ scale_offset_x - 5, (selection_btmright[Y] )* zoom+ scale_offset_y - 5, 10, 10, false, c_white, .75)
	draw_box((selection_btmright[X] )* zoom+ scale_offset_x - 5, (selection_btmright[Y] )* zoom+ scale_offset_y - 5, 10, 10, true, c_black, .75)
	
	if(app_mouse_box((selection_btmright[X] )* zoom+ scale_offset_x - 5, (selection_btmright[Y] )* zoom+ scale_offset_y - 5, 10, 10) && mouse_left){
		window_busy = "painter_resize_bottomright";

	}

	if(window_busy= "painter_resize_bottomright"){
	selection_btmright = vec2(mousesnapx + 0.5,mousesnapy + 0.5)
	}
	
	draw_box((selection_topleft[X] )* zoom+ scale_offset_x - 5, (selection_btmright[Y] )* zoom+ scale_offset_y - 5, 10, 10, false, c_white, .75)
	draw_box((selection_topleft[X] )* zoom+ scale_offset_x - 5, (selection_btmright[Y] )* zoom+ scale_offset_y - 5, 10, 10, true, c_black, .75)
	if(app_mouse_box((selection_topleft[X] )* zoom+ scale_offset_x - 5, (selection_btmright[Y] )* zoom+ scale_offset_y - 5, 10, 10) && mouse_left){
		window_busy = "painter_resize_bottomleft";

	}

	if(window_busy= "painter_resize_bottomleft"){
		selection_topleft[X] = mousesnapx + 0.5
		selection_btmright[Y] = mousesnapy + 0.5
	}
	draw_box((selection_btmright[X] )* zoom+ scale_offset_x - 5, (selection_topleft[Y] )* zoom+ scale_offset_y - 5, 10, 10, false, c_white, .75)
	draw_box((selection_btmright[X] )* zoom+ scale_offset_x - 5, (selection_topleft[Y] )* zoom+ scale_offset_y - 5, 10, 10, true, c_black, .75)
	if(app_mouse_box((selection_btmright[X] )* zoom+ scale_offset_x - 5, (selection_topleft[Y] )* zoom+ scale_offset_y - 5, 10, 10) && mouse_left){
		window_busy = "painter_resize_topright";

	}

	if(window_busy= "painter_resize_topright"){
		selection_btmright[X] = mousesnapx + 0.5
		selection_topleft[Y] = mousesnapy + 0.5
	}
}
}