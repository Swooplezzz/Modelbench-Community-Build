/// painter_history_clear()

function painter_history_clear()
{
	for(var i = 0; i< painter_history_amount; i++)
	{
		sprite_delete(painter_history[i])	
	}
}