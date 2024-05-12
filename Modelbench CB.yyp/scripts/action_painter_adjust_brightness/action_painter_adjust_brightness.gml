/// action_painter_adjust_brightness(value, add)
/// @arg value
/// @arg add

function action_painter_adjust_brightness(value, add)
{
	painter_adjust_brightness = painter_adjust_brightness * add + value
}