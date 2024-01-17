// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function file_dialog_open_pallette(){
return file_dialog_open(text_get("filedialogopenpallette") + " (*.mipallette)|*.mipallette|", "", models_directory, text_get("filedialogopenpallettecaption"))
}