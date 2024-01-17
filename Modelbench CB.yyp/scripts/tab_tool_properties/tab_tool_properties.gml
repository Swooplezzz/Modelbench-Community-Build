// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function tab_tool_properties(){
	
			// Width
		tab_control_meter()
		draw_meter("toolpropertieswidth", dx, dy, dw, paint_width, 48, 1, 256, 1, 1, tab.properties.tbx_width, action_painter_width)
		tab_next()
		// Opacity
		tab_control_meter()
		draw_meter("toolpropertiesopacity", dx, dy, dw, round(paint_opacity * 100), 48, 0, 100, 100, 1, tab.properties.tbx_opacity, action_painter_opacity)
		tab_next()
		
		tab_control_meter()
		draw_meter("toolpropertiestolerance", dx, dy, dw, round(paint_tolerance * 100), 48, 0, 100, 100, 1, tab.properties.tbx_tolerance, action_painter_tolerance)
		tab_next()

}