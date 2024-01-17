/// paintercolorpicker_saturation(value, add)
/// @arg value
/// @arg add

function paintercolorpicker_saturation(value, add)
{
	paintercolorpicker.saturation = min(255, paintercolorpicker.saturation * add + value)
	paintercolorpicker_update(null, make_color_hsv(paintercolorpicker.hue, paintercolorpicker.saturation, paintercolorpicker.brightness), false)
}
