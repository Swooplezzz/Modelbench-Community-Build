// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function color_cie76_diffrence(color1, color2){
var r1 = color_get_red(color1) / 255;
var g1 = color_get_green(color1) / 255;
var b1 = color_get_blue(color1) / 255;

var r2 = color_get_red(color2) / 255;
var g2 = color_get_green(color2) / 255;
var b2 = color_get_blue(color2) / 255;

var lab1 = rgb_to_lab(r1, g1, b1);
var lab2 = rgb_to_lab(r2, g2, b2);

var deltaL = lab2[0] - lab1[0];
var deltaA = lab2[1] - lab1[1];
var deltaB = lab2[2] - lab1[2];

var cie76 = sqrt(deltaL * deltaL + deltaA * deltaA + deltaB * deltaB);

return cie76;
}