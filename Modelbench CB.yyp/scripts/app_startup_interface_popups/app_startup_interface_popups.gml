/// app_startup_interface_popups()

function app_startup_interface_popups()
{
	// About popup
	popup_about = new_popup("about", popup_about_draw, 696, null, false, true)
	
	// OBJ export popup
	popup_export = new_popup("export", popup_export_draw, 300, 94, true, true)
	//popup_whatsnew = new_popup("whatsnew", popup_whatsnew_draw, 542, 512, false, true)
	
	// Painter
	popup_huesat = new_popup("huesat", popup_hue_sat_draw, 300, null, false, true)
	popup_brightcontrast = new_popup("brightcontrast", popup_bright_contrast_draw, 300, null, false, true)
	popup_lospec = new_popup("lospec", popup_lospec_draw, 300, null, false, true)
	
	with (popup_huesat)
	{
		tbx_hue = new_textbox_ndecimals()	
		tbx_sat = new_textbox_ndecimals()	
		tbx_val = new_textbox_ndecimals()	
	}
	
	with (popup_brightcontrast)
	{
		tbx_brightness = new_textbox_ndecimals()	
		tbx_contrast = new_textbox_ndecimals()
	}
	with (popup_lospec)
	{
		tbx_name = new_textbox(true,0,"")	
	}
}
