/// toast_save_model()

function toast_save_model()
{

	var sb, errorsb, time;
	
	toast_delete("snackbarsavemodel")
	toast_delete("snackbarwarningsavemodel")
	
	sb = toast_new(e_toast.POSITIVE, text_get("snackbarsavemodel"))
	
	if(!setting_show_name_warnings) exit;
	time = sb.dismiss_time
	
	var errorstr, errors;
	errorstr = ""
	errors = (model_name = "") + warning_empty_part_names + warning_same_part_names
	time += errors
	
	if (warning_empty_part_names)
	{
		errors--
		errorstr += "• " + text_get("snackbarwarningemptypartname") + (errors > 0 ? "\n" : "")
	}

	if (warning_same_part_names)
	{
		errors--
		errorstr += "• " + text_get("snackbarwarningsamepartname") + (errors > 0 ? "\n" : "")
	}
	
	if (errorstr != "")
	{
		errorsb = toast_error(errorstr)
		errorsb.dismiss_time = time
	}
}
