/// action_painter_adjust_contrast(value, add)
/// @arg value
/// @arg add

function action_painter_adjust_contrast(value, add)
{
	painter_adjust_contrast = painter_adjust_contrast * add + value
}