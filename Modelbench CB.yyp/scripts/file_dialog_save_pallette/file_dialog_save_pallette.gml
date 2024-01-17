// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function file_dialog_save_pallette(){
return file_dialog_save(text_get("filedialogsavepallette") + " (*.mipallette)|*.mipallette|", "", models_directory, text_get("filedialogsavepallettecaption"))
}