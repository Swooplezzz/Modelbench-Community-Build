// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function angle_axis(aAngle, aAxis){
aAxis = vec3_normalize(aAxis)
var rad = aAngle * ((pi * 2) / 360) * 0.5
aAxis = vec3_mul(aAxis, sin(rad))
return vec4(aAxis[@ X], aAxis[@ Y], aAxis[@ Z], cos(rad))

}