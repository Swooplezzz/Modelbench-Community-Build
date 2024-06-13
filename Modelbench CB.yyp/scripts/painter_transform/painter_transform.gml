/// painter_transform(x, y)
/// @arg x
/// @arg y

function painter_transform(xx, yy)
{
	if(!selection_moved){
	selection_pos = point2D_copy(selection_topleft);	
	selection_pos[X] += selection_size[X]/2;
	selection_pos[Y] += selection_size[Y]/2;
	}

	var sizex, sizey;
	sizex = (selection_btmright[0] - selection_topleft[0]);
	sizey = (selection_btmright[1] - selection_topleft[1]);
	var scalex = sizex / selection_size[X];
	var scaley = sizey / selection_size[Y];
	var diffxt = ( (selection_topleft[X] + sizex /2) - selection_pos[X]) * 2 + (selection_size[X] / 2 mod 1 != 0 ? 1 - scalex : 0);
	var diffyt = ( (selection_topleft[Y] + sizey /2)- selection_pos[Y]) * 2 + (selection_size[Y] / 2 mod 1 != 0 ? 1 - scaley : 0);
	var modsizex =  (selection_size[X] / 2 mod 1 != 0 ? .5 : 0)
	var modsizey =  (selection_size[Y] / 2 mod 1 != 0 ? .5 : 0)
	var diffx = diffxt * dcos(selection_rot)+ diffyt * dsin(selection_rot);
	var diffy = diffxt * -dsin(selection_rot)+ diffyt * dcos(selection_rot);


	


	
	// No selection active ? Select all of the sprite;
	if (!selection_active)
	{
		if (sprite_exists(transform_spr))
			sprite_delete(transform_spr)
		transform_spr = sprite_duplicate(final_spr);
	}
	sprite_set_offset(transform_spr,sprite_get_width(transform_spr)/2, sprite_get_height(transform_spr)/2)
	sprite_set_offset(sel_trn_spr,sprite_get_width(sel_trn_spr)/2, sprite_get_height(sel_trn_spr)/2 )
		var selection_center = vec2(scale_offset_x + (selection_pos[X]) *zoom,scale_offset_y + (selection_pos[Y])*zoom)
	
	var center2 = vec2_rotate([diffxt/2,diffyt/2], selection_rot, selection_pos)
    // Update the transformation on the sprite
	surface_set_target(transform_surf)
	{

		draw_clear_alpha(c_black, 0)
		alphafix
	    gpu_set_colorwriteenable(false,false,false,true)
		draw_sprite_ext(transform_spr, 0, selection_pos[X] + diffx /2- modsizex, selection_pos[Y]+ diffy/2 - modsizey , scalex, scaley, selection_rot, c_white, 1)
		gpu_set_colorwriteenable(true,true,true,false)
		draw_sprite_ext(transform_spr, 0, selection_pos[X] +  diffx/2- modsizex, selection_pos[Y]+ diffy /2- modsizey, scalex, scaley, selection_rot, c_white, 1)
		gpu_set_colorwriteenable(true,true,true,true)

		gpu_set_blendmode(bm_normal)
	}
	surface_reset_target();


	// Update the selection on the sprite
	surface_set_target(selection_surf)
	{
		draw_clear(c_black)
		gpu_set_blendmode(bm_subtract)
		draw_sprite_ext(sel_trn_spr, 0,selection_pos[X] +  diffx/2- modsizex, selection_pos[Y]+ diffy /2- modsizey, scalex, scaley, selection_rot, c_white, 1)
		gpu_set_blendmode(bm_normal)
	}
	surface_reset_target();

	//Not selecting anything ?
	if (!selection_active)
	{
		selection_topleft = vec2(0, 0)
		selection_btmright = vec2(paint_texture_width, paint_texture_height)
		selection_size = vec2(selection_btmright[0] - selection_topleft[0], selection_btmright[1] - selection_topleft[1]);
		selection_active = true
		surface_set_target(selection_surf)
		{
			draw_clear_alpha(c_white, 0)
			if (sprite_exists(selection_spr))
				sprite_delete(selection_spr)
			selection_spr = sprite_create_from_surface(selection_surf, 0, 0, surface_get_width(selection_surf), surface_get_height(selection_surf), false, false, 0, 0)
		}
		surface_reset_target()
		
		if (sprite_exists(transform_spr))
			sprite_delete(transform_spr)
		transform_spr = sprite_duplicate(final_spr)
		
		surface_set_target(draw_surf)
		{
			draw_clear(c_black)
			gpu_set_blendmode(bm_subtract)
			draw_set_color(c_black)
			draw_surface(selection_surf, 0, 0)
			gpu_set_blendmode(bm_normal)
		}
		
		surface_reset_target()
		if (sprite_exists(sel_trn_spr))
			sprite_delete(sel_trn_spr)
		sel_trn_spr = sprite_create_from_surface(draw_surf, selection_topleft[X], selection_topleft[Y], selection_size[X], selection_size[Y], false, false, 0, 0)
		surface_set_target(draw_surf)
		{
			draw_clear_alpha(c_black, 0)
		}
		surface_reset_target()
		selection_moved = false;
	}

	if (!selection_moved)
	{
		painter_clear_selection()
		//painter_create_final_spr();

		selection_moved = true;
		painter_history_set("transform", final_spr, selection_spr, transform_spr);
	}

	if (selection_active)
	{
		if (mouse_left_released)
		{

			if (sprite_exists(selection_spr))
				sprite_delete(selection_spr)
			selection_spr = sprite_create_from_surface(selection_surf, 0, 0, surface_get_width(selection_surf), surface_get_height(selection_surf), false, false, 0, 0)
			
			painter_history_set("transform", final_spr, selection_spr, transform_spr);

			window_busy = ""
		}
		draw_surface_ext(transform_surf, scale_offset_x, scale_offset_y, zoom, zoom, 0, c_white, 1)
	
		
	
		render_surface[0] = surface_require(render_surface[0], render_width, render_height);
		surface_set_target(render_surface[0])
		{
			draw_clear_alpha(c_black, 0);
			draw_sprite_ext(sel_trn_spr, 0,selection_pos[X]+ diffx /2 - modsizex + 40, selection_pos[Y]+ diffy /2  - modsizey+ 40, scalex, scaley, selection_rot, c_black, 1)
		}
		surface_reset_target();
		
		gpu_set_texrepeat(false)
		render_shader_obj = shader_map[?shader_selection_outline]
		with(render_shader_obj)
			shader_use()

		shader_border_set(c_white, 1, render_width * zoom, render_height * zoom, 0, 1)
		draw_surface_ext(render_surface[0], scale_offset_x + (floor(-40) * zoom), scale_offset_y + (floor(-40) * zoom), zoom, zoom, 0, c_black, 1)
		
		with(render_shader_obj)
			shader_clear()
		
		gpu_set_texrepeat(true)
		// ROTATION
	    surface_set_target(render_surface[0]){

			alphafix
			draw_clear_alpha(c_black, 0);
		draw_set_alpha(0.5)
		draw_box(scale_offset_x + selection_topleft[X] * zoom, scale_offset_y + selection_topleft[Y] * zoom, sizex * zoom, sizey * zoom, true, c_white, 1);
		draw_box(scale_offset_x + selection_topleft[X] * zoom, scale_offset_y + selection_topleft[Y] * zoom, sizex * zoom, sizey * zoom, true, c_black, 1);
		draw_set_alpha(1)
		if((app_mouse_box((selection_topleft[X]) * zoom + scale_offset_x - (sign(sizex) = 1 ? 40 : -40), (selection_topleft[Y]) * zoom + scale_offset_y - (sign(sizey) = 1 ? 40 : -10), sizex * zoom+ (sign(sizex) = 1 ? 80 : -80), 30,selection_rot,selection_center)) ||
		
		(app_mouse_box((selection_topleft[X]) * zoom + scale_offset_x-(sign(sizex) = 1 ? 40 : -40), (selection_btmright[Y]) * zoom + scale_offset_y + (sign(sizey) = 1 ? 10 : -40), sizex * zoom+ (sign(sizex) = 1 ? 80 : -80), 30,selection_rot,selection_center))|| 
		
		(app_mouse_box((selection_btmright[X]) * zoom + scale_offset_x + (sign(sizex) = 1 ? 10 : -40), (selection_topleft[Y]) * zoom + scale_offset_y - (sign(sizey) = 1 ? 10 : -10), 30, sizey * zoom + (sign(sizey) = 1 ? 20 : -20),selection_rot,selection_center)) ||
		
		(app_mouse_box((selection_topleft[X]) * zoom + scale_offset_x - (sign(sizex) = 1 ? 40 : -10), (selection_topleft[Y]) * zoom + scale_offset_y - (sign(sizey) = 1 ? 10 : -10), 30, sizey * zoom + (sign(sizey) = 1 ? 20 : -20),selection_rot,selection_center)) )
		{

			if(mouse_left  && window_busy = "")
			  window_busy = "painter_rotate";
		}
		
		if(window_busy = "painter_rotate"){
            var dosnap =  keyboard_check(vk_control)
			ang = point_direction(mouse_x , mouse_y , selection_center[X], selection_center[Y])
			prevang = point_direction(mouse_previous_x , mouse_previous_y , selection_center[X], selection_center[Y])
			painter_transform_rot += ang - prevang;

			if(dosnap)
			selection_rot = snap(painter_transform_rot, 45);
			else
			selection_rot = painter_transform_rot;
		}
		
		//SIDES
		if (app_mouse_box((selection_topleft[X]) * zoom + scale_offset_x + 5, (selection_topleft[Y]) * zoom + scale_offset_y - 5, sizex * zoom - 10, 10,selection_rot,selection_center) && mouse_left && window_busy = "")
		{
			window_busy = "painter_resize_top";
		}
		if (app_mouse_box((selection_topleft[X]) * zoom + scale_offset_x + 5, (selection_btmright[Y]) * zoom + scale_offset_y - 5, sizex * zoom - 10, 10,selection_rot,selection_center) && mouse_left && window_busy = "")
		{
			window_busy = "painter_resize_btm";
		}
		if (app_mouse_box((selection_btmright[X]) * zoom + scale_offset_x - 5, (selection_topleft[Y]) * zoom + scale_offset_y + 5, 10, sizey * zoom - 10,selection_rot,selection_center) && mouse_left && window_busy = "")
		{
			window_busy = "painter_resize_right";
		}
		if (app_mouse_box((selection_topleft[X]) * zoom + scale_offset_x - 5, (selection_topleft[Y]) * zoom + scale_offset_y + 5, 10, sizey * zoom - 10,selection_rot,selection_center) && mouse_left && window_busy = "")
		{
			window_busy = "painter_resize_left";
		}

		if (window_busy = "painter_resize_top")
		{
			selection_topleft[Y] -= snap((prevmouseysnap - mouseysnap ) * dcos(selection_rot) +  (prevmousexsnap - mousexsnap ) * dsin(selection_rot),1.0);

		}
		if (window_busy = "painter_resize_btm")
		{
			selection_btmright[Y] -= snap((prevmouseysnap - mouseysnap ) * dcos(selection_rot) +  (prevmousexsnap - mousexsnap ) * dsin(selection_rot),1.0);

		}
		if (window_busy = "painter_resize_left")
		{

			selection_topleft[X] -= snap((prevmousexsnap - mousexsnap ) * dcos(selection_rot)+  (prevmouseysnap - mouseysnap ) * -dsin(selection_rot),1.0);
		}
		if (window_busy = "painter_resize_right")
		{

			selection_btmright[X] -= snap((prevmousexsnap - mousexsnap ) * dcos(selection_rot)+  (prevmouseysnap - mouseysnap ) * -dsin(selection_rot),1.0);

		}

		//TOP LEFT CORNER
		draw_box((selection_topleft[X]) * zoom + scale_offset_x - 5, (selection_topleft[Y]) * zoom + scale_offset_y - 5, 10, 10, false, c_white, .75)
		draw_box((selection_topleft[X]) * zoom + scale_offset_x - 5, (selection_topleft[Y]) * zoom + scale_offset_y - 5, 10, 10, true, c_black, .75)
		if (app_mouse_box((selection_topleft[X]) * zoom + scale_offset_x - 5, (selection_topleft[Y]) * zoom + scale_offset_y - 5, 10, 10,selection_rot,selection_center ) && mouse_left && window_busy = "")
		{
			window_busy = "painter_resize_topleft";

		}

		if (window_busy = "painter_resize_topleft")
		{
			selection_topleft = vec2(selection_topleft[X] - snap(((prevmousexsnap - mousexsnap ) * dcos(selection_rot)+  (prevmouseysnap - mouseysnap ) * -dsin(selection_rot)),1.0),selection_topleft[Y] - snap(((prevmousexsnap - mousexsnap ) * dsin(selection_rot)+  (prevmouseysnap - mouseysnap ) * dcos(selection_rot)),1.0))
		}

		draw_box((selection_btmright[X]) * zoom + scale_offset_x - 5, (selection_btmright[Y]) * zoom + scale_offset_y - 5, 10, 10, false, c_white, .75)
		draw_box((selection_btmright[X]) * zoom + scale_offset_x - 5, (selection_btmright[Y]) * zoom + scale_offset_y - 5, 10, 10, true, c_black, .75)
	
		if (app_mouse_box((selection_btmright[X]) * zoom + scale_offset_x - 5, (selection_btmright[Y]) * zoom + scale_offset_y - 5, 10, 10,selection_rot,selection_center) && mouse_left && window_busy = "")
		{
			window_busy = "painter_resize_bottomright";

		}

		if (window_busy = "painter_resize_bottomright")
		{
			selection_btmright = vec2(selection_btmright[X] - snap(((prevmousexsnap - mousexsnap ) * dcos(selection_rot)+  (prevmouseysnap - mouseysnap ) * -dsin(selection_rot)),1.0),selection_btmright[Y] - snap(((prevmousexsnap - mousexsnap ) * dsin(selection_rot)+  (prevmouseysnap - mouseysnap ) * dcos(selection_rot)),1.0))
		}

		draw_box((selection_topleft[X]) * zoom + scale_offset_x - 5, (selection_btmright[Y]) * zoom + scale_offset_y - 5, 10, 10, false, c_white, .75)
		draw_box((selection_topleft[X]) * zoom + scale_offset_x - 5, (selection_btmright[Y]) * zoom + scale_offset_y - 5, 10, 10, true, c_black, .75)
		if (app_mouse_box((selection_topleft[X]) * zoom + scale_offset_x - 5, (selection_btmright[Y]) * zoom + scale_offset_y - 5, 10, 10,selection_rot,selection_center) && mouse_left && window_busy = "")
		{
			window_busy = "painter_resize_bottomleft";

		}

		if (window_busy = "painter_resize_bottomleft")
		{
			selection_topleft[X] -= snap((prevmousexsnap - mousexsnap ) * dcos(selection_rot)+  (prevmouseysnap - mouseysnap ) * -dsin(selection_rot), 1.0);
			selection_btmright[Y] -=  snap((prevmousexsnap - mousexsnap ) * dsin(selection_rot)+  (prevmouseysnap - mouseysnap ) * dcos(selection_rot), 1.0);
		}
		draw_box((selection_btmright[X]) * zoom + scale_offset_x - 5, (selection_topleft[Y]) * zoom + scale_offset_y - 5, 10, 10, false, c_white, .75)
		draw_box((selection_btmright[X]) * zoom + scale_offset_x - 5, (selection_topleft[Y]) * zoom + scale_offset_y - 5, 10, 10, true, c_black, .75)
		if (app_mouse_box((selection_btmright[X]) * zoom + scale_offset_x - 5, (selection_topleft[Y]) * zoom + scale_offset_y - 5, 10, 10,selection_rot,selection_center) && mouse_left && window_busy = "")
		{
			window_busy = "painter_resize_topright";

		}
		if (app_mouse_box((selection_topleft[X]) * zoom + scale_offset_x, (selection_topleft[Y]) * zoom + scale_offset_y, sizex * zoom , sizey * zoom ,selection_rot,selection_center) && mouse_left && window_busy = "")
		{
			window_busy = "painter_transform_move";

		}
		if (window_busy = "painter_transform_move")
		{
			selection_topleft[X] -= prevmousexsnap - mousexsnap
			selection_pos[X] -= prevmousexsnap - mousexsnap
			selection_topleft[Y] -= prevmouseysnap - mouseysnap
			selection_pos[Y] -= prevmouseysnap - mouseysnap
			selection_btmright[X] -= prevmousexsnap - mousexsnap
			selection_btmright[Y] -= prevmouseysnap - mouseysnap
		}
		if (window_busy = "painter_resize_topright")
		{
			selection_btmright[X] -= snap((prevmousexsnap - mousexsnap ) * dcos(selection_rot)+  (prevmouseysnap - mouseysnap ) * -dsin(selection_rot),1.0);
			selection_topleft[Y] -= snap((prevmouseysnap - mouseysnap ) * dcos(selection_rot) +  (prevmousexsnap - mousexsnap ) * dsin(selection_rot),1.0);
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
	if (app_mouse_box((selection_topleft[X]) * zoom + scale_offset_x - 5, (selection_topleft[Y]) * zoom + scale_offset_y - 5, 10, 10,selection_rot,selection_center) && mouse_left && window_busy = "")
	{
		window_busy = "painter_resize_topleft";
	}


	draw_box((selection_btmright[X]) * zoom + scale_offset_x - 5, (selection_btmright[Y]) * zoom + scale_offset_y - 5, 10, 10, false, c_white, .75)
	draw_box((selection_btmright[X]) * zoom + scale_offset_x - 5, (selection_btmright[Y]) * zoom + scale_offset_y - 5, 10, 10, true, c_black, .75)

	draw_box((selection_topleft[X]) * zoom + scale_offset_x - 5, (selection_topleft[Y]) * zoom + scale_offset_y - 5, 10, 10, false, c_white, .75)
	draw_box((selection_topleft[X]) * zoom + scale_offset_x - 5, (selection_topleft[Y]) * zoom + scale_offset_y - 5, 10, 10, true, c_black, .75)
	var px, py;

draw_circle((selection_topleft[X] + sprite_get_xoffset(sel_trn_spr))  * zoom + scale_offset_x, (selection_topleft[Y]+ sprite_get_yoffset(sel_trn_spr))* zoom + scale_offset_y, 10, false);
draw_circle((selection_pos[X] + diffx /2)  * zoom + scale_offset_x, (selection_pos[Y] + diffy /2) * zoom + scale_offset_y, 10, false);
	}
	surface_reset_target()
	gpu_set_blendmode(bm_normal)
	var new_mat = matrix_build(selection_center[X], selection_center[Y], 0, 0, 0, selection_rot, 1, 1, 1);
matrix_set(matrix_world, new_mat);

	draw_surface(render_surface[0],-selection_center[X],-selection_center[Y]);


matrix_set(matrix_world, MAT_IDENTITY);

draw_text_color(content_x, content_y + 200, string(selection_topleft),c_white,c_white,c_white,c_white,1);
draw_text_color(content_x, content_y + 24 + 200, string(selection_btmright),c_white,c_white,c_white,c_white,1);
draw_text_color(content_x, content_y + 48 + 200, string(selection_pos),c_white,c_white,c_white,c_white,1);
draw_text_color(content_x, content_y + 72 + 200, string(selection_center),c_white,c_white,c_white,c_white,1);

		if((app_mouse_box((selection_topleft[X]) * zoom + scale_offset_x-40, (selection_topleft[Y]) * zoom + scale_offset_y - 40, sizex * zoom+80, 30,selection_rot,selection_center)) ||
		(app_mouse_box((selection_topleft[X]) * zoom + scale_offset_x-40, (selection_btmright[Y]) * zoom + scale_offset_y + 10, sizex * zoom+80, 30,selection_rot,selection_center))|| 
		(app_mouse_box((selection_btmright[X]) * zoom + scale_offset_x + 10, (selection_topleft[Y]) * zoom + scale_offset_y - 10, 30, sizey * zoom + 20,selection_rot,selection_center)) ||
		(app_mouse_box((selection_topleft[X]) * zoom + scale_offset_x - 40, (selection_topleft[Y]) * zoom + scale_offset_y - 10, 30, sizey * zoom + 20,selection_rot,selection_center)) )
		{
			mouse_cursor = cr_none
			var iconoffset = [0, 0]
			ang = point_direction(mouse_x , mouse_y , selection_center[X], selection_center[Y])
			gpu_set_tex_filter(true);
			draw_sprite_ext(spr_icons,icons.RESET, window_mouse_get_x() - iconoffset[0], window_mouse_get_y() - iconoffset[1], 1, 1, ang - 180, c_black, .75)
			draw_sprite_ext(spr_icons,icons.RESET, window_mouse_get_x() - iconoffset[0] - 1, window_mouse_get_y() - iconoffset[1] - 1, 1, 1, ang - 180, c_white, .75)
			gpu_set_tex_filter(false);

		}
}