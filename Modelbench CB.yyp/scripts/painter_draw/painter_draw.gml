// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function painter_draw(mousexsnap,mouseysnap,inbounds){
	var boxx, boxy, boxw, boxh;
	var texx, texy, texw, texh;
	
	// Calculate box
	boxx = view_area_x
	boxy = view_area_y
	boxw = view_area_width
	boxh = view_area_height
	
	texx = scale_offset_x
	texy = scale_offset_y
	texw = texturewidth * zoom
	texh = texturewidth * zoom
	
	boxx = floor(boxx)
	boxy = floor(boxy)
	boxw = floor(boxw)
	boxh = floor(boxh)
	var tex, texscale;
	tex = texspr
	texscale = 1
	
draw_sprite_ext(finalspr, 0, scale_offset_x, scale_offset_y, zoom, zoom,0, c_white, 1)
draw_surface_ext(drawsurf, scale_offset_x, scale_offset_y, zoom, zoom,0, c_white, paint_opacity)
draw_surface_ext(selectionsurf, scale_offset_x, scale_offset_y, zoom, zoom,0, c_white, .5)


if(inbounds){
//Draw Cursor
if(paint_tool_selected = e_paint.BRUSH || paint_tool_selected = e_paint.ERASE){
draw_set_alpha(0.5)
draw_circle_color( ((mousexsnap + 1)* zoom) + scale_offset_x, ((mouseysnap + 1) *zoom) + scale_offset_y, paint_width / 2 * zoom,  c_black, c_black,true);

draw_circle_color( ((mousexsnap + 1)* zoom) + scale_offset_x, ((mouseysnap + 1) *zoom) + scale_offset_y, paint_width / 2 * zoom,  c_white, c_white,true);
draw_set_alpha(1)
}
else if(paint_tool_selected = e_paint.PICK || paint_tool_selected = e_paint.FILL){
	draw_set_alpha(0.5)

    draw_box_hover((mousexsnap + .5)* zoom + scale_offset_x,(mouseysnap + .5)* zoom + scale_offset_y, zoom, zoom, 3, c_white);
    draw_box_hover((mousexsnap + .5)* zoom + scale_offset_x,(mouseysnap + .5)* zoom + scale_offset_y, zoom, zoom, 3, c_black);

    draw_set_alpha(1)
}


}
//draw_rectangle_color( ((mousexsnap + .5)* zoom) + scale_offset_x, ((mouseysnap + .5) *zoom) + scale_offset_y,((mousexsnap + 1.5)* zoom) + scale_offset_x, ((mouseysnap + 1.5) *zoom) + scale_offset_y,  c_white, c_white,c_white, c_white,true);
if(inbounds){
		mouse_cursor = cr_none
		window_set_cursor(mouse_cursor)

switch(paint_tool_selected){
case e_paint.BRUSH:
draw_sprite_ext(spr_icons,icons.BRUSH, window_mouse_get_x(), window_mouse_get_y(),1,1,0, c_black, .5)
draw_sprite_ext(spr_icons,icons.BRUSH, window_mouse_get_x(), window_mouse_get_y(),1,1,0, c_white, .5)
break
case e_paint.FILL:
draw_sprite_ext(spr_icons,icons.FILL_TOOL, window_mouse_get_x(), window_mouse_get_y(),1,1,0, c_black, .5)
draw_sprite_ext(spr_icons,icons.FILL_TOOL, window_mouse_get_x(), window_mouse_get_y(),1,1,0, c_white, .5)
break
case e_paint.PICK:
draw_sprite_ext(spr_icons,icons.PICKER, window_mouse_get_x(), window_mouse_get_y(),1,1,0, c_black, .5)
draw_sprite_ext(spr_icons,icons.PICKER, window_mouse_get_x(), window_mouse_get_y(),1,1,0, c_white, .5)
break
case e_paint.ERASE:
draw_sprite_ext(spr_icons,icons.ERASER, window_mouse_get_x(), window_mouse_get_y(),1,1,0, c_black, .5)
draw_sprite_ext(spr_icons,icons.ERASER, window_mouse_get_x(), window_mouse_get_y(),1,1,0, c_white, .5)
break
case e_paint.BOX_SELECT:
draw_sprite_ext(spr_icons,icons.BOX_SELECT, window_mouse_get_x(), window_mouse_get_y(),1,1,0, c_white, .5)
draw_sprite_ext(spr_icons,icons.BOX_SELECT, window_mouse_get_x(), window_mouse_get_y(),1,1,0, c_black, .5)

break
}


}




	// Texture outline
	draw_line_ext(texx, boxy, texx, boxy + boxh, c_border, a_border)
	draw_line_ext(texx + texw + 1, boxy, texx + texw + 1, boxy + boxh, c_border, a_border)
	
	draw_line_ext(boxx, texy, boxx + boxw, texy, c_border, a_border)
	draw_line_ext(boxx, texy + texh + 1, boxx + boxw, texy + texh + 1, c_border, a_border)
	
	gpu_set_blendmode_ext(bm_inv_dest_color, bm_inv_src_color)
	
	// Pixel outline(zoom required multiplied by texscale for bigger textures)
	var snapval = (setting_snap ? max(setting_snap_size_uv, .125) : 1);
	if (zoom * texscale > 5)
	{
		var alpha = percent(zoom * texscale, 5, 7);
		
		// Highlight pixels seperately if snap value is not 1
		if (snapval != 1)
		{
			for (var i = texscale; i < textureheight; i += texscale)
			{
				if (texx + floor(i * zoom) > boxx && texx + floor(i * zoom) < boxx + boxw)
					draw_line_ext(texx + floor(i * zoom) + 1, texy, texx + floor(i * zoom) + 1, texy + texh, merge_color(c_black, c_white, 0.03 * alpha), 1)
			}
			
			for (var i = texscale; i < textureheight; i += texscale)
			{
				if (texy + floor(i * zoom) > boxy && texy + floor(i * zoom) < boxy + boxh)
					draw_line_ext(texx, texy + floor(i * zoom) + 1, texx + texw, texy + floor(i * zoom) + 1, merge_color(c_black, c_white, 0.03 * alpha), 1)
			}
		}
		
		for (var i = (texscale * snapval); i < texturewidth; i += (texscale * snapval))
		{
			if (texx + floor(i * zoom) > boxx && texx + floor(i * zoom) < boxx + boxw)
				draw_line_ext(texx + floor(i * zoom) + 1, texy, texx + floor(i * zoom) + 1, texy + texh, merge_color(c_black, c_white, 0.15 * alpha), 1)
		}
		
		for (var i = (texscale * snapval); i < textureheight; i += (texscale * snapval))
		{
			if (texy + floor(i * zoom) > boxy && texy + floor(i * zoom) < boxy + boxh)
				draw_line_ext(texx, texy + floor(i * zoom) + 1, texx + texw, texy + floor(i * zoom) + 1, merge_color(c_black, c_white, 0.15 * alpha), 1)
		}
	}
	
	gpu_set_blendmode(bm_normal)
}