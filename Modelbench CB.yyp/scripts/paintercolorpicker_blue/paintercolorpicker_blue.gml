/// paintercolorpicker_blue(value, add)
/// @arg value
/// @arg add

function paintercolorpicker_blue(value, add)
{
	paintercolorpicker.blue = min(255, paintercolorpicker.blue * add + value)
	paintercolorpicker_update(null, make_color_rgb(paintercolorpicker.red, paintercolorpicker.green, paintercolorpicker.blue), true)
}
