// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function painter_update(view, cam){
painter_update_surface(view, cam)
var boxx, boxy, boxw, boxh;	
painter_surf_require()
// Calculate box
#region Variables
	boxx = view_area_x
	boxy = view_area_y
	boxw = view_area_width
	boxh = view_area_height
	
	boxx = floor(boxx)
	boxy = floor(boxy)
	boxw = floor(boxw)
	boxh = floor(boxh)
	#endregion
#macro alphafix gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
painter_view();
scale_offset_x = floor(boxx + (boxw / 2 - (texturewidth / 2 + offx) * zoom))
scale_offset_y = floor(boxy + (boxh / 2 - (textureheight / 2 + offy) * zoom))
#region cpypsting
//if(keyboard_check_pressed(ord("V"))){
//	if(!clipboard_has_img()) return;
//	clipboard_dump_image(app.model_folder + "\\clipboard.png")

	
//	var tempspr = sprite_add(app.model_folder + "\\clipboard.png",1,false,false,0,0);
	
//surface_set_target(colorsurf){
//draw_clear_alpha(c_black, 0)
//shader_set(shader_colormask)
//draw_sprite(tempspr,0,0,0)
//shader_reset()

//gpu_set_blendmode(bm_normal);
//}
//	surface_reset_target()
//surface_set_target(alphasurf){

//draw_clear_alpha(c_black, 1)
//shader_set(shader_alphamask)
//alphafix
//draw_sprite_ext(tempspr, 0,0,0,1,1,0, c_white, 1)
//shader_reset()
//   gpu_set_colorwriteenable(true, true, true, true);

//gpu_set_blendmode(bm_normal);
//}
//	surface_reset_target()
//	sprite_delete(tempspr)
//	if(sprite_exists(colorspr))
//sprite_delete(colorspr)
//colorspr = sprite_create_from_surface(colorsurf, 0,0,surface_get_width(colorsurf), surface_get_height(colorsurf), false, false, 0, 0)
//	if(sprite_exists(alphaspr))
//sprite_delete(alphaspr)
//alphaspr = sprite_create_from_surface(alphasurf, 0,0,surface_get_width(alphasurf), surface_get_height(alphasurf), false, false, 0, 0)
//}
#endregion
//Undo,redo
painter_history();

#region MouseVariables
if(!keyboard_check_direct(vk_alt))
mousexsnap = snap((window_mouse_get_x()-scale_offset_x) /  zoom-.5 , 1)-.5
if(!keyboard_check_direct(vk_shift))
mouseysnap =  snap((window_mouse_get_y() -scale_offset_y) /  zoom-.5 ,1)-.5
if(!keyboard_check_direct(vk_alt))
prevmousexsnap =  snap(mouse_x_prev /  zoom-.5 ,1) -.5
if(!keyboard_check_direct(vk_shift))
prevmouseysnap =  snap(mouse_y_prev  /  zoom-.5 ,1) -.5
var inbounds = ((mousexsnap + 1) < texturewidth && (mouseysnap + 1) < textureheight && (mousexsnap + 1) > 0 && (mouseysnap + 1) > 0) && content_mouseon
#endregion

painter_update_tools();

render_set_culling(false)

if(inbounds){
//Color Picker
painter_tool_color_picker(mousexsnap, mouseysnap);
//Paint
surface_set_target(drawsurf){
painter_tool_draw(mousexsnap, mouseysnap,prevmousexsnap, prevmouseysnap);
}
surface_reset_target();
}
//Select
painter_tool_select(mousexsnap, mouseysnap,inbounds);
//Erase
painter_tool_erase(mousexsnap, mouseysnap,prevmousexsnap, prevmouseysnap,inbounds);
//Apply Draw
painter_draw_apply();
//floodfill
painter_tool_floodfill(mousexsnap, mouseysnap,inbounds);

painter_update_floodfill();



//Draw Painter BG
draw_gradient(content_x, content_y + content_height/3, content_width, content_height/1.5, c_accent, 0, 0,0.1,0.1)

#region BgCheckers
clip_begin(scale_offset_x, scale_offset_y, zoom*texturewidth, zoom*textureheight)
		draw_box(boxx, boxy, boxw, boxh, false, c_level_middle, 1)
			for (var i = 0; i < ceil(boxw/192); i++)
				for (var j = 0; j < ceil(boxh/192); j++)
					draw_image(spr_uv_editor_pattern, 0, boxx + (i * 192), boxy + (j * 192), 1, 1, c_text_main, .05)
clip_end()
#endregion

painter_get_final_sprite(inbounds);

painter_draw(mousexsnap,mouseysnap,inbounds);

mouse_x_prev = window_mouse_get_x() - scale_offset_x

mouse_y_prev = window_mouse_get_y() - scale_offset_y


render_set_culling(true)
}