// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function quat_mul(q1, q2){

var axisx = q1[X]*q2[W] + q1[W]*q2[X] + q1[Y]*q2[Z] - q1[Z]*q2[Y];
var axisy = q1[Y]*q2[W] + q1[W]*q2[Y] + q1[Z]*q2[X] - q1[X]*q2[Z];
var axisz = q1[Z]*q2[W] + q1[W]*q2[Z] + q1[X]*q2[Y] - q1[Y]*q2[X];
var axisw = q1[W]*q2[W] - q1[X]*q2[X] - q1[Y]*q2[Y] - q1[Z]*q2[Z];

return vec4(axisx, axisy, axisz, axisw);
}