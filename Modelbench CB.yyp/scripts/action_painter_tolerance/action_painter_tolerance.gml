/// action_painter_opacity(value, add)
/// @arg value
/// @arg add

function action_painter_opacity(value, add)
{
	paint_opacity = paint_opacity * add + value/100
}