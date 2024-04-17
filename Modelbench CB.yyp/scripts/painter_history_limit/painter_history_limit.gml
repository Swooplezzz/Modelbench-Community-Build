/// painter_history_limit(amount)
/// @arg amount

function painter_history_limit(amount)
{
	if (painter_history_amount > amount)
	{
		sprite_delete(painter_history[painter_history_amount]);
		painter_history_amount--;
	}
}