// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function painter_update_surface(view, cam){

	render_start(view.surface, cam, content_width, content_height)
	
	render_target = surface_require(render_target, render_width, render_height)
	


if(surface_exists(render_target)){
surface_set_target(render_target){
	draw_clear_alpha(c_black,0)
}
surface_reset_target()
}

	view.surface = render_done()
}