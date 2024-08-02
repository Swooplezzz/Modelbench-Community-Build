// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function palette_lospec_import(){
http_lospec_json = http_get(string("https://lospec.com/palette-list/", popup_lospec.tbx_name.text, ".json"))

}