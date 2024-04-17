/// clipboard_load_image(filename)
/// @arg filename

function clipboard_load_image(fname)
{
	return external_call(lib_clipboard_load_pngfile, fname)
}