/// paintercolorpicker_red(value, add)
/// @arg value
/// @arg add

function paintercolorpicker_red(value, add)
{
	paintercolorpicker.red = min(255, paintercolorpicker.red * add + value)
	paintercolorpicker_update(null, make_color_rgb(paintercolorpicker.red, paintercolorpicker.green, paintercolorpicker.blue), true)
}
