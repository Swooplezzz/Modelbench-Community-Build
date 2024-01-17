function draw_floodfill(surf, alphasurf, xx, yy, targ_color, color, side, targ_alpha){
    var surf_width = surface_get_width(surf);
    var surf_height = surface_get_height(surf);
	
	var selection = (surface_getpixel_ext(selectionsurf,xx+.5,yy+.5) >> 24) & 255
    if(selection = 255) return;
    if(!(xx >= 0 && yy >= 0 && xx < surf_width && yy < surf_height)) return;
    
    var buffer = buffer_create(surf_width * surf_height * 4, buffer_fixed, 1);
    buffer_get_surface(buffer, surf, 0);
    
    var offset = 4 * (xx + yy * surf_width);
    var red = buffer_peek(buffer, offset, buffer_u8);
    var green = buffer_peek(buffer, offset + 1, buffer_u8);
    var blue = buffer_peek(buffer, offset + 2, buffer_u8);
    var alpha = buffer_peek(buffer, offset + 3, buffer_u8);
	var cie_diffrence = color_cie76_diffrence(targ_color, make_color_rgb(red, green,blue));
    var check_tolerance =  cie_diffrence <=  power(100 * paint_tolerance, 2)/100 && (targ_alpha - alpha) * 100 <= 100 * paint_tolerance;
	show_debug_message(cie_diffrence);
    var col = make_colour_rgb(red, green, blue);

    if(col == color || !check_tolerance){
		buffer_delete(buffer);
		return;
	}
    
    buffer_poke(buffer, offset, buffer_u8, color_get_red(color));
    buffer_poke(buffer, offset + 1, buffer_u8, color_get_green(color));
    buffer_poke(buffer, offset + 2, buffer_u8, color_get_blue(color));
    buffer_poke(buffer, offset + 3, buffer_u8, 255);
    
    buffer_set_surface(buffer, surf, 0);
    buffer_get_surface(buffer, alphasurf, 0);
	  var red = buffer_peek(buffer, offset, buffer_u8);
    var green = buffer_peek(buffer, offset + 1, buffer_u8);
    var blue = buffer_peek(buffer, offset + 2, buffer_u8);


    if(check_tolerance){
    buffer_poke(buffer, offset, buffer_u8, 255);
    buffer_poke(buffer, offset + 1, buffer_u8, 255);
    buffer_poke(buffer, offset + 2, buffer_u8, 255);
	}
    buffer_set_surface(buffer, alphasurf, 0);
    var r,l,u,d;
	r = 0
	l = 0
	u = 0
	d = 0
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
    
    buffer_delete(buffer);
}