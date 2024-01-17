/// tab_control_textfield_group([label,[stack]])
/// @arg [label]
/// @arg [stack]

function tab_control_textfield_group()
{
	var label, height, stack;
	if (argument_count > 1)
		stack = argument[1]
	else stack = false
	
	if (argument_count > 0)
		label = argument[0]
	else
		label = true
	
	// Update draw_textfield_group when adjusting width
	height = (dw < 225 && stack) ? real(24 * textfield_amount) : 24
	
	tab_control(height + ((label_height + 8) * label))
}
