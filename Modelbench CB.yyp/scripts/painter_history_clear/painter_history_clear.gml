// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function painter_history_clear(){
for(var i = 0; i< painter_history_amount; i++){
sprite_delete(painter_history[i])	
}
}