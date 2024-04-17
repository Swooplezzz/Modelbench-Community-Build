/// clipboard_dump_image(filename)
/// @arg filename

function clipboard_dump_image(fn)
{
	return external_call(lib_clipboard_dump_pngfile, fn)
}