/// action_painter_tolerance(value, add)
/// @arg value
/// @arg add

function action_painter_tolerance(value, add)
{
	paint_tolerance = paint_tolerance * add + value/100
}