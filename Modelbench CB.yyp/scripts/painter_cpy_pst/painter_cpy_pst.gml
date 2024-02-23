///painter_cpy_pst()
function painter_cpy_pst() {
	if (keybinds[e_keybind.PASTE].pressed) {
		show_debug_message(view_area_x)
		if (clipboard_has_img()) {
			clipboard_dump_image(app.model_folder + "\\clipboard.png");
			
			var tempspr = sprite_add(app.model_folder + "\\clipboard.png", 1, false, false, 0, 0);

			var offset = vec2(mousexsnap, mouseysnap)
			offset[X] = snap(offset[X],1);
			offset[Y] = snap(offset[Y],1);
			offset[X] = clamp(offset[X], 0, texturewidth - sprite_get_width(tempspr))
			offset[Y] = clamp(offset[Y], 0, textureheight - sprite_get_height(tempspr))
			if (selection_moved) {
				surface_set_target(colorsurf);
				{
					draw_clear_alpha(c_black, 0);
					draw_sprite(colorspr, 0, 0, 0);

					alphafix
					shader_set(shader_premalpha);
					draw_surface(transformsurf, 0, 0);
					shader_reset();
					gpu_set_blendmode(bm_normal);
				}
				surface_reset_target();
				// Update the alpha mask.
				surface_set_target(alphasurf);
				{
					draw_clear(c_black);

					draw_sprite(alphaspr, 0, 0, 0);
					alphafix
					shader_set(shader_alphamask);
					draw_surface(transformsurf, 0, 0);
					shader_reset();

					gpu_set_blendmode(bm_normal);
				}
				surface_reset_target();

				if (sprite_exists(alphaspr)) {
					sprite_delete(alphaspr);
				}
				alphaspr = sprite_create_from_surface(alphasurf, 0, 0, surface_get_width(alphasurf), surface_get_height(alphasurf), false, false, 0, 0);

				if (sprite_exists(colorspr)) {
					sprite_delete(colorspr);
				}
				colorspr = sprite_create_from_surface(colorsurf, 0, 0, surface_get_width(colorsurf), surface_get_height(colorsurf), false, false, 0, 0);
				painter_create_finalspr()
			}


			surface_set_target(transformsurf);
			{
				draw_clear_alpha(c_black, 0);
				alphafix

				draw_sprite_ext(tempspr, 0, offset[X], offset[Y], 1, 1, 0, c_white, 1);

				gpu_set_blendmode(bm_normal);
			}
			surface_reset_target();
			if (sprite_exists(transformspr)) {
				sprite_delete(transformspr);
			}
			transformspr = sprite_create_from_surface(transformsurf, offset[X], offset[Y], sprite_get_width(tempspr), sprite_get_height(tempspr), false, false, 0, 0);
			surface_set_target(selectionsurf);
			{
				draw_clear(c_black);

				gpu_set_blendmode(bm_subtract);
				shader_set(shader_selectionmask);
				draw_sprite_ext(tempspr, 0, offset[X], offset[Y], 1, 1, 0, c_white, 1);
				shader_reset();
				gpu_set_blendmode(bm_normal);
			}
			surface_reset_target();

			if (sprite_exists(selectionspr)) {
				sprite_delete(selectionspr);
			}
			selectionspr = sprite_create_from_surface(selectionsurf, 0, 0, texturewidth, textureheight, false, false, 0, 0);
			selection_active = true;

			selection_topleft = vec2(offset[X], offset[Y]);
			selection_btmright = vec2(offset[X] + sprite_get_width(tempspr),offset[Y] +  sprite_get_height(tempspr));

			selectionsize = vec2(selection_btmright[0] - selection_topleft[0], selection_btmright[1] - selection_topleft[1]);
			painter_get_sel_trn_spr();
			selection_moved = true;
			paint_tool_selected = e_paint.TRANSFORM;
			sprite_delete(tempspr);
			painter_history_set("transform", finalspr, selectionspr, transformspr);

			#region dumped code
			// surface_set_target(colorsurf){
			// draw_clear_alpha(c_black, 0)
			// shader_set(shader_colormask)
			// draw_sprite(tempspr,0,0,0)
			// shader_reset()

			// gpu_set_blendmode(bm_normal);
			// }
			//	surface_reset_target()
			// surface_set_target(alphasurf){

			// draw_clear_alpha(c_black, 1)
			// shader_set(shader_alphamask)
			// alphafix
			// draw_sprite_ext(tempspr, 0,0,0,1,1,0, c_white, 1)
			// shader_reset()
			//   gpu_set_colorwriteenable(true, true, true, true);

			// gpu_set_blendmode(bm_normal);
			// }
			//	surface_reset_target()
			//	sprite_delete(tempspr)
			//	if(sprite_exists(colorspr))
			// sprite_delete(colorspr)
			// colorspr = sprite_create_from_surface(colorsurf, 0,0,surface_get_width(colorsurf), surface_get_height(colorsurf), false, false, 0, 0)
			//	if(sprite_exists(alphaspr))
			// sprite_delete(alphaspr)
			// alphaspr = sprite_create_from_surface(alphasurf, 0,0,surface_get_width(alphasurf), surface_get_height(alphasurf), false, false, 0, 0)
			#endregion

			sprite_delete(tempspr);
		}
	}
	if (keybinds[e_keybind.COPY].pressed && selection_active) {
		sprite_save(transformspr, 0, app.model_folder + "\\clipboard.png");
		clipboard_load_image(app.model_folder + "\\clipboard.png");
	}
	if (keybinds[e_keybind.CUT].pressed && selection_active) {
		sprite_save(transformspr, 0, app.model_folder + "\\clipboard.png");
		clipboard_load_image(app.model_folder + "\\clipboard.png");
		painter_clear_selection()
	    painter_create_finalspr();
	surface_set_target(selectionsurf){
		draw_clear_alpha(c_black,0)
		selection_topleft = vec2(0,0)
		selection_btmright = vec2(0,0)
		selection_active = false
	}
	surface_reset_target()
	}
}
