// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function action_painter_add_pallette_color(value){
	array_add(app.pallette_list[|value].color_list, (app.painter_main_color = 1 ? app.paint_secondary_color : app.paint_primary_color))
	//pallettes_save()
}