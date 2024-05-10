  /// painter_colorpicker_update(control, color, gethsb)
/// @arg control
/// @arg color
/// @arg gethsb

function painter_colorpicker_update(control, color, gethsb)
{
	painter_colorpicker.color = color
	
	if (gethsb)
	{
		painter_colorpicker.hue = floor(color_get_hue(painter_colorpicker.color))
		painter_colorpicker.saturation = floor(color_get_saturation(painter_colorpicker.color))
		painter_colorpicker.brightness = floor(color_get_value(painter_colorpicker.color))
	}
	else
	{
		painter_colorpicker.hue = floor(min(255, painter_colorpicker.hue))
		painter_colorpicker.saturation = floor(min(255, painter_colorpicker.saturation))
		painter_colorpicker.brightness = floor(min(255, painter_colorpicker.brightness))
	}
	
	if (control != painter_colorpicker.tbx_red)
	{
		painter_colorpicker.red = color_get_red(color) 
		painter_colorpicker.tbx_red.text = string(painter_colorpicker.red)
	}
	
	if (control != painter_colorpicker.tbx_green)
	{
		painter_colorpicker.green = color_get_green(color)
		painter_colorpicker.tbx_green.text = string(painter_colorpicker.green)
	}
	
	if (control != painter_colorpicker.tbx_blue)
	{
		painter_colorpicker.blue = color_get_blue(color)
		painter_colorpicker.tbx_blue.text = string(painter_colorpicker.blue)
	}
	
	if (control != painter_colorpicker.tbx_hue)
		painter_colorpicker.tbx_hue.text = string(painter_colorpicker.hue)
	
	if (control != painter_colorpicker.tbx_saturation)
		painter_colorpicker.tbx_saturation.text = string(painter_colorpicker.saturation)
	
	if (control != painter_colorpicker.tbx_brightness)
		painter_colorpicker.tbx_brightness.text = string(painter_colorpicker.brightness)
	
	if (control != painter_colorpicker.tbx_hexadecimal)
		painter_colorpicker.tbx_hexadecimal.text = color_to_hex(painter_colorpicker.color)
	
	if(program_mode = e_mode.TEXTURING)
		painter_editing_color = true;

	script_execute(painter_colorpicker.value_script, painter_colorpicker.color)
}
