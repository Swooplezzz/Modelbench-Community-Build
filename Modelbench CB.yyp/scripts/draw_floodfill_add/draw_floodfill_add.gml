/// draw_floodfill_add(surface, alphasurface, x, y, target, color, side, targetalpha)
/// @arg surface
/// @arg alphasurface
/// @arg x
/// @arg y
/// @arg target
/// @arg color
/// @arg side
/// @arg targetalpha

function draw_floodfill_add(_surf, _alphasurf, _xx, _yy, _targ, _color, _side, _targ_alpha)
{
	var struct = {
		surf : _surf,
		alphasurf : _alphasurf,
		xx : _xx,
		yy : _yy,
		targ_color: _targ,
		color : _color,
		side : _side,
		targ_alpha : _targ_alpha
	};
	
	array_add(fillarr, struct)

    var surf_width = surface_get_width(_surf);
    var surf_height = surface_get_height(_surf);
	
    if (!(_xx >= 0 && _yy >= 0 && _xx < surf_width && _yy < surf_height))
		return;

    var offset = 4 * (_xx + _yy * surf_width);
	
	var selection = buffer_peek(selection_buffer, offset + 3, buffer_u8);
    if (selection = 255)
		return;
	
    var red = buffer_peek(fill_buffer, offset, buffer_u8);
    var green = buffer_peek(fill_buffer, offset + 1, buffer_u8);
    var blue = buffer_peek(fill_buffer, offset + 2, buffer_u8);
    var alpha = buffer_peek(alpha_fill_buffer, offset + 2, buffer_u8);
	var cie_diffrence = color_cie76_diffrence(_targ, make_color_rgb(red, green,blue));
    var check_tolerance = cie_diffrence <= power(100 * paint_tolerance, 2)/100 && (_targ_alpha - alpha)/255 <= paint_tolerance;

    var col = make_colour_rgb(red, green, blue);

    if ((col == _color && alpha == 255)  ||!check_tolerance || array_length(fillarr) > 600)
		return;
	
    var r,l,u,d;
	r = 0
	l = 0
	u = 0
	d = 0
	for (var i = 0; i < array_length(fillarr); i++)
	{
		if(fillarr[i].xx = _xx+1 && fillarr[i].yy = _yy) 
		l = 1;
		if(fillarr[i].xx = _xx-1&& fillarr[i].yy = _yy) 
		r = 1;
		if(fillarr[i].yy = _yy+1&& fillarr[i].xx = _xx)
		u = 1
		if(fillarr[i].yy = _yy-1&& fillarr[i].xx = _xx) 
		d = 1
	}
	
	if (l != 1 && _side != 4)
		draw_floodfill_add(_surf, _alphasurf, _xx + 1, _yy, _targ, _color, 1,_targ_alpha);
    
	if (u != 1 && _side != 3)
		draw_floodfill_add(_surf, _alphasurf, _xx, _yy + 1, _targ, _color, 2,_targ_alpha);
 
	if (d != 1 && _side != 2)
		draw_floodfill_add(_surf, _alphasurf, _xx, _yy - 1, _targ, _color, 3,_targ_alpha);
    
	if (r != 1 && _side != 1)
		draw_floodfill_add(_surf, _alphasurf, _xx - 1, _yy, _targ, _color, 4,_targ_alpha);
}