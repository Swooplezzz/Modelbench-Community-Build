/// paintercolorpicker_update(control, color, gethsb)
/// @arg control
/// @arg color
/// @arg gethsb

function paintercolorpicker_update(control, color, gethsb)
{
	paintercolorpicker.color = color
	
	if (gethsb)
	{
		paintercolorpicker.hue = floor(color_get_hue(paintercolorpicker.color))
		paintercolorpicker.saturation = floor(color_get_saturation(paintercolorpicker.color))
		paintercolorpicker.brightness = floor(color_get_value(paintercolorpicker.color))
	}
	else
	{
		paintercolorpicker.hue = floor(min(255, paintercolorpicker.hue))
		paintercolorpicker.saturation = floor(min(255, paintercolorpicker.saturation))
		paintercolorpicker.brightness = floor(min(255, paintercolorpicker.brightness))
	}
	
	if (control != paintercolorpicker.tbx_red)
	{
		paintercolorpicker.red = color_get_red(color) 
		paintercolorpicker.tbx_red.text = string(paintercolorpicker.red)
	}
	
	if (control != paintercolorpicker.tbx_green)
	{
		paintercolorpicker.green = color_get_green(color)
		paintercolorpicker.tbx_green.text = string(paintercolorpicker.green)
	}
	
	if (control != paintercolorpicker.tbx_blue)
	{
		paintercolorpicker.blue = color_get_blue(color)
		paintercolorpicker.tbx_blue.text = string(paintercolorpicker.blue)
	}
	
	if (control != paintercolorpicker.tbx_hue)
		paintercolorpicker.tbx_hue.text = string(paintercolorpicker.hue)
	
	if (control != paintercolorpicker.tbx_saturation)
		paintercolorpicker.tbx_saturation.text = string(paintercolorpicker.saturation)
	
	if (control != paintercolorpicker.tbx_brightness)
		paintercolorpicker.tbx_brightness.text = string(paintercolorpicker.brightness)
	
	if (control != paintercolorpicker.tbx_hexadecimal)
		paintercolorpicker.tbx_hexadecimal.text = color_to_hex(paintercolorpicker.color)
	if(program_mode = e_mode.TEXTURING)
	painter_editing_color = true;

	script_execute(paintercolorpicker.value_script, paintercolorpicker.color)
}
