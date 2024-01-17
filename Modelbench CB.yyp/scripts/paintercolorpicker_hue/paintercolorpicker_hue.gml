/// paintercolorpicker_hue(value, add)
/// @arg value
/// @arg add

function paintercolorpicker_hue(value, add)
{
	paintercolorpicker.hue = min(255, paintercolorpicker.hue * add + value)
	paintercolorpicker_update(null, make_color_hsv(paintercolorpicker.hue, paintercolorpicker.saturation, paintercolorpicker.brightness), false)
}
