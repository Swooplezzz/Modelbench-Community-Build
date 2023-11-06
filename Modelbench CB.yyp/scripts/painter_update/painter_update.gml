// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function painter_update(view, cam){
	painter_update_surface(view, cam)
	
	var boxx, boxy, boxw, boxh;
	var texx, texy, texw, texh;
	
	// Calculate box
	boxx = view_area_x
	boxy = view_area_y
	boxw = view_area_width
	boxh = view_area_height
	
	texx = scale_offset_x
	texy = scale_offset_y
	texw = texturewidth *zoom
	texh = texturewidth *zoom
	
	boxx = floor(boxx)
	boxy = floor(boxy)
	boxw = floor(boxw)
	boxh = floor(boxh)
	var tex, texscale;
	tex = texspr
	texscale = 1
texsurf = surface_require(texsurf, texturewidth, textureheight)
drawsurf = surface_require(drawsurf, texturewidth, textureheight)
alphasurf = surface_require(alphasurf, texturewidth, textureheight)
colorsurf = surface_require(colorsurf, texturewidth, textureheight)
selectionsurf = surface_require(selectionsurf, texturewidth, textureheight)
#macro alphafix gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
if(keyboard_check_pressed(ord("V"))){
	if(!clipboard_has_img()) return;
	clipboard_dump_image(app.model_folder + "\\clipboard.png")

	
	var tempspr = sprite_add(app.model_folder + "\\clipboard.png",1,false,false,0,0);
	
surface_set_target(colorsurf){
draw_clear_alpha(c_black, 0)
shader_set(shader_colormask)
draw_sprite(tempspr,0,0,0)
shader_reset()

gpu_set_blendmode(bm_normal);
}
	surface_reset_target()
surface_set_target(alphasurf){

draw_clear_alpha(c_black, 1)
shader_set(shader_alphamask)
alphafix
draw_sprite_ext(tempspr, 0,0,0,1,1,0, c_white, 1)
shader_reset()
   gpu_set_colorwriteenable(true, true, true, true);

gpu_set_blendmode(bm_normal);
}
	surface_reset_target()
	sprite_delete(tempspr)
	if(sprite_exists(colorspr))
sprite_delete(colorspr)
colorspr = sprite_create_from_surface(colorsurf, 0,0,surface_get_width(colorsurf), surface_get_height(colorsurf), false, false, 0, 0)
	if(sprite_exists(alphaspr))
sprite_delete(alphaspr)
alphaspr = sprite_create_from_surface(alphasurf, 0,0,surface_get_width(alphasurf), surface_get_height(alphasurf), false, false, 0, 0)
}



var mousedx, mousedy;

mousedx = window_mouse_get_x() - scale_offset_x - mouse_x_prev;
mousedy = window_mouse_get_y() - scale_offset_y - mouse_y_prev;

if(keyboard_check(vk_control)){
if(keyboard_check_pressed(ord("Y"))){
	if(painter_history_pos > 0){
		painter_history_pos -= 2;
		if(sprite_exists(alphaspr))
		sprite_delete(alphaspr)
		if(sprite_exists(colorspr))
		sprite_delete(colorspr)
		show_debug_message(painter_history_pos);
		colorspr = sprite_duplicate(painter_history[painter_history_pos + 1])
		alphaspr =  sprite_duplicate(painter_history[painter_history_pos])
	}
}
else if(keyboard_check_pressed(ord("Z"))){
	if(painter_history_pos + 2 < painter_history_amount){
		painter_history_pos += 2;
		if(sprite_exists(alphaspr))
		sprite_delete(alphaspr)
		if(sprite_exists(colorspr))
		sprite_delete(colorspr)
		
		colorspr = sprite_duplicate(painter_history[painter_history_pos + 1])
		alphaspr =  sprite_duplicate(painter_history[painter_history_pos])
	}
}
}


if(keyboard_check(vk_control)){
	var m;
	m = (1 - 0.25 * mouse_wheel)
	if (m != 1)
	{
		targetzoom = clamp(targetzoom * m,  0.1, 100)
		
		targetoffx = offx +((mouse_x - (boxx + boxw /2)) / zoom - (mouse_x - (boxx + boxw / 2)) / targetzoom)
		targetoffy = offy +((mouse_y - (boxy + boxh /2)) / zoom - (mouse_y - (boxy + boxh / 2)) / targetzoom)
	}
}

zoom += (targetzoom - zoom) / max(1, 8 / delta)
			offx += (targetoffx - offx) / max(1, 8 / delta)
			offy += (targetoffy - offy) / max(1, 8 / delta)

