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
	texw = paint_texture_width * zoom
	texh = paint_texture_height * zoom
	
	boxx = floor(boxx)
	boxy = floor(boxy)
	boxw = floor(boxw)
	boxh = floor(boxh)
	var tex, texscale;
	tex = texspr
	texscale = 1
	
	//Adjust HSV 
if(adjust_huesat){
	render_shader_obj = shader_map[?shader_huesat]

	shader_set(shader_huesat)
	render_set_uniform("u_Position", hue)
	render_set_uniform("u_Position_s", sat/100)
	render_set_uniform("u_Position_l", val/100)
	render_set_uniform("u_colmask", 0.0)
    texture_set_stage(render_shader_obj.sampler_map[?"u_clipsampler"], surface_get_texture(selection_surf))
	
	alphafix
	draw_sprite_ext(finalspr, 0, scale_offset_x, scale_offset_y, zoom, zoom,0, c_white, 1)
	gpu_set_blendmode(bm_normal);
	shader_reset();
     gpu_set_texrepeat(false)
			render_shader_obj = shader_map[?shader_selection_outline]
			with (render_shader_obj)
				shader_use()
				
			shader_border_set(c_white, 1, paint_texture_width * zoom, paint_texture_height * zoom, 0.0, 0)
			
			draw_surface_ext(selection_surf, scale_offset_x, scale_offset_y, zoom, zoom,0, c_white, 1)

			with (render_shader_obj)
				shader_clear()
gpu_set_texrepeat(true)
}
else{
draw_sprite_ext(finalspr, 0, scale_offset_x, scale_offset_y, zoom, zoom,0, c_white, 1)
}
draw_surface_ext(draw_surf, scale_offset_x, scale_offset_y, zoom, zoom,0, c_white, paint_opacity)
			draw_surface_ext(selection_surf, scale_offset_x, scale_offset_y, zoom, zoom,0, c_white, 0.25)
			
if(selection_active && paint_tool_selected != e_paint.TRANSFORM  && !adjust_huesat)
{
	gpu_set_texrepeat(false)
	render_shader_obj = shader_map[?shader_selection_outline]
	with (render_shader_obj)
			shader_use()
				
    if(paint_tool_selected = e_paint.BOX_SELECT){
	    shader_border_set(c_accent, 1, paint_texture_width * zoom, paint_texture_height * zoom, 0.35, 0)
	}
	else{
		shader_border_set(c_white, 1, paint_texture_width * zoom, paint_texture_height * zoom, 0, 0)
	}
	draw_surface_ext(selection_surf, scale_offset_x, scale_offset_y, zoom, zoom,0, c_white, 1.0)

	with (render_shader_obj)
		shader_clear()
			
	gpu_set_texrepeat(true)
}

if(paint_tool_selected = e_paint.TRANSFORM && !adjust_huesat)
painter_transform(mousexsnap,mouseysnap);



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
if(!mouse_left &&paint_tool_selected != e_tool.TRANSFORM){
mouse_cursor = cr_none
window_set_cursor(mouse_cursor)
}

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

