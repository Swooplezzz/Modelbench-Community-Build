// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function painter_update_selection_bounds(){
selection_buffer = buffer_create(paint_texture_width * paint_texture_height * 4, buffer_fixed, 1);
buffer_get_surface(selection_buffer, selection_surf, 0);
var topleft = [1000000,1000000]
var btmright = [-1000000,-1000000]
for(var i = 0; i< paint_texture_width; i++){
	for(var j = 0; j< paint_texture_height; j++){
	var offset = 4 * (i + j * paint_texture_width);
    var selection = buffer_peek(selection_buffer, offset + 3, buffer_u8);
	if (selection != 255){
		topleft = [min(i, topleft[X]),min(j, topleft[Y])];
		btmright = [max(i, btmright[X]),max(j, btmright[Y])];
	}
    }
}
buffer_delete(selection_buffer);
selection_topleft = topleft;
btmright[X] += 1;
btmright[Y] += 1;
selection_btmright = btmright;

}