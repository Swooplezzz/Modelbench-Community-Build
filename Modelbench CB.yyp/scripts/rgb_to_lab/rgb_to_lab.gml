/// rgb_to_lab(red, green, blue)
/// @arg red
/// @arg green
/// @arg blue

function rgb_to_lab(red, green, blue)
{
	var r = red;
	var g = green;
	var b = blue;

	// Convert RGB to XYZ
	var _x = (0.4124564 * r + 0.3575761 * g + 0.1804375 * b);
	var _y = (0.2126729 * r + 0.7151522 * g + 0.0721750 * b);
	var _z = (0.0193339 * r + 0.1191920 * g + 0.9503041 * b);

	// Normalize XYZ values
	var x_n = _x / 0.95047;
	var y_n = _y / 1.00000;
	var z_n = _z / 1.08883;

	// Convert XYZ to Lab
	var f_x = (x_n > 0.008856) ? power(x_n, 1.0 / 3.0) : (903.3 * x_n + 16.0) / 116.0;
	var f_y = (y_n > 0.008856) ? power(y_n, 1.0 / 3.0) : (903.3 * y_n + 16.0) / 116.0;
	var f_z = (z_n > 0.008856) ? power(z_n, 1.0 / 3.0) : (903.3 * z_n + 16.0) / 116.0;

	var L = (116.0 * f_y) - 16.0;
	var a = 500.0 * (f_x - f_y);
	var b = 200.0 * (f_y - f_z);

	return [L, a, b];
}