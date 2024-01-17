// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function action_painter_pallette_add(){
var struct =
{
name: "New Pallette",
color_list: array_create()
}

ds_list_add(pallette_list, struct)
pallettes_save()
}