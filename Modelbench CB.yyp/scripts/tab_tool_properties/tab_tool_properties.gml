/// tab_tool_properties()

function tab_tool_properties()
{
	// Width
	tab_control_meter()
	draw_meter("toolpropertieswidth", dx, dy, dw, paint_width, 48, 1, 256, 1, 1, tab.properties.tbx_width, action_painter_width)
	tab_next()
	
	// Opacity
	tab_control_meter()
	draw_meter("toolpropertiesopacity", dx, dy, dw, round(paint_opacity * 100), 48, 0, 100, 100, 1, tab.properties.tbx_opacity, action_painter_opacity)
	tab_next()
	
	// Tolerance
	tab_control_meter()
	draw_meter("toolpropertiestolerance", dx, dy, dw, round(paint_tolerance * 100), 48, 0, 100, 5, 1, tab.properties.tbx_tolerance, action_painter_tolerance)
	tab_next()
	
	togglebutton_add("toolpropertiesshapecircle", null, e_shape.CIRCLE, painter_tool_current_shape = e_shape.CIRCLE, action_painter_shape)
	togglebutton_add("toolpropertiesshapebox", null, e_shape.BOX,painter_tool_current_shape = e_shape.BOX, action_painter_shape)
	togglebutton_add("toolpropertiesshapetriangle", null, e_shape.TRIANGLE, painter_tool_current_shape = e_shape.TRIANGLE, action_painter_shape)
	
	tab_control_togglebutton()
	draw_togglebutton("toolpropertiesshape", dx, dy)
	tab_next()
	
	togglebutton_add("toolpropertiesshapefill", null, 1, painter_shape_tool_fill = 1, action_painter_shape_fill)
	togglebutton_add("toolpropertiesshapenofill", null, 0,painter_shape_tool_fill = 0, action_painter_shape_fill)
	togglebutton_add("toolpropertiesshapefilloutline", null, 2, painter_shape_tool_fill = 2, action_painter_shape_fill)
	
	tab_control_togglebutton()
	draw_togglebutton("toolpropertiesshapefillmode", dx, dy)
	tab_next()
}