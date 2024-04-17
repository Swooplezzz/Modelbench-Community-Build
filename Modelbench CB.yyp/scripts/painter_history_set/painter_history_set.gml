/// painter_history_set(value, sprite, selection_sprite, transparencysprite)
/// @arg value
/// @arg sprite
/// @arg selection_sprite
/// @arg transparencysprite

function painter_history_set(val, spr, selspr, trnspr)
{
	painter_history_pop()
	painter_history_push()
	painter_history[0] = new_painter_history(val);
	painter_history[0].sprite = sprite_duplicate(spr);
	painter_history[0].selsprite = sprite_duplicate(selspr);
	painter_history[0].trnsprite = sprite_duplicate(trnspr);
	painter_history[0].sel_size = selection_size;
	painter_history[0].pos_tl = vec2(selection_topleft[X], selection_topleft[Y]);
	painter_history[0].pos_br = vec2(selection_btmright[X], selection_btmright[Y]);
	painter_history[0].sel_active = selection_active;
	painter_history_limit(800)
}