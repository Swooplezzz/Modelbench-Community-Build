/// keybinds_update_match()
/// @desc Updates match errors in keybinds

function keybinds_update_match()
{
	with (obj_keybind)
	{
		match_error = false
		
		with (obj_keybind)
		{
			if (id = other.id)
				continue
			
			if (array_equals(keybind, other.keybind) && (windowcheck = other.windowcheck) && (string_contains(name, "painter") && string_contains(other.name, "painter")))
			{
				
				other.match_error = true
				break
			}
		}
	}
}
