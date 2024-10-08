/// app_startup_interface_tabs()

function app_startup_interface_tabs()
{
	tab_move = null
	tab_move_name = ""
	tab_move_x = 0
	tab_move_width = 0
	tab_move_direction = e_scroll.VERTICAL
	tab_move_box_x = 0
	tab_move_box_y = 0
	tab_move_box_width = 0
	tab_move_box_height = 0
	tab_move_mouseon_panel = null
	tab_move_mouseon_panel_prev = null
	tab_move_mouseon_position = 0
	
	// Assets
	assets = new_tab(setting_assets_location, true)
	with (assets)
	{
		// Model properties
		model_properties = tab_add_category("modelproperties", icons.MODEL_SMALL, tab_assets_model_properties, false)
		with (model_properties)
		{
			tbx_model_name = new_textbox(true, 0, "")
			tbx_model_scale = new_textbox_decimals()
		}
		
		// Elements
		elements = tab_add_category("elements", icons.HIERARCHY_SMALL, tab_assets_elements, false)
		with (elements)
		{
			tbx_search = new_textbox(true, 0, "")
			search_string = ""
			element_search_list = ds_list_create()
			element_hover = null
			element_hover_prev = null
			
			tbx_name = new_textbox(true, 0, "")
			name_edit_element = null
			
			hor_scroll_el = new_obj(obj_scrollbar)
		}
		
		// Textures
		textures = tab_add_category("textures", icons.TEXTURE_SMALL, tab_assets_textures, false)
		with (textures)
		{
			preview = new_obj(obj_preview)
			tbx_texture_scale = new_textbox_integer()
		}
	}
	
	tex_preview = assets.textures.preview
	
	// Element editor
	element_editor = new_tab(setting_element_editor_location, false, header_element_editor)
	with (element_editor)
	{
		tbx_name = new_textbox(true, 0, "")
		tbx_depth = new_textbox_ninteger()
		
		transform = tab_add_category("transform", icons.TRANSFORM_SMALL, tab_element_editor_transform, false)
		with (transform)
		{
			// Position
			tbx_pos_x = new_textbox_ndecimals()
			tbx_pos_y = new_textbox_ndecimals()
			tbx_pos_z = new_textbox_ndecimals()
			
			tbx_pos_x.next_tbx = tbx_pos_y
			tbx_pos_y.next_tbx = tbx_pos_z
			tbx_pos_z.next_tbx = tbx_pos_x
			
			// Pivot offset
			tbx_off_x = new_textbox_ndecimals()
			tbx_off_y = new_textbox_ndecimals()
			tbx_off_z = new_textbox_ndecimals()
			
			tbx_off_x.next_tbx = tbx_off_y
			tbx_off_y.next_tbx = tbx_off_z
			tbx_off_z.next_tbx = tbx_off_x
			
			// Rotation
			tbx_rot_x = new_textbox_ndecimals()
			tbx_rot_y = new_textbox_ndecimals()
			tbx_rot_z = new_textbox_ndecimals()
			tbx_rot_x.suffix = "°"
			tbx_rot_y.suffix = "°"
			tbx_rot_z.suffix = "°"
			
			tbx_rot_x.next_tbx = tbx_rot_y
			tbx_rot_y.next_tbx = tbx_rot_z
			tbx_rot_z.next_tbx = tbx_rot_x
			
			// Size
			tbx_width = new_textbox_ndecimals()
			tbx_length = new_textbox_ndecimals()
			tbx_height = new_textbox_ndecimals()
			
			tbx_width.next_tbx = tbx_length
			tbx_length.next_tbx = tbx_height
			tbx_height.next_tbx = tbx_width
			
			// Scale
			scale_all = false
			tbx_sca_x = new_textbox_ndecimals()
			tbx_sca_y = new_textbox_ndecimals()
			tbx_sca_z = new_textbox_ndecimals()
			
			tbx_sca_x.next_tbx = tbx_sca_y
			tbx_sca_y.next_tbx = tbx_sca_z
			tbx_sca_z.next_tbx = tbx_sca_x
		}
		
		// Position
		/*
		position = tab_add_category("position", icons.TRANSFORM_SMALL, tab_element_editor_position, false)
		with (position)
		{
			
			
			copy = array(0, 0, 0)
		}
		
		// Pivot offset
		pivot_offset = tab_add_category("pivotoffset", icons.TRANSFORM_SMALL, tab_element_editor_offset, false)
		with (pivot_offset)
		{
			
			copy = array(0, 0, 0)
		}
		
		// Rotation
		rotation = tab_add_category("rotation", icons.TRANSFORM_SMALL, tab_element_editor_rotation, false)
		with (rotation)
		{
			copy = array(0, 0, 0)
		}
		
		// Size
		size = tab_add_category("size", icons.TRANSFORM_SMALL, tab_element_editor_size, false)
		with (size)
		{
			copy = array(8, 8, 8)
		}
		
		// Scale
		scale = tab_add_category("scale", icons.TRANSFORM_SMALL, tab_element_editor_scale, false)
		with (scale)
		{
			copy = array(1, 1, 1)
		}
		*/
		
		// Bend
		bend = tab_add_category("bend", icons.BEND_SMALL, tab_element_editor_bend, false)
		with (bend)
		{
			tbx_offset = new_textbox_ndecimals()
			tbx_end_offset = new_textbox_ndecimals()
			tbx_size = new_textbox_decimals()
			tbx_detail = new_textbox_decimals()
			
			tbx_min[0] = new_textbox_ndecimals()
			tbx_min[0].suffix = "°"
			tbx_max[0] = new_textbox_ndecimals()
			tbx_max[0].suffix = "°"
			tbx_min[1] = new_textbox_ndecimals()
			tbx_min[1].suffix = "°"
			tbx_max[1] = new_textbox_ndecimals()
			tbx_max[1].suffix = "°"
			tbx_min[2] = new_textbox_ndecimals()
			tbx_min[2].suffix = "°"
			tbx_max[2] = new_textbox_ndecimals()
			tbx_max[2].suffix = "°"
			
			tbx_angle[0] = new_textbox_ndecimals()
			tbx_angle[0].suffix = "°"
			tbx_angle[1] = new_textbox_ndecimals()
			tbx_angle[1].suffix = "°"
			tbx_angle[2] = new_textbox_ndecimals()
			tbx_angle[2].suffix = "°"
		}
		
		// Material
		material = tab_add_category("material", [icons.SPHERE_MATERIAL_SMALL, icons.SPHERE_MATERIAL_SMALL__DARK], tab_element_editor_material, false)
		with (material)
		{
			tbx_texture_scroll_speed = new_textbox_ndecimals()
			tbx_texture_scroll_direction = new_textbox_ndecimals()
			tbx_texture_scroll_direction.suffix = "°"
			tbx_mix_amount = new_textbox_integer()
			tbx_mix_amount.suffix = "%"
			tbx_opacity = new_textbox_integer()
			tbx_opacity.suffix = "%"
			tbx_brightness = new_textbox_integer()
			tbx_brightness.suffix = "%"
		}
		
		// Appearance
		appearance = tab_add_category("appearance", [icons.SPHERE_SHADING_SMALL, icons.SPHERE_SHADING_SMALL__DARK], tab_element_editor_appearance, false)
		with (appearance)
			tbx_inflate = new_textbox_ndecimals()
		
		// Wind
		wind = tab_add_category("wind", icons.WIND_SMALL, tab_element_editor_wind, false)
		with (wind)
		{
			tbx_zmin = new_textbox_ndecimals()
			tbx_zmax = new_textbox_ndecimals()
		}
		
		// Mine-imator
		mineimator = tab_add_category("mineimator", icons.CLAPPERBOARD_SMALL, tab_element_editor_mineimator, false)
	}
	
	// Preview
	preview = new_tab(setting_preview_location, false, null)
	preview.closeable = false
	with (preview)
	{
		// Background
		background = tab_add_category("background", icons.WORLD_SMALL, tab_preview_background, true) 
		with (background)
		{
			tbx_light_rotation = new_textbox_decimals()
			tbx_light_rotation.suffix = "°"
			
			tbx_light_range = new_textbox_decimals()
		}
		
		// Render
		render = tab_add_category("render", icons.CAMERA_SMALL, tab_preview_render, false)
		with (render)
		{
			//tbx_ssao_radius = new_textbox_integer()
			tbx_ssao_power = new_textbox_integer()
			tbx_ssao_power.suffix = "%"
			//tbx_ssao_blur_passes = new_textbox_integer()
			
			//tbx_shadows_blur_quality = new_textbox_integer()
			tbx_shadows_blur_size = new_textbox_integer()
			tbx_shadows_blur_size.suffix = "%"
		}
		//camera = tab_add_category("camera", icons.CAMERA_SMALL, tab_preview_camera, false)
		//with (camera)
		//{
		//		 Position
		//	tbx_pos_x = new_textbox_ndecimals()
		//	tbx_pos_y = new_textbox_ndecimals()
		//	tbx_pos_z = new_textbox_ndecimals()
			
		//	tbx_pos_x.next_tbx = tbx_pos_y
		//	tbx_pos_y.next_tbx = tbx_pos_z
		//	tbx_pos_z.next_tbx = tbx_pos_x
			
		//	 Rotation
		//	tbx_rot_x = new_textbox_ndecimals()
		//	tbx_rot_y = new_textbox_ndecimals()
		//	tbx_rot_z = new_textbox_ndecimals()
		//	tbx_rot_x.suffix = "°"
		//	tbx_rot_y.suffix = "°"
		//	tbx_rot_z.suffix = "°"
			
		//	tbx_rot_x.next_tbx = tbx_rot_y
		//	tbx_rot_y.next_tbx = tbx_rot_z
		//	tbx_rot_z.next_tbx = tbx_rot_x
		//}
		// Export
		tab_add_category("export", icons.IMAGE_EXPORT_SMALL, tab_preview_export, false) 
	}
	
	// Export .obj
	export = new_tab("right_secondary", false, header_export_model)
	
	// Settings
	settings = new_tab(setting_settings_location, false, null)
	with (settings)
	{
		// General
		general = tab_add_category("general", icons.SETTINGS_SMALL, tab_settings_general, false)
		with (general)
		{
			tbx_backup_time = new_textbox_integer()
			tbx_backup_amount = new_textbox_integer()
			
			tbx_fov = new_textbox_integer()
			tbx_fov.suffix = "°"
		}
		
		// Controls
		controls = tab_add_category("controls", icons.KEYBOARD_SMALL, tab_settings_controls, false)
		with (controls)
		{
			tbx_look_sensitivity = new_textbox_decimals()
			tbx_move_speed = new_textbox_decimals()
			tbx_fast_modifier = new_textbox_decimals()
			tbx_slow_modifier = new_textbox_decimals()
		}
		
		// Interface
		interface = tab_add_category("interface", icons.BRUSH_SMALL, tab_settings_interface, false)
	}
	
	colors = new_tab(setting_color_editor_location, false, null)
	colors.closeable = false
	with (colors)
	{
		// Color editor
		color_editor = tab_add_category("coloreditor", icons.FILL_TOOL, tab_color_editor, true)
		with (color_editor)
		{
			tbx_name = new_textbox(true, 0, "")
			name_edit_element = null
		}
		
		// Color palettes
		color_palettes = tab_add_category("colorpalettes", icons.PALETTE, tab_color_palettes, true)
		with (color_palettes)
		{
			tbx_name = new_textbox(true, 0, "")
			name_edit_element = null
		}
		
		// Painter textures
		textures = tab_add_category("textures", icons.TEXTURE_SMALL, tab_painter_textures, true)
		with (textures)
		{
			tbx_width = new_textbox_integer()
			tbx_height = new_textbox_integer()
		}
	}
			
	toolproperties = new_tab(setting_tool_properties_location, false, null)
	toolproperties.closeable = false
	with (toolproperties)
	{
		properties = tab_add_category("properties", icons.BRUSH, tab_tool_properties, true)	
		with (properties)
		{
			tbx_width = new_textbox_integer()
			tbx_opacity = new_textbox_integer()
			tbx_opacity.suffix = "%"
			tbx_tolerance = new_textbox_integer()
			tbx_tolerance.suffix = "%"
		}
	}
}
