// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function action_painter_add_pallette_color(value){
	array_add(app.pallette_list[|value].color_list, app.paint_primary_color)
	pallettes_save()
}