if(mouse_check_button(mb_middle)){
	offx -= mouse_dx/ zoom;
	offy -= mouse_dy / zoom;
		targetoffx -= mousedx / zoom;
	targetoffy -= mousedy / zoom;
	app_mouse_wrap(content_x, content_y, content_width, content_height)
}


scale_offset_x = floor(boxx + (boxw / 2 - (texturewidth / 2 + offx) * zoom))
scale_offset_y = floor(boxy + (boxh / 2 - (textureheight / 2 + offy) * zoom))

var mousexsnap = snap((window_mouse_get_x()-scale_offset_x) /  zoom-.5 , 1)-.5
var mouseysnap =  snap((window_mouse_get_y() -scale_offset_y) /  zoom-.5 ,1)-.5
var prevmousexsnap =  snap(mouse_x_prev /  zoom-.5 ,1) -.5
var prevmouseysnap =  snap(mouse_y_prev  /  zoom-.5 ,1) -.5
var inbounds = ((mousexsnap + 1) < texturewidth && (mouseysnap + 1) < textureheight && (mousexsnap + 1) > 0 && (mouseysnap + 1) > 0) && content_mouseon
if(keyboard_check(ord("F"))){
	if(mouse_wheel_up())
	paint_width += 1;
	if(mouse_wheel_down())
	paint_width -= 1;
	paint_width = max(paint_width, 0)
}


render_set_culling(false)

if(inbounds){
	
painter_tool_color_picker(mousexsnap, mouseysnap);

}
surface_set_target(drawsurf){



//Draw.
if ((mouse_check_button(mb_left) || mouse_check_button(mb_right))&& paint_tool_selected = e_paint.BRUSH && inbounds){
 
	var color = (mouse_check_button(mb_left)? paint_primary_color : paint_secondary_color)

draw_circle_color( mousexsnap, mouseysnap, paint_width*.6 ,  color, color, false);

draw_line_width_color(prevmousexsnap, prevmouseysnap, mousexsnap, mouseysnap , paint_width*1.2, color, color);
gpu_set_blendmode(bm_subtract)
draw_set_color(c_black)
draw_surface(selectionsurf,0,0)
gpu_set_blendmode(bm_normal)
}

//Erase Alpha.
if(mouse_check_button(mb_left) && paint_tool_selected = e_paint.ERASE && inbounds){		

draw_circle_color( mousexsnap, mouseysnap, paint_width*.6 ,  c_black, c_black, false);

draw_line_width_color(prevmousexsnap, prevmouseysnap, mousexsnap, mouseysnap , paint_width*1.2, c_black, c_black);
gpu_set_blendmode(bm_subtract)
draw_set_color(c_black)
draw_surface(selectionsurf,0,0)
gpu_set_blendmode(bm_normal)
}



}

