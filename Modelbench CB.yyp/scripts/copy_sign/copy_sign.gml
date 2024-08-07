/// copy_sign(valuex, valuey)
/// @arg valuex
/// @arg valuey

function copy_sign(valx, valy)
{
	if (valy >= 0)
		return abs(valx);
	else
		return -abs(valx);
}