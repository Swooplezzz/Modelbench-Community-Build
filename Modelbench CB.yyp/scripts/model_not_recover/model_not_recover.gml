/// model_recover()
/// @desc If available, loads the latest temporary model backup

function model_not_recover()
{
	if (file_exists_lib(temp_model_backup))
	{
		
		file_delete(temp_model_backup)
		model_recover_show = false
	}
}
