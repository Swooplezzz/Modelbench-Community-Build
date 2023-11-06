// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_floodfill_add(_surf, _alphasurf, _xx,_yy,_targ,_color,_side){
var struct = {
surf : _surf,
alphasurf : _alphasurf,
xx : _xx,
yy : _yy,
targ_color: _targ,
color : _color,
side : _side
};



array_add(fillarr, struct)
}