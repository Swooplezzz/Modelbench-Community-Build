/// app_update_program_mode()
/// @desc Hides and shows tabs depending on current program mode

function app_update_program_mode()
{
	if (program_mode = e_mode.MODELING)
	{
		tab_show(assets)
		tab_show(element_editor)
		tab_close(preview)
        tab_close(colors)
		tab_close(toolproperties)
		app_update_el_edit_tabs()
		textures_list.update = true;
		tex_preview.update = true
		view_cam = view_cam_viewport
		with (obj_model_element)
		{
			if (element_type = TYPE_SHAPE)
				update_vbuffer = true
		}
	with (app)
		el_update_part()
		// Free render surfaces from preview mode
		render_free()
		painter_free()
	}
	else if (program_mode = e_mode.PREVIEW)
	{
		tab_close(assets)
		tab_close(element_editor)
		tab_show(preview)
		tab_close(colors)
		tab_close(toolproperties)
		view_cam = view_cam_preview
		textures_list.update = true;
		tex_preview.update = true
			with (obj_model_element)
			{
				if (element_type = TYPE_SHAPE)
					update_vbuffer = true
			}
		with (app)
		el_update_part()
		painter_free()
	}
		else if (program_mode = e_mode.TEXTURING)
	{
		tab_close(assets)
		tab_close(element_editor)
		tab_close(preview)
		tab_show(colors)
		tab_show(toolproperties)
		textures_list.update = true;
		tex_preview.update = true
		view_cam = view_cam_viewport
		// Free render surfaces from preview mode
		render_free()
	}
}
