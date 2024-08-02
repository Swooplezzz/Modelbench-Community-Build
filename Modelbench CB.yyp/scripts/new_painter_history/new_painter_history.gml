/// new_painter_history(type)
/// @arg type

function new_painter_history(type)
{
	with (new_obj(obj_history))
	{
		val = type
		sprite = null
		trnsprite = null;
		selsprite = null;
		seltrnsprite = null;
		sel_active = false;
		selection_pos = vec2(0);
		pos_tl = vec2(0,0)
		selection_rot = 0
		pos_br = vec2(0,0)
		sel_size = vec2(0,0)

		return id
	}
}