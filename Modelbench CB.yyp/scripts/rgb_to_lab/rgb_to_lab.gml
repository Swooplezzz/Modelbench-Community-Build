// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function rgb_to_lab(){
var r = argument0 ;
var g = argument1 ;
var b = argument2 ;

var _x = r * 0.4124564 + g * 0.3575761 + b * 0.1804375;
var _y = r * 0.2126729 + g * 0.7151522 + b * 0.0721750;
var _z = r * 0.0193339 + g * 0.1191920 + b * 0.9503041;

var epsilon = 0.008856;
var kappa = 903.3;

var xRef = 0.95047;
var yRef = 1.00000;
var zRef = 1.08883;

var xr = _x / xRef;
var yr = _y / yRef;
var zr = _z / zRef;

var fx = (xr > epsilon) ? power(xr, 1/3) : (kappa * xr + 16) / 116;
var fy = (yr > epsilon) ?  power(yr, 1/3): (kappa * yr + 16) / 116;
var fz = (zr > epsilon) ?  power(zr, 1/3) : (kappa * zr + 16) / 116;

var L = (116 * fy) - 16;
var a = 500 * (fx - fy);
var b = 200 * (fy - fz);

return [L, a, b];
}