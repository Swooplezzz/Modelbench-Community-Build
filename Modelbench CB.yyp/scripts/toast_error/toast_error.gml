/// toast_error(text)
/// @arg text

function toast_error(text)
{
	return toast_new(e_toast.WARNING, text)
}