/// action_painter_recent_remove_color(color, index)
/// @arg color
/// @arg index

function action_painter_recent_remove_color(c, i)
{
	array_delete(recentcolor_list,i,1);
}