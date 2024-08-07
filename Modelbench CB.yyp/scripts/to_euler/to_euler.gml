/// to_euler(quat)
/// @arg quat

function to_euler(quat)
{
	var roll, pitch, yaw;
	var qw = quat[W], qx = quat[X], qy = quat[Y], qz = quat[Z];

	// Roll (x-axis rotation)
	var sinr_cosp = 2 * (qw * qx + qy * qz);
	var cosr_cosp = 1 - 2 * (qx * qx + qy * qy);
	roll = arctan2(sinr_cosp, cosr_cosp);

	// Pitch (y-axis rotation)
	var sinp = 2 * (qw * qy - qz * qx);
	if (abs(sinp) >= 1)
		pitch = pi / 2 * ((sinp > 0) ? 1 : -1)
	else
		pitch = arcsin(sinp);

	// Yaw (z-axis rotation)
	var siny_cosp = 2 * (qw * qz + qx * qy);
	var cosy_cosp = 1 - 2 * (qy * qy + qz * qz);
	yaw = arctan2(siny_cosp, cosy_cosp);

	return point3D(roll * 180/pi, pitch* 180/pi, yaw* 180/pi);
}