/// colorpicker_brightness(value, add)
/// @arg value
/// @arg add

function paintercolorpicker_brightness(value, add)
{
	paintercolorpicker.brightness = min(255, paintercolorpicker.brightness * add + value)
	paintercolorpicker_update(null, make_color_hsv(paintercolorpicker.hue, paintercolorpicker.saturation, paintercolorpicker.brightness), false)
}
