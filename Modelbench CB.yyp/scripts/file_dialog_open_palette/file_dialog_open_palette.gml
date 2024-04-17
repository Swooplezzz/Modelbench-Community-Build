/// file_dialog_open_palette()

function file_dialog_open_palette()
{
	return file_dialog_open(text_get("filedialogopenpalette") + " (*.mipalette)|*.mipalette|", "", models_directory, text_get("filedialogopenpalettecaption"))
}