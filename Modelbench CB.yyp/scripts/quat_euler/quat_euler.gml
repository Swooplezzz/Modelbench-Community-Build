// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function quat_euler(euler){
/// euler_to_quaternion(euler_x, euler_y, euler_z)
// Converts Euler angles in degrees to a quaternion
var q, c1, c2, c3, s1, s2, s3;

//var ex = euler[@ X];
//var ey = euler[@ Y];
//var ez = euler[@ Z];

//        var t0 = dcos(ez * 0.5);
//        var t1 = dsin(ez * 0.5);
//        var t2 = dcos(ex * 0.5);
//        var t3 = dsin(ex * 0.5);
//        var t4 = dcos(ey * 0.5);
//        var t5 = dsin(ey * 0.5);



//        var qw = t0 * t2 * t4 + t1 * t3 * t5;
//        var qx = t0 * t3 * t4 - t1 * t2 * t5;
//        var qy = t0 * t2 * t5 + t1 * t3 * t4;
//        var qz = t1 * t2 * t4 - t0 * t3 * t5;
		
//	return vec4(qx, qy, qz, qw);
var q, c1, c2, c3, s1, s2, s3;

euler[@ X] = euler[@ X];
euler[@ Y] = euler[@ Y];
euler[@ Z] = euler[@ Z];

c1 = dcos(euler[@ X] / 2);
c2 = dcos(euler[@ Y] / 2);
c3 = dcos(euler[@ Z] / 2);
s1 = dsin(euler[@ X] / 2);
s2 = dsin(euler[@ Y] / 2);
s3 = dsin(euler[@ Z] / 2);

q[@ X] = s1 * c2 * c3 + c1 * s2 * s3
q[@ Y]= c1 * s2 * c3 - s1 * c2 * s3
q[@ Z]= c1 * c2 * s3 + s1 * s2 * c3
q[@ W] = c1 * c2 * c3 - s1 * s2 * s3

return q;
}