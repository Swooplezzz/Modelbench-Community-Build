/// draw_floodfill(surface, alphasurface, x, y, targetcolor, color, side, targetalpha)
/// @arg surface
/// @arg alphasurface
/// @arg x
/// @arg y
/// @arg targetcolor
/// @arg color
/// @arg side
/// @arg targetalpha

function fillthing(surf, alpha_surf, xx, yy, targ_color, color, side, targ_alpha)
{
    var surf_width = surface_get_width(surf);
    var surf_height = surface_get_height(surf);
	
    if (!(xx >= 0 && yy >= 0 && xx < surf_width && yy < surf_height))
		return;
	
    var offset = 4 * (xx + yy * surf_width);
	var selection = buffer_peek(selection_buffer, offset + 3, buffer_u8);
	//(surface_getpixel_ext(selection_surf,xx+.5,yy+.5) >> 24) & 255
	
    if (selection = 255)
		return;
	
    var red = buffer_peek(fill_buffer, offset, buffer_u8);
    var green = buffer_peek(fill_buffer, offset + 1, buffer_u8);
    var blue = buffer_peek(fill_buffer, offset + 2, buffer_u8);
    var alpha = buffer_peek(alpha_fill_buffer, offset + 2, buffer_u8);
	
	var cie_diffrence = color_cie76_diffrence(targ_color, make_color_rgb(red, green,blue));
    var check_tolerance =  cie_diffrence <=  power(100 * paint_tolerance, 2)/100 && abs(targ_alpha - alpha)/255<=  paint_tolerance;

    var col = make_colour_rgb(red, green, blue);
	var r,l,u,d;
	r = 0
	l = 0
	u = 0
	d = 0
	
    if (!check_tolerance || (col == color && alpha == 255))
		return;
    
    buffer_poke(fill_buffer, offset, buffer_u8, color_get_red(color));
    buffer_poke(fill_buffer, offset + 1, buffer_u8, color_get_green(color));
    buffer_poke(fill_buffer, offset + 2, buffer_u8, color_get_blue(color));
    buffer_poke(fill_buffer, offset + 3, buffer_u8, 255);
	
    buffer_poke(alpha_fill_buffer, offset, buffer_u8, 255);
    buffer_poke(alpha_fill_buffer, offset + 1, buffer_u8, 255);
    buffer_poke(alpha_fill_buffer, offset + 2, buffer_u8, 255);
    buffer_poke(alpha_fill_buffer, offset + 3, buffer_u8, 255);

	for (var i = 0; i < array_length(fill_arr); i++)
	{
		if(fill_arr[i].xx = xx+1 && fill_arr[i].yy = yy) 
			l = 1;
		if(fill_arr[i].xx = xx-1 && fill_arr[i].yy = yy) 
			r = 1;
		if(fill_arr[i].yy = yy+1 && fill_arr[i].xx = xx)
			u = 1
		if(fill_arr[i].yy = yy-1 && fill_arr[i].xx = xx) 
			d = 1
	}
	
	floodfill_frame_count += 1;
	if(floodfill_frame_count < 900)
	{
		if(l != 1 && side != 4)
			draw_floodfill(surf, alpha_surf, xx + 1, yy, targ_color, color, 1,targ_alpha);
		if(u != 1 && side != 3)
			draw_floodfill(surf, alpha_surf, xx, yy + 1, targ_color, color, 2,targ_alpha);
		if(d != 1 && side != 2)
			draw_floodfill(surf, alpha_surf, xx, yy - 1, targ_color, color, 3,targ_alpha);
		if(r != 1 && side != 1)
			draw_floodfill(surf, alpha_surf, xx - 1, yy, targ_color, color, 4,targ_alpha);
	}
	else
	{
		if(l != 1 && side != 4)
			draw_floodfill_add(surf, alpha_surf, xx + 1, yy, targ_color, color, 1,targ_alpha);
		if(u != 1 && side != 3)
			draw_floodfill_add(surf, alpha_surf, xx, yy + 1, targ_color, color, 2,targ_alpha);
		if(d != 1 && side != 2)
			draw_floodfill_add(surf, alpha_surf, xx, yy - 1, targ_color, color, 3,targ_alpha);
		if(r != 1 && side != 1)
			draw_floodfill_add(surf, alpha_surf, xx - 1, yy, targ_color, color, 4,targ_alpha);
	}
}
function PointInsideBounds(xx,yy,targ_color,targ_alpha, color){
	var surf_width = paint_texture_width;
    var surf_height = paint_texture_height;
	var offset = 4 * (xx + yy * surf_width);

    var selection = buffer_peek(selection_buffer, offset + 3, buffer_u8);
    if (!(xx >= 0 && yy >= 0 && xx < surf_width && yy < surf_height)) // Not inside ? Leave
		return false;
	if (selection = 255)
		return false;
			
    pixelfillred = buffer_peek(fill_buffer, offset, buffer_u8);
    pixelfillgreen = buffer_peek(fill_buffer, offset + 1, buffer_u8);
    pixelfillblue = buffer_peek(fill_buffer, offset + 2, buffer_u8);
    pixelfillalpha = buffer_peek(alpha_fill_buffer, offset + 2, buffer_u8);
	var col = make_colour_rgb(pixelfillred, pixelfillgreen, pixelfillblue);
	var cie_diffrence = color_cie76_diffrence(targ_color, col);
    var check_tolerance =  cie_diffrence <=  power(100 * paint_tolerance, 2)/100 && abs(targ_alpha - pixelfillalpha)/255<=  paint_tolerance;



    if (!check_tolerance || (col == color && pixelfillalpha == 255))
		return false;
		
	return true;
}
function scan(lx,rx,yy,s,targ_color,targ_alpha, color){
	var span_added = false;
	for(var i = lx; i <= rx; i++){
	if(!PointInsideBounds(i,yy,targ_color,targ_alpha, color)){
		span_added = false
	}
	else if(!span_added){
	ds_stack_push(s, [i,yy]);	
	}
	}
}
function pixel_set(xx,yy, color){
	var offset = 4 * (xx + yy * paint_texture_width);
				

	buffer_poke(fill_buffer, offset, buffer_u8, pixelfillred * (1-paint_opacity)+ color_get_red(color) * paint_opacity);
    buffer_poke(fill_buffer, offset + 1, buffer_u8, pixelfillgreen * (1-paint_opacity) + color_get_green(color) * paint_opacity);
    buffer_poke(fill_buffer, offset + 2, buffer_u8, pixelfillblue * (1-paint_opacity) + color_get_blue(color) * paint_opacity);
    buffer_poke(fill_buffer, offset + 3, buffer_u8, 255);
	
	var alpha = clamp(pixelfillalpha + paint_opacity * 255, 0, 255);
	buffer_poke(alpha_fill_buffer, offset, buffer_u8, alpha);
    buffer_poke(alpha_fill_buffer, offset + 1, buffer_u8, alpha);
    buffer_poke(alpha_fill_buffer, offset + 2, buffer_u8, alpha);
    buffer_poke(alpha_fill_buffer, offset + 3, buffer_u8, alpha);
}

