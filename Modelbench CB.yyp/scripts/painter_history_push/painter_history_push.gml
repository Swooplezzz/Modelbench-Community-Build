/// painter_history_push()

function painter_history_push()
{
	painter_history_amount++;
	for (var h = painter_history_amount; h > 0; h--)
		painter_history[h] = painter_history[h - 1]
}