//SELECTION DEBUG, ONLY IN DEV MODE.
if(dev_mode && debug_info && paint_tool_selected = e_paint.BOX_SELECT){
	draw_box(scale_offset_x + selection_topleft[X] * zoom,scale_offset_y + selection_topleft[Y] * zoom,selection_size[X] * zoom,selection_size[Y] * zoom,true, c_white, 0.5);
	draw_box(scale_offset_x + selection_topleft[X] * zoom,scale_offset_y + selection_topleft[Y] * zoom,selection_size[X] * zoom,selection_size[Y] * zoom,true, c_black, 0.5);
	draw_box(scale_offset_x + selection_topleft[X] * zoom,scale_offset_y + selection_topleft[Y] * zoom,selection_size[X] * zoom,selection_size[Y] * zoom,true, c_red, 0.5);
	
	draw_box((selection_btmright[X] )* zoom+ scale_offset_x - 5, (selection_btmright[Y] )* zoom+ scale_offset_y - 5, 10, 10, false, c_white, .75)
	draw_box((selection_btmright[X] )* zoom+ scale_offset_x - 5, (selection_btmright[Y] )* zoom+ scale_offset_y - 5, 10, 10, true, c_black, .75)
	draw_box((selection_btmright[X] )* zoom+ scale_offset_x - 5, (selection_btmright[Y] )* zoom+ scale_offset_y - 5, 10, 10, true, c_red, .75)
	

	draw_box((selection_topleft[X] )* zoom+ scale_offset_x - 5, (selection_topleft[Y] )* zoom+ scale_offset_y - 5, 10, 10, false, c_white, .75)
	draw_box((selection_topleft[X] )* zoom+ scale_offset_x - 5, (selection_topleft[Y] )* zoom+ scale_offset_y - 5, 10, 10, false, c_red, .75)
	draw_box((selection_topleft[X] )* zoom+ scale_offset_x - 5, (selection_topleft[Y] )* zoom+ scale_offset_y - 5, 10, 10, true, c_black, .75)
}


	// Texture outline
	draw_line_ext(texx, boxy, texx, boxy + boxh, c_border, a_border)
	draw_line_ext(texx + texw + 1, boxy, texx + texw + 1, boxy + boxh, c_border, a_border)
	
	draw_line_ext(boxx, texy, boxx + boxw, texy, c_border, a_border)
	draw_line_ext(boxx, texy + texh + 1, boxx + boxw, texy + texh + 1, c_border, a_border)
	
	gpu_set_blendmode_ext(bm_inv_dest_color, bm_inv_src_color)
	
	// Pixel outline(zoom required multiplied by texscale for bigger textures)
	var snapval = 1;
	if (zoom * texscale > 5 && paint_view_grid)
	{
		var alpha = percent(zoom * texscale, 5, 7);
		
		// Highlight pixels seperately if snap value is not 1
		if (snapval != 1)
		{
			for (var i = texscale; i < paint_texture_width; i += texscale)
			{
				if (texx + floor(i * zoom) > boxx && texx + floor(i * zoom) < boxx + boxw)
					draw_line_ext(texx + floor(i * zoom) + 1, texy, texx + floor(i * zoom) + 1, texy + texh, merge_color(c_black, c_white, 0.03 * alpha), 1)
			}
			
			for (var i = texscale; i < paint_texture_height; i += texscale)
			{
				if (texy + floor(i * zoom) > boxy && texy + floor(i * zoom) < boxy + boxh)
					draw_line_ext(texx, texy + floor(i * zoom) + 1, texx + texw, texy + floor(i * zoom) + 1, merge_color(c_black, c_white, 0.03 * alpha), 1)
			}
		}
		
		for (var i = (texscale * snapval); i < paint_texture_width; i += (texscale * snapval))
		{
			if (texx + floor(i * zoom) > boxx && texx + floor(i * zoom) < boxx + boxw)
				draw_line_ext(texx + floor(i * zoom) + 1, texy, texx + floor(i * zoom) + 1, texy + texh, merge_color(c_black, c_white, 0.15 * alpha), 1)
		}
		
		for (var i = (texscale * snapval); i < paint_texture_height; i += (texscale * snapval))
		{
			if (texy + floor(i * zoom) > boxy && texy + floor(i * zoom) < boxy + boxh)
				draw_line_ext(texx, texy + floor(i * zoom) + 1, texx + texw, texy + floor(i * zoom) + 1, merge_color(c_black, c_white, 0.15 * alpha), 1)
		}
	}
		
	// Text
	gpu_set_blendmode(bm_normal)
	if(paint_view_brush_guides){
	draw_line_ext((mousexsnap + .5)  * zoom + scale_offset_x, boxy, (mousexsnap+ .5) * zoom + scale_offset_x, boxy + boxh,merge_color(c_black,c_accent_pressed, 0.75), .5)
	draw_line_ext((mousexsnap + 1.5)  * zoom + scale_offset_x, boxy, (mousexsnap + 1.5) * zoom + scale_offset_x, boxy + boxh,merge_color(c_black,c_accent_pressed, 0.75), .5)
    draw_line_ext(boxx, (mouseysnap+ .5)  * zoom+ scale_offset_y, boxx + boxw, (mouseysnap+ .5)  * zoom + scale_offset_y,merge_color(c_black,c_accent_pressed, 0.75), .5)
    draw_line_ext(boxx, (mouseysnap  + 1.5)  * zoom+ scale_offset_y, boxx + boxw, (mouseysnap  + 1.5)  * zoom + scale_offset_y,merge_color(c_black,c_accent_pressed, 0.75), .5)
	}
	draw_label("[ 0, 0 ]", texx - 8, texy - 8, fa_right, fa_bottom, c_text_main, 0.5, font_label)
	draw_label("[ " + string(paint_texture_width) + ", 0 ]", texx + texw + 8, texy - 8, fa_left, fa_bottom, c_text_main, 0.5, font_label)
	draw_label("[ 0, " + string(paint_texture_height) + " ]", texx - 8, texy + texh + 8, fa_right, fa_top, c_text_main, 0.5, font_label)
	draw_label("[ " + string(paint_texture_width) + ", " + string(paint_texture_height) + " ]", texx + texw + 8, texy + texh + 8, fa_left, fa_top, c_text_main, 0.5, font_label)


}