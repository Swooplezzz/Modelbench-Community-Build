/// file_dialog_save_palette()

function file_dialog_save_palette()
{
	return file_dialog_save(text_get("filedialogsavepalette") + " (*.mipalette)|*.mipalette|", "", models_directory, text_get("filedialogsavepalettecaption"))
}