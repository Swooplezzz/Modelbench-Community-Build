/// add_recent_color(color)
/// @arg color

function add_recent_color(color)
{
	// Remove color from array if same as new color
	for (var i = 0; i < array_length(recentcolor_list); i++)
	{
		if (recentcolor_list[i] = color)
			array_delete(recentcolor_list, i, 1)
	}
	
	// Remove last color in array if too long
	if (array_length(recentcolor_list) > 11)
	{
		array_delete(recentcolor_list, 11, 1)
	}
	
	array_insert(recentcolor_list, 0, color)
}