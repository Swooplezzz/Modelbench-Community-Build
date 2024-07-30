/// painter_tool_shape();

function painter_tool_shape(mousebutton){
	surface_set_target(draw_surf)
	{
		// Draw
		if (paint_tool_selected = e_paint.SHAPE)
		{
			
			if(mouse_left_pressed || mouse_right_pressed){
				pos1 = vec2(mousexsnap,mouseysnap);
			}
			if(mouse_left || mouse_right){
				draw_clear_alpha(c_black, 0)
			var color = (mousebutton = mb_left ? paint_primary_color : paint_secondary_color)
			var color2 = (mousebutton = mb_left ? paint_secondary_color : paint_primary_color)
			if (painter_main_color = 1){
				color = (mousebutton = mb_left ? paint_secondary_color : paint_primary_color)
				color2 = (mousebutton = mb_left ? paint_primary_color : paint_secondary_color)
			}
		
			//Draw shapes according to selected shape'
			switch(painter_tool_current_shape){
				case e_shape.BOX:
			        if(painter_shape_tool_fill = 0)
				    draw_rectangle_color(pos1[X],pos1[Y] , mousexsnap,mouseysnap , color, color,color,color,true);
					if(painter_shape_tool_fill = 1)
				    draw_rectangle_color(pos1[X] + 1,pos1[Y] + 1, mousexsnap + 1,mouseysnap + 1, color, color,color,color,false);
					if(painter_shape_tool_fill = 2){
				    draw_rectangle_color(pos1[X],pos1[Y] , mousexsnap,mouseysnap , color, color,color,color,false);
				    draw_rectangle_color(pos1[X],pos1[Y] , mousexsnap,mouseysnap , color2, color2,color2,color2,true);
			        }
				break;
				case e_shape.CIRCLE:
				    if(painter_shape_tool_fill = 0)
			        draw_ellipse_color(pos1[X],pos1[Y] , mousexsnap,mouseysnap,color,color,true);
				    if(painter_shape_tool_fill = 1){
			        draw_ellipse_color(pos1[X],pos1[Y] , mousexsnap,mouseysnap,color,color,false);
					draw_ellipse_color(pos1[X],pos1[Y] , mousexsnap,mouseysnap,color,color,true);
					}
				    if(painter_shape_tool_fill = 2){
			        draw_ellipse_color(pos1[X],pos1[Y] , mousexsnap,mouseysnap,color,color,false);
					draw_ellipse_color(pos1[X],pos1[Y] , mousexsnap,mouseysnap,color2,color2,true);
					}
				break;
				case e_shape.TRIANGLE:
				    if(painter_shape_tool_fill = 0)
			        draw_triangle_color(pos1[X], mouseysnap, (pos1[X] + mousexsnap) /2,pos1[Y], mousexsnap,mouseysnap,color,color,color,true);
				    if(painter_shape_tool_fill = 1){
			        draw_triangle_color(pos1[X], mouseysnap, (pos1[X] + mousexsnap) /2,pos1[Y], mousexsnap,mouseysnap,color,color,color,false);
			        draw_triangle_color(pos1[X], mouseysnap, (pos1[X] + mousexsnap) /2,pos1[Y], mousexsnap,mouseysnap,color,color,color,true);
					}
				    if(painter_shape_tool_fill = 2){
			        draw_triangle_color(pos1[X], mouseysnap, (pos1[X] + mousexsnap) /2,pos1[Y], mousexsnap,mouseysnap,color,color,color,false);
			        draw_triangle_color(pos1[X], mouseysnap, (pos1[X] + mousexsnap) /2,pos1[Y], mousexsnap,mouseysnap,color2,color2,color2,true);
					}
				break;
			}
			gpu_set_blendmode(bm_subtract)
			draw_set_color(c_black)
			draw_surface(selection_surf, 0, 0)
			gpu_set_blendmode(bm_normal)
			}
		}
	}
	surface_reset_target();
}