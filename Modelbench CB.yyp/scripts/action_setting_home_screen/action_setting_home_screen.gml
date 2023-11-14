/// action_setting_home_screen()

function action_setting_home_screen()
{
	var save = false;
	
	if (model_changed)
	{
		if (model_temporary)
		{
			if (question(text_get("questionconfirmsaveopen")))
				save = true
		}
		else
		{
			if (question(text_get("questionconfirmopen", model_name)))
				save = true
		}
	}

	// Save model
	if (save)
	{
		if (!model_save())
			return 0

	}
	else{
		model_reset()
	}
		window_state = "startup"

	program_mode = e_mode.MODELING
	app_update_program_mode()
	history_clear()
	window_busy = ""
	settings_menu_ani = 0
	settings_menu_ani_type = ""
	context_menu_close()
	popup_close()
		log("Model Reset")

}