surface_reset_target();
//Erase
if(mouse_check_button(mb_left) && paint_tool_selected = e_paint.ERASE && inbounds){
surface_set_target(alphasurf){

draw_clear_alpha(c_black, 1)
draw_sprite_ext(alphaspr, 0,0,0,1,1,0, c_white, 1)
draw_surface_ext(drawsurf,0,0,1,1,0, c_black, 1)

}
surface_reset_target();
	if(sprite_exists(alphaspr))
sprite_delete(alphaspr)

alphaspr = sprite_create_from_surface(alphasurf, 0,0,surface_get_width(alphasurf), surface_get_height(alphasurf), false, false, 0, 0)
surface_set_target(colorsurf){

	draw_clear_alpha(c_black, 0)

draw_sprite(colorspr,0,0,0)
gpu_set_blendmode(bm_subtract);
draw_surface_ext(drawsurf,0,0,1,1,0,c_black, 1)

gpu_set_blendmode(bm_normal);


}
surface_reset_target()
if(sprite_exists(colorspr))
sprite_delete(colorspr)
colorspr = sprite_create_from_surface(colorsurf, 0,0,surface_get_width(colorsurf), surface_get_height(colorsurf), false, false, 0, 0)
	surface_set_target(drawsurf){
	draw_clear_alpha(c_black, 0)
	}
	surface_reset_target();
}
//Box Select
if(mouse_check_button_pressed(mb_left)  && paint_tool_selected = e_paint.BOX_SELECT && inbounds){
	select_pos_one = vec2(mousexsnap + .5, mouseysnap + .5)
}
if(mouse_check_button_pressed(mb_right)  && paint_tool_selected = e_paint.BOX_SELECT && inbounds){
	surface_set_target(selectionsurf){
		draw_clear_alpha(c_black,0)
		selection_active = false
	}
	surface_reset_target()
}
if(mouse_check_button(mb_left) && paint_tool_selected = e_paint.BOX_SELECT && inbounds){	
	surface_set_target(selectionsurf){
		if(selection_active = false){
		draw_clear_alpha(c_black,1)
			if(sprite_exists(selectionspr))
	sprite_delete(selectionspr)
	selectionspr = sprite_create_from_surface(selectionsurf, 0,0, surface_get_width(selectionsurf), surface_get_height(selectionsurf), false, false, 0,0)

		selection_active = true
		}

		draw_sprite_ext(selectionspr, 0,0,0,1,1,0,c_black,1);
		gpu_set_blendmode(bm_subtract);

        draw_rectangle_color(select_pos_one[X], select_pos_one[Y],  mousexsnap + .5, mouseysnap + .5, c_white, c_white, c_white, c_white, false)
gpu_set_blendmode(bm_normal);

	}
	surface_reset_target()
}
if((mouse_check_button_released(mb_left) || mouse_check_button_released(mb_right))  && paint_tool_selected = e_paint.BOX_SELECT){
	if(sprite_exists(selectionspr))
	sprite_delete(selectionspr)
	selectionspr = sprite_create_from_surface(selectionsurf, 0,0, surface_get_width(selectionsurf), surface_get_height(selectionsurf), false, false, 0,0)


}
//Update the surfaces and sprites after draw.
if(mouse_check_button_released(mb_right) || mouse_check_button_released(mb_left)){


surface_set_target(alphasurf){

draw_clear_alpha(c_black, 1)
draw_sprite_ext(alphaspr, 0,0,0,1,1,0, c_white, 1)

shader_set(shader_alphamask)
alphafix
draw_surface_ext(drawsurf,0,0,1,1,0, c_white, paint_opacity)
shader_reset()
   gpu_set_colorwriteenable(true, true, true, true);

gpu_set_blendmode(bm_normal);
}
surface_reset_target();
	

if(sprite_exists(alphaspr))
sprite_delete(alphaspr)
alphaspr = sprite_create_from_surface(alphasurf, 0,0,surface_get_width(alphasurf), surface_get_height(alphasurf), false, false, 0, 0)

surface_set_target(colorsurf){

alphafix
	draw_clear_alpha(c_black, 0)
shader_set(shader_premalpha)
draw_surface_ext(drawsurf,0,0,1,1,0,c_white, 1)

draw_sprite(colorspr,0,0,0)

draw_surface_ext(drawsurf,0,0,1,1,0,c_white, paint_opacity)
shader_reset()

gpu_set_blendmode(bm_normal);


}
surface_reset_target()
if(sprite_exists(colorspr))
sprite_delete(colorspr)
colorspr = sprite_create_from_surface(colorsurf, 0,0,surface_get_width(colorsurf), surface_get_height(colorsurf), false, false, 0, 0)
	surface_set_target(drawsurf){
	draw_clear_alpha(c_black, 0)
	}
	surface_reset_target();
	
	if(paint_tool_selected = e_paint.BRUSH || paint_tool_selected = e_paint.ERASE){
	painter_history_pop()
	painter_history_push()
	painter_history[0] = sprite_duplicate(colorspr);
	painter_history_pop()
	painter_history_push()
	painter_history[0] = sprite_duplicate(alphaspr);
	}

}






surface_set_target(colorsurf){
	draw_clear_alpha(c_black,1)
	draw_sprite(colorspr,0,0,0)
}
	surface_reset_target()


if((mouse_check_button_pressed(mb_left) || mouse_check_button_pressed(mb_right)) && paint_tool_selected = e_paint.FILL && inbounds && !filling){
	var color = (mouse_check_button_pressed(mb_left)? paint_primary_color : paint_secondary_color)
	
draw_floodfill(colorsurf, alphasurf, mousexsnap+ .5, mouseysnap + .5,surface_getpixel(colorsurf, mousexsnap +1, mouseysnap +1), color, 0)
filling = true;
if(sprite_exists(colorspr))
sprite_delete(colorspr)
colorspr = sprite_create_from_surface(colorsurf, 0,0,surface_get_width(colorsurf), surface_get_height(colorsurf), false, false, 0, 0)
if(sprite_exists(alphaspr))
sprite_delete(alphaspr)
alphaspr = sprite_create_from_surface(alphasurf, 0,0,surface_get_width(alphasurf), surface_get_height(alphasurf), false, false, 0, 0)

}