function draw_floodfill(surf, alpha_surf, xx, yy, targ_color, color, side, targ_alpha)
{
	if (!PointInsideBounds(xx,yy,targ_color,targ_alpha, color))
		return;
		
	var s = ds_stack_create();
	
	ds_stack_push(s, [xx,yy]);
	
	while (!ds_stack_empty(s))
	{
		var xxyy = ds_stack_pop(s)
		var lx = xxyy[X];
		var _x = xxyy[X];
		var _y = xxyy[Y];
		
		while (PointInsideBounds(lx - 1, _y,targ_color,targ_alpha, color))
		{
		    pixel_set(lx - 1, _y, color);
		    lx = lx -1
		}
		
		while (PointInsideBounds(_x, _y,targ_color,targ_alpha, color))
		{
		    pixel_set(_x , _y, color);
		    _x = _x + 1;
		}
		scan(lx, _x - 1, _y + 1, s,targ_color,targ_alpha, color);
		scan(lx, _x - 1, _y - 1, s,targ_color,targ_alpha, color);
	}
	
	//(surface_getpixel_ext(selection_surf,xx+.5,yy+.5) >> 24) & 255
}
function draw_floodfill_no_border(surf, alpha_surf, xx, yy, targ_color, color, side, targ_alpha)
{
	
for(var i = 0; i< paint_texture_width; i++){
	for(var j = 0; j< paint_texture_height; j++){
	var offset = 4 * (i + j * paint_texture_width);


	 
	var selection = buffer_peek(selection_buffer, offset + 3, buffer_u8);
	if (selection = 255)
		continue
	pixelfillred = buffer_peek(fill_buffer, offset, buffer_u8);
    pixelfillgreen = buffer_peek(fill_buffer, offset + 1, buffer_u8);
    pixelfillblue = buffer_peek(fill_buffer, offset + 2, buffer_u8);
    pixelfillalpha = buffer_peek(alpha_fill_buffer, offset + 2, buffer_u8);	

	var col = make_colour_rgb(pixelfillred, pixelfillgreen, pixelfillblue);
	var cie_diffrence = color_cie76_diffrence(targ_color, col);
    var check_tolerance =  cie_diffrence <=  power(100 * paint_tolerance, 2)/100 && abs(targ_alpha - pixelfillalpha)/255<=  paint_tolerance;

    if (!check_tolerance || (col == color && pixelfillalpha == 255))
		continue

	buffer_poke(fill_buffer, offset, buffer_u8, pixelfillred * (1-paint_opacity)+ color_get_red(color) * paint_opacity);
    buffer_poke(fill_buffer, offset + 1, buffer_u8, pixelfillgreen * (1-paint_opacity) + color_get_green(color) * paint_opacity);
    buffer_poke(fill_buffer, offset + 2, buffer_u8, pixelfillblue * (1-paint_opacity) + color_get_blue(color) * paint_opacity);
    buffer_poke(fill_buffer, offset + 3, buffer_u8, 255);
	
	var alpha = clamp(pixelfillalpha + paint_opacity * 255, 0, 255);
	buffer_poke(alpha_fill_buffer, offset, buffer_u8, alpha);
    buffer_poke(alpha_fill_buffer, offset + 1, buffer_u8, alpha);
    buffer_poke(alpha_fill_buffer, offset + 2, buffer_u8, alpha);
    buffer_poke(alpha_fill_buffer, offset + 3, buffer_u8, alpha);
    }
}
}