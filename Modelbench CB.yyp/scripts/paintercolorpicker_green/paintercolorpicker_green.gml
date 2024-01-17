/// paintercolorpicker_green(value, add)
/// @arg value
/// @arg add

function paintercolorpicker_green(value, add)
{
	paintercolorpicker.green = min(255, paintercolorpicker.green * add + value)
	paintercolorpicker_update(null, make_color_rgb(paintercolorpicker.red, paintercolorpicker.green, paintercolorpicker.blue), true)
}
