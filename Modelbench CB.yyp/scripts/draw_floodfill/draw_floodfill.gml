function draw_floodfill(surf, alphasurf, xx, yy, targ_color, color, side, targ_alpha){
    var surf_width = surface_get_width(surf);
    var surf_height = surface_get_height(surf);
	

    if(!(xx >= 0 && yy >= 0 && xx < surf_width && yy < surf_height)) return;
    var offset = 4 * (xx + yy * surf_width);
		var selection = buffer_peek(selection_buffer, offset + 3, buffer_u8);
	//(surface_getpixel_ext(selectionsurf,xx+.5,yy+.5) >> 24) & 255
    if(selection = 255) return;
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

	
    if((col == color && alpha == 255) || !check_tolerance){
		return;
	}
    
    buffer_poke(fill_buffer, offset, buffer_u8, color_get_red(color));
    buffer_poke(fill_buffer, offset + 1, buffer_u8, color_get_green(color));
    buffer_poke(fill_buffer, offset + 2, buffer_u8, color_get_blue(color));
    buffer_poke(fill_buffer, offset + 3, buffer_u8, 255);
	
    buffer_poke(alpha_fill_buffer, offset, buffer_u8, 255);
    buffer_poke(alpha_fill_buffer, offset + 1, buffer_u8, 255);
    buffer_poke(alpha_fill_buffer, offset + 2, buffer_u8, 255);
    buffer_poke(alpha_fill_buffer, offset + 3, buffer_u8, 255);

	for(var i = 0; i < array_length(fillarr); i++){
		if(fillarr[i].xx = xx+1 && fillarr[i].yy = yy) 
		l = 1;
		if(fillarr[i].xx = xx-1&& fillarr[i].yy = yy) 
		r = 1;
		if(fillarr[i].yy = yy+1&& fillarr[i].xx = xx)
		u = 1
		if(fillarr[i].yy = yy-1&& fillarr[i].xx = xx) 
		d = 1
	
	
	}
	if(l != 1 && side != 4)
    draw_floodfill_add(surf, alphasurf, xx + 1, yy, targ_color, color, 1,targ_alpha);
	if(u != 1&& side != 3)
    draw_floodfill_add(surf, alphasurf, xx, yy + 1, targ_color, color, 2,targ_alpha);
	if(d != 1&& side != 2)
    draw_floodfill_add(surf, alphasurf, xx, yy - 1, targ_color, color, 3,targ_alpha);
	if(r != 1&& side != 1)
    draw_floodfill_add(surf, alphasurf, xx - 1, yy, targ_color, color, 4,targ_alpha);
  
}