if(array_length(fillarr) > 0){
for(var a = 0; a < array_length(fillarr); a++){
	if(a > 250) break;
draw_floodfill(fillarr[a].surf,fillarr[a].alphasurf,fillarr[a].xx,fillarr[a].yy,fillarr[a].targ_color,fillarr[a].color, fillarr[a].side)	

array_delete(fillarr, a,1)
}

if(sprite_exists(colorspr))
sprite_delete(colorspr)
colorspr = sprite_create_from_surface(colorsurf, 0,0,surface_get_width(colorsurf), surface_get_height(colorsurf), false, false, 0, 0)
if(sprite_exists(alphaspr))
sprite_delete(alphaspr)
alphaspr = sprite_create_from_surface(alphasurf, 0,0,surface_get_width(alphasurf), surface_get_height(alphasurf), false, false, 0, 0)

}
if(array_length(fillarr) = 0 && filling){
filling = false	
	painter_history_pop()
	painter_history_push()
	painter_history[0] = sprite_duplicate(colorspr);
	painter_history_pop()
	painter_history_push()
	painter_history[0] = sprite_duplicate(alphaspr);
}
//Update the alpha mask.
surface_set_target(alphasurf){
	draw_clear(c_black)

draw_sprite(alphaspr,0,0,0)

gpu_set_blendmode(bm_normal);
}
surface_reset_target()
draw_gradient(content_x, content_y + content_height/3, content_width, content_height/1.5, c_accent, 0, 0,0.1,0.1)

clip_begin(scale_offset_x, scale_offset_y, zoom*texturewidth, zoom*textureheight)
		draw_box(boxx, boxy, boxw, boxh, false, c_level_middle, 1)
			for (var i = 0; i < ceil(boxw/192); i++)
				for (var j = 0; j < ceil(boxh/192); j++)
					draw_image(spr_uv_editor_pattern, 0, boxx + (i * 192), boxy + (j * 192), 1, 1, c_text_main, .05)
clip_end()

//GET THE FINAL ALPHA SPRITE

	if(sprite_exists(finalspr))
sprite_delete(finalspr)

	sprite_delete(finalspr)
	finalspr = sprite_create_from_surface(colorsurf, 0,0,surface_get_width(colorsurf), surface_get_height(colorsurf), false, false, 0, 0)

 sprite_set_alpha_from_sprite(finalspr, alphaspr)
 
draw_sprite_ext(finalspr, 0, scale_offset_x, scale_offset_y, zoom, zoom,0, c_white, 1)



	sprite_delete(res_edit.sprite)
res_edit.sprite = finalspr

draw_surface_ext(drawsurf, scale_offset_x, scale_offset_y, zoom, zoom,0, c_white, paint_opacity)
draw_surface_ext(selectionsurf, scale_offset_x, scale_offset_y, zoom, zoom,0, c_white, .5)
mouse_x_prev = window_mouse_get_x() - scale_offset_x

mouse_y_prev = window_mouse_get_y() - scale_offset_y


if(inbounds){
//Draw Cursor
draw_set_alpha(0.5)
draw_circle_color( ((mousexsnap + 1)* zoom) + scale_offset_x, ((mouseysnap + 1) *zoom) + scale_offset_y, paint_width / 2 * zoom,  c_black, c_black,true);

draw_circle_color( ((mousexsnap + 1)* zoom) + scale_offset_x, ((mouseysnap + 1) *zoom) + scale_offset_y, paint_width / 2 * zoom,  c_white, c_white,true);
draw_set_alpha(1)
}
//draw_rectangle_color( ((mousexsnap + .5)* zoom) + scale_offset_x, ((mouseysnap + .5) *zoom) + scale_offset_y,((mousexsnap + 1.5)* zoom) + scale_offset_x, ((mouseysnap + 1.5) *zoom) + scale_offset_y,  c_white, c_white,c_white, c_white,true);
if(inbounds){
		mouse_cursor = cr_none
		window_set_cursor(mouse_cursor)

switch(paint_tool_selected){
case e_paint.BRUSH:
draw_sprite(spr_icons,icons.BRUSH, window_mouse_get_x(), window_mouse_get_y() )
break
case e_paint.FILL:
draw_sprite(spr_icons,icons.FILL_TOOL, window_mouse_get_x() , window_mouse_get_y())
break
case e_paint.PICK:
draw_sprite(spr_icons,icons.PICKER, window_mouse_get_x() , window_mouse_get_y() )
break
case e_paint.ERASE:
draw_sprite(spr_icons,icons.ERASER, window_mouse_get_x() , window_mouse_get_y() )
break
case e_paint.BOX_SELECT:
draw_sprite(spr_icons,icons.BOX_SELECT, window_mouse_get_x() , window_mouse_get_y() )
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
render_set_culling(true)
}